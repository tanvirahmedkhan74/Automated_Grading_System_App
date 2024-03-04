const { google } = require("googleapis");
const authorize = require("../config/sheets");
const Assessment = require("../models/Assessement");

const generateRandomInteger = (min, max) => {
    if (min > max) {
      throw new Error("Minimum value cannot be greater than maximum value.");
    }
    const randomDecimal = Math.random();
  
    // Multiply the random number by the range (max - min + 1) and floor the result
    const randomInteger = Math.floor(randomDecimal * (max - min + 1)) + min;
  
    return randomInteger;
}

const extractSheetId = (sheetLink) => {
    let spreadSheetID = sheetLink.split('/d/');
    spreadSheetID = spreadSheetID[1].split('/edit');
    spreadSheetID = spreadSheetID[0];

    return spreadSheetID;
}

// Returns a 2d array of arrays containing answers, 0th index is the email
const extractAnswers = (response) => {

    let answers = [];

    for(let i=0;i<response?.length;i++){
        const ans = response[i].answers;
        let temp = []
        
        for (let j = 0; j < ans?.length; j++) {
            console.log(ans[j].textAnswers);
            temp.push(ans[j].textAnswers.answers[0].value);
        }
        answers.push(temp);
    }
    return answers;
}

const extractRubricData = (data) => {
    let questions = [];
    
    let rubrics = {}

    data?.forEach(q => {
        if(q[0] !== '-'){
            if(rubrics['question']){
                questions.push(rubrics);
            }
            rubrics = {}
            rubrics['question'] = q[0];
            rubrics['criteria'] = []
            rubrics['marks'] = []
        }

        rubrics['criteria'].push(q[2]);
        rubrics['marks'].push(q[3]);
    });

    if(rubrics['question']) questions.push(rubrics);

    return questions;
}

const extractRawSheetData = async (auth, spreadSheetId, range) => {
    const sheets = google.sheets({version: 'v4', auth});
    const res = await sheets.spreadsheets.values.get({
        spreadsheetId: spreadSheetId,
        range: range,
      });
    // console.log(res.data.values);
    
    return res.data.values;
}

const ExtractStudentSheetData = async (googleId, accessToken, sheetLink) => {
    const spreadSheetID = extractSheetId(sheetLink);
    const auth = await authorize(accessToken);

    const data = await extractRawSheetData(auth, spreadSheetID, 'A2:B4');
    let emails = [];

    data?.forEach(element => {
        emails.push(element[1]);
    });

    return emails;
}

const ExtractRubricSheetData = async (googleId, accessToken, sheetLink) => {
    const spreadSheetID = extractSheetId(sheetLink);
    const auth = await authorize(accessToken);

    const data = await extractRawSheetData(auth, spreadSheetID, 'A2:D7');
    const extractedData = extractRubricData(data);
    
    return extractedData;
}

const createMarkSheet = async (accessToken, assessmentId, qa) => {

    try {   
        // Create the sheet

        const auth = await authorize(accessToken);
        const sheets = google.sheets({ version: 'v4', auth });

        let spreadsheetId;
        const assessmentData = await Assessment.findById(assessmentId);
        console.log(assessmentData);
        
        if(assessmentData?.marksheetData){
            console.log('Updating Marks Spread sheet!');
            if(!qa){
                console.log('No Response From The Google Form Yet!');
                return;
            }
            
            const qs = qa.question;
            const ans = qa.answer;

            const mappedAnswers = [];
            ans.forEach((values, keys) => {
                const temp = [];
                
                qs.forEach((v, k) => {
                    const answer = values.get(k);
                    temp.push({ques: v, ans: answer});
                })

                mappedAnswers.push(temp);
            })

            // console.log(mappedAnswers);

            // Creating Google Sheet Array
            // ["MAIL", "Q1", "Q2", ... , "QN", "marksOfQues1", "marksOfQues12"...., "Total"]

            // Header of the sheet file
            // const headers = [];

            // qs.forEach((values, keys) => {
            //     if(values === 'Please Enter Your Email. This will be used for grading or else your marks will be lost'){
            //         headers.push("Mail");
            //     }else{
            //         headers.push(values);
            //     }
            // })
            // for(let i=1;i<qs.size;i++){
            //     headers.push('marksOfQues' + i);
            // }
            // headers.push('Totoal');
            
            // 2d Array of Values for the sheet file

            // const values = [];

            // mappedAnswers.forEach((item, key) => {
            //     const temp = [];
            //     item.forEach((i, k) => {
            //         temp.push(i.ans);
            //     })
            //     // Setting Random Marks
            //     for(let i=0;i<qs.size;i++){
            //         temp.push(2);
            //     }
            //     values.push(temp);
            // })

            // console.log(values);

            ////////////////////////////////////////////////////
            // ALTERNATE with Only Mail and Marks
            
            // Google Sheet Headers [mail, marksq1, marksq2 ...., marksqn, total]
            const headers = [];
            headers.push("mail");

            for(let i=1;i<qs.size;i++){
                headers.push("mark_q" + i);
            }

            headers.push("total");

            // Responses extracted from google form for marking
            const responses = [];
            mappedAnswers.forEach((v, k) => {
                const temp = [];

                temp.push(v[0].ans);
                let total = 0;
                for(let i=1;i<qs.size;i++){
                    const randomNumber = generateRandomInteger(0, 5);
                    total += randomNumber;

                    temp.push(randomNumber);
                }
                temp.push(total);
                responses.push(temp);
            })

            console.log(headers);
            console.log(responses);

            // Update
            spreadsheetId = assessmentData.marksheetData.data.spreadsheetId;

            const sheetBody = {
                values: [headers, ...responses]
            };
    
            const sheetCreationResponse = await sheets.spreadsheets.values.update({
                spreadsheetId,
                range: 'Sheet1',
                valueInputOption: 'RAW',
                resource: sheetBody
            });
    
            console.log('Sheet updated successfully.');
    
            // Save Spread Sheet Data
            const obj = {
                data: sheetCreationResponse.data,
                url: sheetCreationResponse.request.responseURL
            }
    
            await Assessment.updateOne({
                _id: assessmentData._id,
              }, {
                $set: {
                  marksheetData: obj
                }
              });
    
            console.log(sheetCreationResponse.data);
        }else{
            console.log('Creating Marks Spread Sheet');
            const spreadsheet = await sheets.spreadsheets.create({
                resource: {
                    properties: {
                        title: 'Mark Sheet' + assessmentId
                    }
                },
                fields: 'spreadsheetId'
            });

            spreadsheetId = spreadsheet.data.spreadsheetId;
            const obj = {
                data: spreadsheet.data,
                url: spreadsheet.request.responseURL
            }

            await Assessment.updateOne({
                _id: assessmentData._id,
              }, {
                $set: {
                  marksheetData: obj
                }
            });

            console.log('Sheet created successfully.');
        }
        
        return spreadsheetId;
    } catch (error) {
        console.log('Error while creating sheet for marks: ', error);
    }
}

module.exports = {ExtractStudentSheetData, ExtractRubricSheetData, createMarkSheet}
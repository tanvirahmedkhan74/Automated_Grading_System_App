const mongoose = require('mongoose')
const express = require('express');
const router = express.Router();
const User = require('../models/User');
const Assessment = require('../models/Assessement');
const { ExtractStudentSheetData, ExtractRubricSheetData } = require('../utils/GoogleSheet');
const SendFormLinkMail = require('../utils/Gmail');
const { createGoogleForm } = require('../utils/GoogleForms');
const { createAssessment, updateAssessment } = require('../utils/assessment');


// @desc    Get User Deails
// @route   GET /db/getUserById/

router.get('/getUserById/:userId', async (req, res) => {
    // From react, send a googleId and from mongodb send the details to the client side
    try {
        const id = req.params.userId;
        console.log(id);
        const user = await User.findOne({googleId: id});

        if(!user){
            res.status(404).json({message: 'Invalid User Id'});
        }else{
            res.status(200).json(user);
        }
    } catch (error) {
        console.log('Error while retrieving single user: ', error);
    }
});

// @desc    Get User's Assessments
// @route   GET /db/getAssessments/

router.get('/getAssessments/:userId', async (req, res) => {
    try{
        const id = req.params.userId;
        const response = await Assessment.find({googleId: id});
        
        if(response){
            res.status(200).json(response);
        }else{
            res.status(200).json({message: 'No assessment Yet'});
        }
        
    }catch(error){
        console.log('Error while retrieving Assessmens: ', error);
    }
})

// @desc    Save new Assessment
// @route   POST /db/saveAssessment/
router.post("/saveAssessment/:userId",async (req, res) => {
    try{
        const id = req.params.userId;

        // Get the Access Token
        const user = await User.findOne({
            googleId: id
        })
        const accessToken = user.accessToken;

        // Update or Creation
        const assessmentData = req.body;
        
        if(assessmentData.update){
            console.log('Updating');
            const response = await Assessment.updateOne({
                _id: assessmentData._id,
              }, {
                $set: {
                  title: assessmentData.title,
                  description: assessmentData.description,
                  rubricLink: assessmentData.rubricLink,
                  studentInfoLink: assessmentData.studentInfoLink,
                  startDate: Date(assessmentData.startDate),
                  endDate: assessmentData.endDate,
                  googleId: id
                }
              });

            if(response){
                res.status(200).json({message: 'Update Successful!'});
                const updateResponse = updateAssessment(id, accessToken, assessmentData);
            }else{
                res.status(200).json({message: 'Assessment creation failed'});
            }
        }else{
            const response = await Assessment.create({
                title: assessmentData.title,
                description: assessmentData.description,
                rubricLink: assessmentData.rubricLink,
                studentInfoLink: assessmentData.studentInfoLink,
                startDate: Date(assessmentData.startDate),
                endDate: assessmentData.endDate,
                googleId: id
            })

            if(response){
                const data = await Assessment.findById(response._id);
                
                res.status(200).json({message: 'Creation Successful'});
                const creationResponse = createAssessment(id, accessToken, data);
            }else{
                res.status(200).json({message: 'Assessment creation failed'});
            }
        }
    }catch(error){
        console.log('Error while Assessment creation: ', error);
    }
});
module.exports = router;
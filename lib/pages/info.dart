import 'package:flutter/material.dart';

class info extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<info> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _rubrics_LinkController = TextEditingController();
  TextEditingController _student_LinkController = TextEditingController();
  TextEditingController _start_DateController = TextEditingController();
  TextEditingController _end_dateController = TextEditingController();

  void _login() {
    String title = _titleController.text;
    String description = _descriptionController.text;
    String rubrics_Link = _rubrics_LinkController.text;
    String student_Link = _student_LinkController.text;
    String start_Date = _start_DateController.text;
    String end_date = _end_dateController.text;

    // Here you can add your authentication logic
    // For simplicity, let's just print the username and password
    print('Title: $title');
    print('Description: $description');
    print('Rubrics Link: $rubrics_Link');
    print('Student Link: $student_Link');
    print('Start Date: $start_Date');
    print('End Date: $end_date');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informations'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              //  obscureText: true,
            ),

            SizedBox(height: 20.0),
            TextField(
              controller: _rubrics_LinkController,
              decoration: InputDecoration(
                labelText: 'Rubcrics Link',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _student_LinkController,
              decoration: InputDecoration(
                labelText: 'Student Link',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _start_DateController,
              decoration: InputDecoration(
                labelText: 'Start Date',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _end_dateController,
              decoration: InputDecoration(
                labelText: 'End Date',
              ),
            ),
            //    SizedBox(height: 20.0),
            // ElevatedButton(
            //  onPressed: _login,
            //   child: Text('Login'),
            //   ),
          ],
        ),
      ),
    );
  }
}

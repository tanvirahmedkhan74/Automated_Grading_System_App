import 'package:flutter/material.dart';

class Assessment extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<Assessment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [
                  Color.fromARGB(235, 255, 255, 255),
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 255, 255, 255),
                ],
              ),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Assessments",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 150.0, // Adjust top padding as needed
            right: 30.0, // Adjust right padding as needed
            child: Column(
              mainAxisSize: MainAxisSize.min, // Keep the column contents compact
              children: [
                Text(
                  'New assessment',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0), fontSize: 15),
                ),
                const SizedBox(height: 10), // Add spacing between text and icon
                FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Color.fromARGB(255, 54, 152, 232),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
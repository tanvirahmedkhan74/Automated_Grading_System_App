import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // Future<void> logOut() async {
    //   final url = Uri.parse('http://localhost:8000/auth/logout');
    //   try {
    //     final response = await http.get(url);
    //     Navigator.pop(context);
    //     if (response.statusCode == 200) {
    //       Navigator.pop(context); // Assuming this navigates back to login
    //     } else {
    //       print('Logout request failed with status: ${response.statusCode}');
    //       // Display an appropriate error message to the user
    //     }
    //   } catch (error) {
    //     print('Error during logout: $error');
    //     // Display an error message to the user
    //   }
    // }
    Future<void> logOut() async {
      final url = Uri.parse('http://localhost:8000/auth/logout');
      // final response = await http.get(url);

      if (await canLaunchUrl(url)) {
        await launchUrl(url); // Open the extracted URL in the browser
        Navigator.pop(context);
      } else {
        // Handle the case where the URL cannot be launched
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to open URL'),
          ),
        );
      }
    }

    return Scaffold(
      // body: AnnotatedRegion<SystemUiOverlayStyle>(
      //value: SystemUiOverlayStyle.light,
      // child: GestureDetector(
      //  child: Stack(
      //  children: <Widget>[
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, colors: [
          Color.fromARGB(235, 121, 177, 255),
          Color.fromARGB(255, 124, 214, 232),
          Color.fromARGB(255, 71, 237, 255)
        ])),
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
                        "           Automated Grading System",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 25),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      //  FadeInUp(
                      //duration: Duration(milliseconds: 1300),
                      // SizedBox(
                      //  height: 10,
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 60,
                          ),

                          Center(
                            child: MaterialButton(
                              onPressed: () {},
                              height: 50,
                              color: Color.fromARGB(255, 134, 247, 255),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              child: Text(
                                "Profile",
                                style: TextStyle(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 15),
                              ),
                            ),
                          ),
                          //  Positioned(
                          //  bottom: 0.0, // Place at the bottom
                          //  right: 0.0, // Align to the right
                          //  child: Container(
                          //height: 50.0, // Set desired height
                          // width: 100.0, // Set desired width

                          //  ),

                          //   ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromRGBO(0, 0, 0, 1),
        child: MaterialButton(
          onPressed: () async {
            await logOut();
          },
          color: Color.fromARGB(255, 101, 215, 233),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center icon and text
            children: [
              Icon(Icons.logout),
              Text('Logout',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0), fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:welcome_299/pages/profile.dart';

//import 'package:http/http.dart' as http;
//import 'dart:convert';
//import 'package:login_app/screens/home_page.dart';

class LoginPage extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
        //  image: DecorationImage(
            //image: AssetImage ('assests/image/login.jpg')),

            gradient: LinearGradient(begin: Alignment.topLeft, colors: [
          Color.fromARGB(238, 196, 86, 255),
          Color.fromARGB(255, 226, 177, 255),
          Color.fromARGB(255, 99, 162, 230)
        ])),
        
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
          // SizedBox(
             //height: 80,
         // ),
            
            Padding(
           
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(
                   // duration: Duration(milliseconds: 1000), 
                   child: Text("Welcome!", style: TextStyle(color: Colors.white, fontSize: 40),)),
                  SizedBox(height: 10,),
                  FadeInUp(
                    //duration: Duration(milliseconds: 1300), 
                    child: Text("Please login to your account", style: TextStyle(color: Colors.white, fontSize: 18),)),
                    
                 // SizedBox(
                  //  height: 10,
                 // ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 249, 214, 255),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                      ),
                      FadeInUp(
                       //   duration: Duration(milliseconds: 1400),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(222, 84, 10, 0.298),
                                      blurRadius: 20,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                              
                                Container(
                                 
                                ),
                              ],
                            ),
                          )),
                      
                      SizedBox(
                        height: 40,
                      ),
                      FadeInUp(
                          //duration: Duration(milliseconds: 1600),
                          child: MaterialButton(
                            onPressed: () {
                               Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ProfileScreen()),
  );

                            },
                            height: 50,
                            // margin: EdgeInsets.symmetric(horizontal: 50),
                            color: Color.fromARGB(255, 121, 14, 157),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            
                            child: SlideInRight   (
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

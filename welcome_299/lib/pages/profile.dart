import 'package:flutter/material.dart';
import 'package:welcome_299/pages/info.dart';

class HalfOvalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0.0, 0.0);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.40, size.width, 0.5);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                  Color.fromARGB(235, 87, 2, 178),
                  Color.fromARGB(255, 167, 98, 236),
                  Color.fromARGB(255, 233, 205, 253),
                ],
              ),
            ),
          ),
          ClipPath(
            clipper: HalfOvalClipper(),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Column(
                  children: [
                    SizedBox(height: 80),
                    SizedBox(height: 20),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MaterialButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => info()));
                            },
                            height: 50,
                            color: Color.fromARGB(255, 126, 32, 214),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                            child: Text("Profile", style: TextStyle(color: Colors.black, fontSize: 15)),
                          ),
                          SizedBox(height: 10), // Added space for the image
                          Image.asset('assets/account.png', height: 6), // Image added below the profile button
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Logout", style: TextStyle(color: Colors.black, fontSize: 14)),
                SizedBox(height: 5),
                FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.logout),
                  backgroundColor: Color.fromARGB(255, 126, 32, 214),
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                ),
              ],
            ),
          ),
          Positioned(
            left:
                MediaQuery.of(context).size.width * 0.1,
            right:
                MediaQuery.of(context).size.width * 0.1,
            child:
                Center(
              child:
                  Text("Automated Grading System", style:
                      TextStyle(color:
                          Colors.black,
                          fontSize:
                              20,
                      ),
                  ),
              ),
          ),
        ],
      ),
    );
}
}
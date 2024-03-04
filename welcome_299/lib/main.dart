import 'package:flutter/material.dart';
import 'package:welcome_299/pages/info.dart';
import 'package:welcome_299/pages/Assessment.dart';
import 'package:welcome_299/pages/profile.dart';
import 'package:welcome_299/pages/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Click on your profile',
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/': (context) => ProfileScreen(),
          '/login': (context) => LoginPage(),
          '/Assessment': (context) => Assessment(),
          '/info': (context) => info(),
        });
  }
}

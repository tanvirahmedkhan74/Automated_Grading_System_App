import 'package:flutter/material.dart';
import 'package:welcome_299/pages/signin.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

Future<void> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    // Handle successful sign-in
  } catch (error) {
    // Handle sign-in error
  }
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
}
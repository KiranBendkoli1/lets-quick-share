import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  // Sign Up Method
  Future signUp(
      {required String email,
      required String password,
      required String name}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _auth.currentUser!.updateDisplayName(name);
      Fluttertoast.showToast(
        msg: "Sign Up Successful",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blueGrey,
        fontSize: 12,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.message.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blueGrey,
        fontSize: 12,
      );
      return e.message;
    }
  }

  // Sign In Method
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Fluttertoast.showToast(
        msg: "Sign In Successful",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blueGrey,
        fontSize: 12,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.message.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blueGrey,
        fontSize: 12,
      );
      return e.message;
    }
  }

  // Sign Out Method
  Future signOut() async {
    await _auth.signOut();
    Fluttertoast.showToast(
      msg: "User Signed Out",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blueGrey,
      fontSize: 12,
    );
  }
}

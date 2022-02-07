// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lets_quick_share/signin.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyDtfaZuOOBqXsoPPdq4F6qVXTWLQt2Z6Ls',
          appId: '1:66646796269:web:cbe1e658c7076ab4fce9e4',
          messagingSenderId: "G-5NNFN9WCYV",
          projectId: "lets-quick-share")); // Initialization of firebase app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Lets Quick Share",
      home: SignIn(),
    );
  }
}

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lets_quick_share/authentication.dart';
import 'package:lets_quick_share/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Lets Quick Share",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Lets Quick Share"),
        ),
        body: Container(
          child: Text("Hello Wolrd"),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("LogOut"),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('loggedIn', false);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                  AuthenticationHelper().signOut();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

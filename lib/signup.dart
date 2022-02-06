// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:lets_quick_share/authentication.dart';
import 'package:lets_quick_share/homepage.dart';
import 'package:lets_quick_share/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var email = "", password = "";
  TextEditingController _emailContoroller = TextEditingController();
  TextEditingController _passwordContoroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkSignIn();
  }

  void checkSignIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('loggedIn');
    if (isLoggedIn == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp Page"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _emailContoroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        label: Text("Email Address"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _passwordContoroller,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                        label: Text("Password"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                    ),
                    onPressed: () {
                      email = _emailContoroller.text;
                      password = _passwordContoroller.text;
                      setState(() {});
                      AuthenticationHelper()
                          .signUp(email: email, password: password)
                          .then((result) async {
                        if (result == null) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setBool('loggedIn', true);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (contex) => HomePage(),
                            ),
                          );
                        } else {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                result,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        }
                      });
                    },
                    child: Text(
                      'SignUp',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Already a member, Click here to Login.",
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_final_fields, prefer_const_constructors

import "package:flutter/material.dart";
import 'package:lets_quick_share/authentication.dart';
import 'package:lets_quick_share/homepage.dart';
import 'package:lets_quick_share/signup.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var email = "", password = "";
  TextEditingController _emailContoroller = TextEditingController();
  TextEditingController _passwordContoroller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("SignIn Page"),
      ),
      body: Center(child: rfunction(width)),
    );
  }

  Widget rfunction(width) {
    if (width > 950)
      return myContainer(width, 0.6);
    else if (width > 600)
      return myContainer(width, 0.8);
    else
      return myContainer(width, 1);
  }

  Widget myContainer(width, per) {
    return SizedBox(
      width: width * per,
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
                        .signIn(email: email, password: password)
                        .then((result) async {
                      if (result == null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      }
                    });
                  },
                  child: Text(
                    'SignIn',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUp(),
                      ),
                    );
                  },
                  child: Text(
                    "Not a member, Click here to Sign Up.",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

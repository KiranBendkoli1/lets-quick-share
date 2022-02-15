// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  var email = "", password = "", name = "";
  TextEditingController _nameContoroller = TextEditingController();
  TextEditingController _emailContoroller = TextEditingController();
  TextEditingController _passwordContoroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    //checkSignIn();
  }

  // void checkSignIn() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool? isLoggedIn = prefs.getBool('loggedIn');
  //   if (isLoggedIn == true) {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => HomePage(),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp Page"),
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
                    controller: _nameContoroller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      label: Text("Full Name"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
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
                    name = _nameContoroller.text;
                    setState(() {});
                    AuthenticationHelper()
                        .signUp(email: email, password: password, name: name)
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
                    "Already a member, Then go to Sign In.",
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

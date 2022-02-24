import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lets_quick_share/homepage.dart';

class DataClass {
  final String data1;

  const DataClass(this.data1);
}

class IntentAddData extends StatelessWidget {
  final String text;
  const IntentAddData({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: TextFormField(
              initialValue: text,
              maxLines: 20,
              decoration: const InputDecoration(
                hintText: "Enter/Paste your text here: ",
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              var firebaseUser = FirebaseAuth.instance.currentUser;
              FirebaseFirestore.instance
                  .collection(firebaseUser!.uid)
                  .add({'text': text});
              var showToast = Fluttertoast.showToast(
                msg: "Data uploaded",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.blueGrey,
                fontSize: 12,
              );
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            child: RichText(
                text: const TextSpan(children: [
              WidgetSpan(
                child: Icon(Icons.cloud_upload),
              ),
              TextSpan(
                text: "  Upload",
                style: TextStyle(color: Colors.blue),
              ),
            ])),
          )
        ]),
      ),
    );
  }
}

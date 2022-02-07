import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:lets_quick_share/homepage.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  String txt = "";
  TextEditingController _txtEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: TextField(
              controller: _txtEditingController,
              maxLines: 20,
              decoration: const InputDecoration(
                  hintText: "Enter/Paste your text here: "),
            ),
          ),
          TextButton(
            onPressed: () {
              txt = _txtEditingController.text;
              var firebaseUser = FirebaseAuth.instance.currentUser;
              FirebaseFirestore.instance
                  .collection(firebaseUser!.uid)
                  .add({'text': txt});
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            child: RichText(
                text: const TextSpan(children: [
              const WidgetSpan(
                child: const Icon(Icons.cloud_upload),
              ),
              TextSpan(
                  text: "  Upload", style: const TextStyle(color: Colors.blue)),
            ])),
          )
        ]),
      ),
    );
  }
}

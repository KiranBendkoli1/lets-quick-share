import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lets_quick_share/pdf_section.dart';

class AddPDF extends StatefulWidget {
  const AddPDF({Key? key}) : super(key: key);

  @override
  State<AddPDF> createState() => _AddPDFState();
}

class _AddPDFState extends State<AddPDF> {
  String? fileName = null;
  File? file;
  UploadTask? task;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload File"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () => selectFile(),
                child: RichText(
                    text: TextSpan(children: [
                  WidgetSpan(
                    child: Icon(Icons.link),
                  ),
                  TextSpan(
                    text: "Select File",
                  )
                ])),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                fileName ?? "No File Selected",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 48,
              ),
              ElevatedButton(
                onPressed: () => uploadFile(),
                child: RichText(
                    text: TextSpan(children: [
                  WidgetSpan(
                    child: Icon(Icons.upload_file),
                  ),
                  TextSpan(
                    text: "Upload File",
                  )
                ])),
              ),
              SizedBox(
                height: 20,
              ),
              task != null ? buildUploadStatus(task) : Text(""),
            ],
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path;
    fileName = result.files.single.name;
    setState(() {
      file = File(path!);
    });
  }

  User? getFirebaseUser() {
    var user = FirebaseAuth.instance.currentUser;
    return user;
  }

  Future uploadFile() async {
    if (file == null) return;
    task = uploadToFirebase('${getFirebaseUser()!.uid}/$fileName', file);
  }

  uploadToFirebase(String destination, File? file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      ref.putFile(file!).then((p0) {
        Fluttertoast.showToast(
          msg: "File Uploaded",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blueGrey,
          fontSize: 12,
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => PDFSection()));
      });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blueGrey,
        fontSize: 12,
      );
    }
  }

  Widget buildUploadStatus(UploadTask? task) => StreamBuilder<TaskSnapshot>(
      stream: task!.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final snap = snapshot.data!;
          final progress = snap.bytesTransferred / snap.totalBytes;
          final percentage = (progress * 100).toStringAsFixed(2);
          return Text('$percentage%');
        } else {
          return Container();
        }
      });
}

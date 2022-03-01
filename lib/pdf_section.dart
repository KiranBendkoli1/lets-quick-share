// ignore_for_file: unused_local_variable

import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lets_quick_share/add_pdf.dart';

class PDFSection extends StatefulWidget {
  const PDFSection({Key? key}) : super(key: key);

  @override
  _PDFSectionState createState() => _PDFSectionState();
}

class _PDFSectionState extends State<PDFSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Section"),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AddPDF(),
            ),
          );
        },
        child: Icon(Icons.file_upload),
      ),
    );
  }
}

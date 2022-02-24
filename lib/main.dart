// ignore_for_file: pconst_constructors

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_quick_share/homepage.dart';
import 'package:lets_quick_share/signin.dart';
import 'package:lets_quick_share/users_data.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'initfb.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await fb();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription _intentData;
  String? data1;

  @override
  void initState() {
    super.initState();

    // when app running in background
    _intentData = ReceiveSharingIntent.getTextStream().listen(
      (String value) {
        setState(() {
          data1 = value;
        });
      },
    );

    // when app is closed in background
    ReceiveSharingIntent.getInitialText().then((String? value) {
      setState(() {
        data1 = value;
      });
    });
  }

  @override
  void dispose() {
    // implement dispose
    _intentData.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isnull = data1;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      title: "Lets Quick Share",
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              if (isnull != null) {
                return IntentAddData(text: data1.toString());
              }
              return HomePage();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SignIn();
        },
      ),
    );
  }
}

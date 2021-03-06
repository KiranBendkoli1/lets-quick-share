// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:lets_quick_share/add_data.dart';
import 'package:lets_quick_share/authentication.dart';
import 'package:lets_quick_share/signin.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  User? getFirebaseUser() {
    var user = FirebaseAuth.instance.currentUser;
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lets Quick Share"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(getFirebaseUser()!.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView(
                children: snapshot.data!.docs.map((e) {
                  return Column(children: [
                    Center(
                      child: SelectableText(
                        e['text'],
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: e['text']));
                              Fluttertoast.showToast(
                                msg: "Copied to Clipboard",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                fontSize: 12,
                              );
                            },
                            icon: Icon(
                              Icons.copy,
                              size: 16,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.launch_rounded,
                              // color: Theme.of(context).primaryColor,
                              size: 16,
                            ),
                            onPressed: () async {
                              var url = e['text'];
                              if (await canLaunch(url)) {
                                launch(url);
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Could not Launch '$url' ",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor:
                                      Theme.of(context).primaryIconTheme.color,
                                  fontSize: 12,
                                );
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.share,
                              size: 16,
                            ),
                            onPressed: () {
                              Share.share(e['text']);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete_outlined,
                              size: 16,
                            ),
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection(getFirebaseUser()!.uid)
                                  .doc(e.id)
                                  .delete();
                              Fluttertoast.showToast(
                                msg: "Deleted",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor:
                                    Theme.of(context).primaryIconTheme.color,
                                fontSize: 12,
                              );
                            },
                          )
                        ]),
                    Divider()
                  ]);
                }).toList(),
              );
            }),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                "",
              ),
              accountEmail: Text(
                getFirebaseUser()!.email.toString(),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Sign Out"),
              onTap: () async {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => SignIn()));
                AuthenticationHelper().signOut();
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddData(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

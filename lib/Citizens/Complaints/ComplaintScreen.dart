import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_app/Citizens/Complaints/AddComplaint.dart';
import 'package:flutter_new_app/Citizens/Complaints/Detail.dart';
import 'package:flutter_new_app/Citizens/Complaints/ProfilePage.dart';
import 'package:flutter_new_app/Citizens/Complaints/Register.dart';
import 'package:flutter_new_app/Citizens/Complaints/CitizensViewStatus.dart';
import 'package:flutter_new_app/email_signup.dart';
import 'package:flutter_new_app/services/crud2.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ComplaintScreen extends StatefulWidget {
  final String currentUserId;

  const ComplaintScreen({Key key, this.currentUserId}) : super(key: key);
  @override
  _ComplaintScreenState createState() => _ComplaintScreenState(currentUserId);
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  _ComplaintScreenState(this.currentUserId);

  final String currentUserId;

  bool isLoading = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Crud2Methods crud2methods = new Crud2Methods();
  Stream schemeStream;

  List<Choice> choices = const <Choice>[
    const Choice(title: 'View Status', icon: Icons.done_all_sharp),
    const Choice(title: 'Settings', icon: Icons.settings),
    const Choice(title: 'Log out', icon: Icons.exit_to_app),
  ];

  void onItemMenuPress(Choice choice) {
    if (choice.title == 'Log out') {
      handleSignOut();
    }
    if (choice.title == 'Settings') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfilePage()));
    }
    if (choice.title == 'View Status') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ViewStatusPage()));
    }
  }

  Future<bool> onBackPress() {
    openDialog();
    return Future.value(false);
  }

  Future<Null> openDialog() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding:
                EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                height: 100.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.exit_to_app,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(bottom: 10.0),
                    ),
                    Text(
                      'Exit app',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Are you sure to exit app?',
                      style: TextStyle(color: Colors.white70, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 0);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.cancel,
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                    ),
                    Text(
                      'CANCEL',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 1);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.check_circle,
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                    ),
                    Text(
                      'YES',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          );
        })) {
      case 0:
        break;
      case 1:
        exit(0);
        break;
    }
  }

  Future<Null> handleSignOut() async {
    this.setState(() {
      isLoading = true;
    });

    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();

    this.setState(() {
      isLoading = false;
    });

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false);
  }

  // ignore: non_constant_identifier_names
  Widget SchemeList() {
    return Container(
      child: schemeStream != null
          ? StreamBuilder(
              stream: schemeStream,
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return SchemeTile(
                              Name: snapshot.data.docs[index].data()['Name'],
                              complaint:
                                  snapshot.data.docs[index].data()["complaint"],
                              Address:
                                  snapshot.data.docs[index].data()['Address'],
                              phone: snapshot.data.docs[index].data()['phone'],
                              id: snapshot.data.docs[index]
                                  .data()[currentUserId],
                              CID: snapshot.data.docs[index].data()['CID'],
                              details:
                                  snapshot.data.docs[index].data()['details']);
                        });
              },
            )
          : Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
    );
  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  void getData() async {
    await crud2methods.getData().then((result) {
      setState(() {
        schemeStream = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFeaffd0),
      appBar: AppBar(
        actions: [
          PopupMenuButton<Choice>(
            onSelected: onItemMenuPress,
            itemBuilder: (BuildContext context) {
              return choices.map((Choice choice) {
                return PopupMenuItem<Choice>(
                    value: choice,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          choice.icon,
                        ),
                        Container(
                          width: 10.0,
                        ),
                        Text(
                          choice.title,
                        ),
                      ],
                    ));
              }).toList();
            },
          ),
        ],
        title: Text('Complaints'),
        backgroundColor: Color(0xFFf38181),
      ),
      body: SchemeList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddComplaint()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color(0xffFAAC98),
      ),
    );
  }
}

// ignore: must_be_immutable
// ignore: non_constant_identifier_names
// ignore: must_be_immutable
class SchemeTile extends StatelessWidget {
  // ignore: non_constant_identifier_names
  String Name, Address, phone, complaint, id, details, CID;

  SchemeTile(
      {
      // ignore: non_constant_identifier_names
      @required this.Address,
      // ignore: non_constant_identifier_names
      @required this.Name,
      @required this.complaint,
      @required this.phone,
      @required this.details,
      // ignore: non_constant_identifier_names
      @required this.id,
      // ignore: non_constant_identifier_names
      @required this.CID});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          color: Color(0xFFffffff),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Name: $Name',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 300,
                            child: Text(
                              'Address: $Address',
                              style: TextStyle(
                                  fontSize: 0, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Text(
                              'Mobile: $phone',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'ID:$CID',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Text(
                              'Complaint: $complaint',
                              style: TextStyle(
                                  fontSize: 0, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Details: $details',
                        style: TextStyle(
                            fontSize: 0, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

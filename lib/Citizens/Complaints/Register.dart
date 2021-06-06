import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_app/Citizens/Complaints/ComplaintScreen.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final googleSignIn = GoogleSignIn();
  final firebaseAuth = FirebaseAuth.instance;
  bool pageInitialized = false;

  @override
  void initState() {
    checkIfUserIsLoggedIn();
    super.initState();
  }

  checkIfUserIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool userLoggedIn = prefs.getBool('ID') ?? false;
    if (userLoggedIn) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ComplaintScreen(
                currentUserId: 'User.uid',
              )));
    } else {
      setState(() {
        pageInitialized = true;
      });
    }
  }

  handleSignIn() async {
    final res = await googleSignIn.signIn();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = await res.authentication;
    final credentials = GoogleAuthProvider.credential(
        idToken: auth.idToken, accessToken: auth.accessToken);
    final firebaseUser =
        (await firebaseAuth.signInWithCredential(credentials)).user;

    if (firebaseUser != null) {
      final result = (await FirebaseFirestore.instance
              .collection('citizens')
              .where('id', isEqualTo: firebaseUser.uid)
              .get())
          .docs;

      if (result.length == 0) {
        ///new user
        FirebaseFirestore.instance
            .collection('citizens')
            .doc(firebaseUser.uid)
            .set({
          "id": firebaseUser.uid,
          "name": firebaseUser.displayName,
          "profile_pic": firebaseUser.photoURL,
          "created_at": DateTime.now().millisecondsSinceEpoch,
        });
        prefs.setString("id", firebaseUser.uid);
        prefs.setString("name", firebaseUser.displayName);
        prefs.setString("profile_pic", firebaseUser.photoURL);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ComplaintScreen(
                  currentUserId: '',
                )));
      } else {
        ///Old user
        prefs.setString("id", result[0]["id"]);
        prefs.setString("name", result[0]["name"]);
        prefs.setString("profile_pic", result[0]["profile_pic"]);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ComplaintScreen(
                  currentUserId: '',
                )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfff38181),
          title: Text('Sign in with Google'),
          centerTitle: true,
        ),
        body: Container(
          width: 500,
          height: 720,
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Image.asset('assets/images/complaintscreenpic.png'),
                  ],
                ),
              ),
              Text(
                'Got any complaints?',
                style: TextStyle(fontSize: 30),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0, left: 0.0),
                child: SizedBox(
                  width: 300,
                  height: 140,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Text(
                            'Join to certify your complaints',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        (pageInitialized)
                            ? Center(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xffff8882)),
                                    onPressed: () {
                                      handleSignIn();
                                    },
                                    child: Text('sign-in')),
                              )
                            : Center(child: CircularProgressIndicator()),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'adminpage.dart';

class AdminSign extends StatefulWidget {
  @override
  _AdminSignState createState() => _AdminSignState();
}

class _AdminSignState extends State<AdminSign> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  String _adminemail;
  String _adminpassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffffffff),
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Color(0xff95e1d3),
            title: Text(
              "Login",
              style: TextStyle(color: Colors.black),
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                child: Padding(
                  padding: const EdgeInsets.only(top: 38.0),
                  child: Center(
                    child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                            child: Column(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Email Address",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _adminemail = value.trim();
                                  });
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _adminpassword = value.trim();
                                  });
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: isLoading
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color(0xfff38181))),
                                    onPressed: () async {
                                      try {
                                        await FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                                email: _adminemail,
                                                password: _adminpassword);
                                        Route route = MaterialPageRoute(
                                            builder: (c) => AdminPage());
                                        Navigator.pushReplacement(
                                            context, route);
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'user-not-found') {
                                          print(
                                              'No user found for that email.');
                                          Fluttertoast.showToast(
                                              msg:
                                                  "No user found for that email.",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        } else if (e.code == 'wrong-password') {
                                          print(
                                              'Wrong password provided for that user.');
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Wrong password provided for that user.",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      }
                                    },
                                    child: Text('Submit'),
                                  ),
                          )
                        ]))),
                  ),
                ),
              ),
              Image.network(
                'https://res.cloudinary.com/dok0wwyum/image/upload/v1623090738/undraw_Dashboard_re_3b76_edcmxe.png',
                width: 350,
              )
            ],
          ),
        ));
  }
}

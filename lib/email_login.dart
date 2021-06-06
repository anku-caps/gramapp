import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Staffs/home.dart';

class EmailLogIn extends StatefulWidget {
  @override
  _EmailLogInState createState() => _EmailLogInState();
}

class _EmailLogInState extends State<EmailLogIn> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffffffff),
        appBar:
            AppBar(backgroundColor: Color(0xff95e1d3), title: Text("Login")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('GPA makes your life and work better.'),
              ),
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
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: "Email Address",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter Email Address';
                                } else if (!value.contains('@')) {
                                  return 'Please enter a valid email address!';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                labelText: "Password",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter Password';
                                } else if (value.length < 6) {
                                  return 'Password must be atleast 6 characters!';
                                }
                                return null;
                              },
                            ),
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
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        logInToFb();
                                      }
                                    },
                                    child: Text('Submit'),
                                  ),
                          )
                        ]))),
                  ),
                ),
              ),
              Container(child: Image.asset('assets/images/app1.png'))
            ],
          ),
        ));
  }

  void logInToFb() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((firebaseUser) {
      isLoading = false;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => StaffHome(uid: firebaseUser.user.uid)),
      );
    }).catchError((err) {
      print(err.message);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                ElevatedButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }
}

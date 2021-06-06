import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'email_login.dart';
import 'email_signup.dart';

class SignUp extends StatelessWidget {
  final String title = "Sign Up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfff38181),
          title: Text(this.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/images/app2.png'),
              Padding(
                padding: const EdgeInsets.only(top: 68.0),
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Hello Staff",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  fontFamily: 'Libre Baskerville')),
                        ),
                        Padding(
                            padding: EdgeInsets.all(10.0),
                            child: SignInButton(
                              Buttons.Email,
                              text: "Sign up with Email",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EmailSignUp()),
                                );
                              },
                              elevation: 10,
                            )),
                        Padding(
                            padding: EdgeInsets.all(10.0),
                            child: GestureDetector(
                                child: Text("Log In Using Email",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff000000))),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EmailLogIn()),
                                  );
                                })),
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 208.0, top: 90),
                child: Container(
                  width: 160.0,
                  height: 160.0,
                ),
              ),
            ],
          ),
        ));
  }
}

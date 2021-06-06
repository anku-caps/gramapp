import 'package:flutter/material.dart';

class DeveloperContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff95e1d3),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Contact Us',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Icon(Icons.email_rounded),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Text(
                            ' gpa4all@gmail.com',
                            style: TextStyle(fontSize: 20),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Icon(Icons.local_phone_rounded),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Text(
                            '9947706476',
                            style: TextStyle(fontSize: 20),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

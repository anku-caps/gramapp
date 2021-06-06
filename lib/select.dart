import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_new_app/ADMIN/login.dart';
import 'package:flutter_new_app/Citizens/citizenhome.dart';
import 'package:flutter_new_app/signup.dart';

import 'Citizens/citizenhome.dart';

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Center(
                child: Text(
                  'Select Your User Type',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            SizedBox(
              width: 400,
              child: InkWell(
                onDoubleTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CitizenHome()));
                },
                child: Card(
                  elevation: 10,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/peoplepic.png',
                        width: 220,
                        height: 220,
                      ),
                      Text(
                        'Citizen',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 400,
              child: InkWell(
                onDoubleTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: Card(
                  elevation: 10,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/worker1.png',
                        width: 220,
                        height: 220,
                      ),
                      Text(
                        'Staff',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 400,
              child: InkWell(
                onDoubleTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminSign()));
                },
                child: Card(
                  elevation: 10,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/admin.png',
                        width: 220,
                        height: 220,
                      ),
                      Text(
                        'Admin',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

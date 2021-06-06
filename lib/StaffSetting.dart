import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StaffSetting extends StatelessWidget {
  StaffSetting({this.uid});
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 58.0, left: 60),
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 70),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                  height: 80,
                ),
              ),
              Text('Gram Panchayat App'),
            ],
          ),
        ),
      ),
    );
  }
}

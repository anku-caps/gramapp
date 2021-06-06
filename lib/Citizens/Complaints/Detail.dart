import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_app/services/crud2.dart';

class DetailScreen extends StatefulWidget {
  final String value, value1, value2, value3, value4;

  const DetailScreen(
      {Key key, this.value, this.value1, this.value2, this.value3, this.value4})
      : super(key: key);
  @override
  _DetailScreenState createState() =>
      _DetailScreenState(value, value1, value2, value3, value4);
}

class _DetailScreenState extends State<DetailScreen> {
  final String value, value1, value2, value3, value4;

  _DetailScreenState(
      this.value, this.value1, this.value2, this.value3, this.value4);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff95e1d3),
        title: Text('Complaint In Detail'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Container(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 30.0),
                child: Text(
                  'Name: ${widget.value}',
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                child: Text(
                  'Address: ${widget.value2}',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                child: Text(
                  'Mobile: ${widget.value3}',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                child: Text(
                  'Subject: ${widget.value4}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 40.0),
                child: SizedBox(
                    child: Text(
                  'Details: ${widget.value1}',
                  style: TextStyle(fontSize: 20),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

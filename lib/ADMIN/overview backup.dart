import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Overview extends StatelessWidget {
  const Overview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children : <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.all(5),
              width: double.infinity,
              height: 75,
              decoration: BoxDecoration(color: Colors.amber),
              child: Row(
                children: [
                  Text("Number of Citizens : ", style: TextStyle(
                    fontSize: 20,
                  ),
                  ),
                  Text("Hey", style: TextStyle(
                    fontSize: 20,
                  ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.all(5),
              width: double.infinity,
              height: 75,
              decoration: BoxDecoration(color: Colors.amber),
              child: Text("Number of Staff", style: TextStyle(
                fontSize: 20,
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdminOverview extends StatelessWidget {
  const AdminOverview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("citizens").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot1) {
        if (snapshot1.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot1.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection("complaints").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {
            if (snapshot2.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot2.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("Events").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot3) {
                if (snapshot3.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot3.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 88.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          width: double.infinity,
                          child: Card(
                              color: Color(0xff95e1d3),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Text(
                                      "Number of Citizens",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${snapshot1.data.size}",
                                        style: TextStyle(fontSize: 60)),
                                  ),
                                ],
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          width: double.infinity,
                          child: Card(
                              color: Color(0xfff38181),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Text(
                                      "Number of Complaints",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${snapshot2.data.size}",
                                        style: TextStyle(fontSize: 60)),
                                  ),
                                ],
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          width: double.infinity,
                          child: Card(
                              color: Color(0xfffce38a),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Text(
                                      "Number of Events",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${snapshot3.data.size}",
                                        style: TextStyle(fontSize: 60)),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

import 'dart:developer';

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_new_app/Citizens/Complaints/Detail.dart';

import 'package:flutter_new_app/Staffs/COMPLAINTS/presentation/pages/StatusView.dart';

import 'package:flutter_new_app/services/crud2.dart';

class ComplaintViewStaff extends StatefulWidget {
  final String currentUserId;

  const ComplaintViewStaff({Key key, this.currentUserId}) : super(key: key);
  @override
  _ComplaintViewStaffState createState() =>
      _ComplaintViewStaffState(currentUserId);
}

class _ComplaintViewStaffState extends State<ComplaintViewStaff> {
  _ComplaintViewStaffState(this.currentUserId);

  final String currentUserId;
  bool isLoading = false;

  Crud2Methods crud2methods = new Crud2Methods();
  Stream schemeStream;

  // ignore: non_constant_identifier_names
  Widget SchemeList() {
    return Container(
      child: schemeStream != null
          ? StreamBuilder(
              stream: schemeStream,
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return SchemeTile(
                              Name: snapshot.data.docs[index].data()['Name'],
                              complaint:
                                  snapshot.data.docs[index].data()["complaint"],
                              Address:
                                  snapshot.data.docs[index].data()['Address'],
                              phone: snapshot.data.docs[index].data()['phone'],
                              id: snapshot.data.docs[index]
                                  .data()[currentUserId],
                              CID: snapshot.data.docs[index].data()['CID'],
                              details:
                                  snapshot.data.docs[index].data()['details']);
                        });
              },
            )
          : Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
    );
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    await crud2methods.getData().then((result) {
      setState(() {
        schemeStream = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFeaffd0),
        appBar: AppBar(
          backgroundColor: Color(0xFFf38181),
          title: Text(
            'Complaints',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [],
        ),
        body: SchemeList(),
        floatingActionButton: SizedBox(
          width: 150,
          height: 100,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StatusViewPage()));
            },
            child: Text(
              'Status',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            backgroundColor: Color(0xfffce38a),
          ),
        ));
  }
}

// ignore: must_be_immutable
// ignore: non_constant_identifier_names
// ignore: must_be_immutable
class SchemeTile extends StatelessWidget {
  // ignore: non_constant_identifier_names
  String Name, Address, phone, complaint, id, details, CID;

  SchemeTile(
      // ignore: non_constant_identifier_names
      {@required this.Address,
      // ignore: non_constant_identifier_names
      @required this.Name,
      @required this.complaint,
      @required this.phone,
      @required this.details,
      @required this.id,
      // ignore: non_constant_identifier_names
      @required this.CID});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(
                    value: Name,
                    value1: details,
                    value2: Address,
                    value3: phone,
                    value4: complaint)));
      },
      child: Card(
        color: Color(0xFFffffff),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Name: $Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 300,
                          child: Text(
                            'Address: $Address',
                            style: TextStyle(
                                fontSize: 0, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Row(
                        children: [
                          Text(
                            'Mobile: $phone',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 98.0),
                            child: Icon(Icons.arrow_forward_ios_rounded),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Text(
                            'ID: $CID',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Text(
                            'Complaint: $complaint',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Details: $details',
                      style:
                          TextStyle(fontSize: 0, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

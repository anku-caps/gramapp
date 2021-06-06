// ignore: avoid_web_libraries_in_flutter
import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_new_app/Staffs/SCHEMES/addscheme_screen.dart';
import 'package:flutter_new_app/services/crud1.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:url_launcher/url_launcher.dart';

class StaffScheme extends StatefulWidget {
  @override
  _StaffSchemeState createState() => _StaffSchemeState();
}

class _StaffSchemeState extends State<StaffScheme> {
  Crud1Methods crud1Methods = new Crud1Methods();
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
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        itemCount: snapshot.data.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return SchemeTile(
                            schemeName:
                                snapshot.data.docs[index].data()['schemeName'],
                            descr: snapshot.data.docs[index].data()["descr"],
                            lastdate:
                                snapshot.data.docs[index].data()['lastdate'],
                            fileUrl:
                                snapshot.data.docs[index].data()['fileUrl'],
                          );
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
    await crud1Methods.getData().then((result) {
      setState(() {
        schemeStream = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      appBar: AppBar(
        backgroundColor: Color(0xFFf38181),
        title: Text(
          'Schemes',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SchemeList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddScheme()));
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Color(0xfffce38a),
      ),
    );
  }
}

// ignore: must_be_immutable
class SchemeTile extends StatelessWidget {
  String fileUrl, lastdate, descr, schemeName;
  SchemeTile(
      {@required this.fileUrl,
      @required this.lastdate,
      @required this.descr,
      @required this.schemeName});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFebebe3),
      elevation: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text('Scheme: '),
              ),
              Text(
                schemeName,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 10),
            child: Row(
              children: [
                Row(
                  children: [
                    Text(
                      descr,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 68.0),
                  child: Row(
                    children: [
                      Icon(Icons.date_range),
                      Text(
                        lastdate,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new InkWell(
                child: ElevatedButton(
                  onPressed: () async {
                    if (await canLaunch(fileUrl) != null) {
                      await launch(
                        fileUrl,
                      );
                    } else {
                      throw 'Could not launch $fileUrl';
                    }
                  },
                  child: Text(
                    'Click Here To Download',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    primary: Color(0xFFf38181), // background
                    onPrimary: Colors.black,
                  ),
                ),
                onTap: () => canLaunch(fileUrl)),
          ),
        ],
      ),
    );
  }
}

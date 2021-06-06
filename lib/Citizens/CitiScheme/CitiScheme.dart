// ignore: avoid_web_libraries_in_flutter
import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_new_app/Staffs/SCHEMES/addscheme_screen.dart';
import 'package:flutter_new_app/services/crud1.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:url_launcher/url_launcher.dart';

class CitiScheme extends StatefulWidget {
  @override
  _CitiSchemeState createState() => _CitiSchemeState();
}

class _CitiSchemeState extends State<CitiScheme> {
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
        backgroundColor: Color(0xfff38181),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                expandedHeight: 170.0,
                floating: false,
                pinned: true,
                centerTitle: true,
                flexibleSpace: FlexibleSpaceBar(
                    title: Text("          Schemes",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        )),
                    background: Image.asset(
                      "assets/images/o4.png",
                      height: 60,
                      fit: BoxFit.cover,
                    )),
              ),
            ];
          },
          body: SchemeList(),
        ));
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
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: Icon(Icons.new_releases),
            title: Text('Title: $schemeName'),
            subtitle: Column(
              children: [
                ElevatedButton(
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
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    primary: Color(0xFFeaffd0), // background
                    onPrimary: Colors.black,
                  ),
                ),
              ],
            ),
            trailing: Text(lastdate),
          ),
        )
      ],
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_app/StaffSetting.dart';
import 'package:flutter_new_app/Staffs/COMPLAINTS/complaintView.dart';
import 'package:flutter_new_app/Staffs/Contact/developer_contact.dart';
import 'package:flutter_new_app/Staffs/Events/presentation/pages/home.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_new_app/Staffs/addgallery.dart';
import 'package:flutter_new_app/Staffs/staffGallery.dart';
import 'package:flutter_new_app/Staffs/SCHEMES/staffscheme.dart';
import 'package:flutter_new_app/select.dart';

import '../signup.dart';

class StaffHome extends StatelessWidget {
  StaffHome({this.uid});
  final String uid;
  final String title = "Home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFffffff),
        appBar: AppBar(
          backgroundColor: Color(0xfff38181),
          title: Text(
            title,
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
              onPressed: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut().then((res) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => FirstRoute()),
                      (Route<dynamic> route) => false);
                });
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                  'https://res.cloudinary.com/dok0wwyum/image/upload/v1622880119/undraw_Bus_stop_re_h8ej-removebg-preview_t44gyz.png'),
              Text('Hey Staffs'),
              Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 175,
                            height: 200,
                            child: Card(
                              elevation: 10,
                              color: Color(0xfffdfaf6),
                              child: Column(
                                children: [
                                  Image.asset('assets/images/eventpic.png'),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: SizedBox(
                                      width: 120,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Home1Page()),
                                          );
                                        },
                                        child: Text('Events'),
                                        style: ElevatedButton.styleFrom(
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(10.0),
                                          ),
                                          primary:
                                              Color(0xFFf38181), // background
                                          onPrimary: Colors.black,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 175,
                            height: 200,
                            child: Card(
                              color: Color(0xfffdfaf6),
                              elevation: 10,
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/schemepic.png',
                                    height: 130,
                                  ),
                                  SizedBox(
                                    width: 120,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StaffScheme()),
                                        );
                                      },
                                      child: Text('Schemes'),
                                      style: ElevatedButton.styleFrom(
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(10.0),
                                        ),
                                        primary:
                                            Color(0xFFf38181), // background
                                        onPrimary: Colors.black,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 175,
                            height: 200,
                            child: Card(
                              color: Color(0xfffdfaf6),
                              elevation: 10,
                              child: Column(
                                children: [
                                  Image.asset('assets/images/complaintpic.png'),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: SizedBox(
                                      width: 120,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ComplaintViewStaff()),
                                          );
                                        },
                                        child: Text('Complaints'),
                                        style: ElevatedButton.styleFrom(
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(10.0),
                                          ),
                                          primary:
                                              Color(0xFFf38181), // background
                                          onPrimary: Colors.black,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 175,
                            height: 200,
                            child: Card(
                              color: Color(0xfffdfaf6),
                              elevation: 10,
                              child: Column(
                                children: [
                                  Image.asset('assets/images/gallerypic.png'),
                                  SizedBox(
                                    width: 120,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GalleryPage()),
                                        );
                                      },
                                      child: Text('Gallery'),
                                      style: ElevatedButton.styleFrom(
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(10.0),
                                        ),
                                        primary:
                                            Color(0xFFf38181), // background
                                        onPrimary: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
        drawer: NavigateDrawer(uid: this.uid));
  }
}

class NavigateDrawer extends StatefulWidget {
  final String uid;
  NavigateDrawer({Key key, this.uid}) : super(key: key);
  @override
  _NavigateDrawerState createState() => _NavigateDrawerState();
}

class _NavigateDrawerState extends State<NavigateDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: FutureBuilder(
                future: FirebaseDatabase.instance
                    .reference()
                    .child("Users")
                    .child(widget.uid)
                    .once(),
                builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.value['email']);
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            accountName: FutureBuilder(
                future: FirebaseDatabase.instance
                    .reference()
                    .child("Users")
                    .child(widget.uid)
                    .once(),
                builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.value['name']);
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            decoration: BoxDecoration(
              color: Color(0xFFf38181),
            ),
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.home, color: Colors.black),
              onPressed: () => null,
            ),
            title: Text('Home'),
            onTap: () {
              print(widget.uid);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StaffHome(uid: widget.uid)),
              );
            },
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.settings, color: Colors.black),
              onPressed: () => null,
            ),
            title: Text('Settings'),
            onTap: () {
              print(widget.uid);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StaffSetting(uid: widget.uid)),
              );
            },
          ),
        ],
      ),
    );
  }
}

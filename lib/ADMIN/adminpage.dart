import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import 'manage.dart';
import 'overview backup.dart';
import 'overview.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xfff38181),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.flash_on),
                  text: 'Overview',
                ),
                Tab(
                  icon: Icon(Icons.sync),
                  text: 'Manage',
                ),
              ],
            ),
            title: Text('Admin Panel'),
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
                        MaterialPageRoute(builder: (context) => AdminSign()),
                        (Route<dynamic> route) => false);
                  });
                },
              )
            ],
          ),
          body: TabBarView(
            children: [
              AdminOverview(),
              AdminManage(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'admincomplaintedit.dart';
import 'admineventedit.dart';
import 'adminschemeedit.dart';
import 'adminstaffedit.dart';
import 'adminstaffedit.dart';

class AdminManage extends StatefulWidget {
  const AdminManage({Key key}) : super(key: key);

  @override
  _AdminManageState createState() => _AdminManageState();
}

class _AdminManageState extends State<AdminManage> {

  void AdminStaffEdit1()
 {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Container(
            margin: EdgeInsets.only(left: 5.0,right: 5.0),
            child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget> [
          Container(
            margin: EdgeInsets.all(5),
            width: double.infinity,
            child: TextButton(
                child: Text("Staff"),
                style: TextButton.styleFrom(
                    alignment: Alignment.center,
                    primary: Colors.white,
                    backgroundColor: Color(0xfff38181),
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    )
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => AdminStaffEdit()));
                },
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(5),
            child: TextButton(
                child: Text("Events"),
                style: TextButton.styleFrom(
                    alignment: Alignment.center,
                    primary: Colors.white,
                    backgroundColor: Color(0xff95e1d3),
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    )
                ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => AdminEventEdit()));
              },
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(5),
            child: TextButton(
                child: Text("Schemes"),
                style: TextButton.styleFrom(
                    alignment: Alignment.center,
                    primary: Colors.white,
                    backgroundColor: Color(0xfffce38a),
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    )
                ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => AdminSchemeEdit()));
              },
            ),
          ),
          ]
      )
          )
    );
  }
}

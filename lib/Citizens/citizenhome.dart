import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

import 'package:flutter_new_app/Citizens/CitiEvents/CitiEvents.dart';
import 'package:flutter_new_app/Citizens/CitiGallery.dart';
import 'package:flutter_new_app/Citizens/CitiScheme/CitiScheme.dart';
import 'package:flutter_new_app/Citizens/Complaints/Register.dart';
import 'package:flutter_new_app/Citizens/ContactUs/citiContact.dart';
import 'package:flutter_new_app/select.dart';

class CitizenHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(149, 225, 211, 0.5),
              Color(0xFFffffff),
            ], begin: Alignment.topCenter, end: Alignment(0.06, 0)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FirstRoute()));
                        }),
                  ),
                  Text(
                    'Hey Citizen',
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: SizedBox(
                  height: 150.0,
                  width: 340.0,
                  child: Carousel(
                    images: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 30),
                        color: Color(0xfff38181),
                        child: Text(
                          'Find out the new events taking place in your panchayath',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 30),
                        color: Color(0xfffce38a),
                        child: Text(
                          'Find out the new schemes introduced by Government',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 30),
                        color: Color(0xffeaffd0),
                        child: Text(
                          'Connect with your Panchayath Members. Register your complaints or queries with them.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                    autoplay: true,
                    animationDuration: Duration(milliseconds: 1000),
                    dotSize: 6.0,
                    dotSpacing: 15.0,
                    dotColor: Colors.black,
                    borderRadius: true,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 175,
                      height: 200,
                      child: Card(
                        elevation: 10,
                        child: Column(
                          children: [
                            Image.asset('assets/images/eventpic.png'),
                            SizedBox(
                              width: 120,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CitiContacts()),
                                    );
                                  },
                                  child: Text('Events'),
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xfff38181)),
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
                        elevation: 10,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/schemepic.png',
                              height: 136,
                            ),
                            SizedBox(
                              width: 120,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CitiScheme()),
                                  );
                                },
                                child: Text(
                                  'Scheme',
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xfff38181)),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 175,
                      height: 200,
                      child: Card(
                        elevation: 10,
                        child: Column(
                          children: [
                            Image.asset('assets/images/complaintpic.png'),
                            SizedBox(
                              width: 120,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                  );
                                },
                                child: Text('Complaint'),
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xfff38181)),
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
                        elevation: 10,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/gallerypic.png',
                            ),
                            SizedBox(
                              width: 120,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CitiGalleryPage()),
                                  );
                                },
                                child: Text('Gallery'),
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xfff38181)),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Row(
                  children: [
                    SizedBox(
                      width: 175,
                      height: 200,
                      child: Card(
                        elevation: 10,
                        child: Column(
                          children: [
                            Image.asset('assets/images/contactpic.png'),
                            SizedBox(
                              width: 120,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 38.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ContactUs()),
                                    );
                                  },
                                  child: Text('Contact'),
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xfff38181)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffffffff),
        appBar: AppBar(
          backgroundColor: Color(0xfff38181),
          title: Text('Profile Card'),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: CachedNetworkImage(
                      imageUrl: FirebaseAuth.instance.currentUser.photoURL,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser.displayName,
                    style: TextStyle(fontSize: 30),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 48.0),
                    child: Container(
                        width: 400,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xff95e1d3),
                        ),
                        child: Center(
                          child: Text(
                            'User Details',
                            style: TextStyle(fontSize: 25),
                          ),
                        )),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'email: ',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              FirebaseAuth.instance.currentUser.email,
                              style: TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('ID: ', style: TextStyle(fontSize: 20)),
                            Text(
                              FirebaseAuth.instance.currentUser.uid,
                              style: TextStyle(fontSize: 13.5),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Image.asset('assets/images/profile.png')
                ],
              )),
        ));
  }
}

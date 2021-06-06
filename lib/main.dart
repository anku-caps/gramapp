import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_app/select.dart';
import 'package:splashscreen/splashscreen.dart';

import 'Staffs/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gram Panchayat App',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Montserrat'),
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User result = FirebaseAuth.instance.currentUser;
    return Center(
      child: new SplashScreen(
          navigateAfterSeconds:
              result != null ? StaffHome(uid: result.uid) : FirstRoute(),
          seconds: 7,
          image: Image.asset('assets/images/logo.png', fit: BoxFit.scaleDown),
          backgroundColor: Color(0xffeaffd0),
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 100.0,
          onClick: () => print("flutter"),
          loaderColor: Colors.red),
    );
  }
}

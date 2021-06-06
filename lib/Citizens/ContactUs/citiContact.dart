import 'package:flutter/material.dart';
import 'package:flutter_new_app/Citizens/citizenhome.dart';
import 'package:url_launcher/url_launcher.dart';

_sendingMails() async {
  const url = 'mailto: gpaapp2021@gmail.com';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_sendingSMS() async {
  const url = 'sms:9947706476';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CitizenHome()));
                    }),
              ),
              Image.asset('assets/images/mailpic.png'),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Thank you \nfor choosing us.',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 20.0,
              ),
              Text(
                'For any Queries, Mail us',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  //fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                  onPressed: _sendingMails,
                  child: Text(
                    'Here',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(primary: Color(0xfffce38a)),
                ),
              ),
              Container(
                height: 20.0,
              ),
              Text(
                'Or Send SMS',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  //fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                  onPressed: _sendingSMS,
                  child: Text(
                    'Here',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(primary: Color(0xfffce38a)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

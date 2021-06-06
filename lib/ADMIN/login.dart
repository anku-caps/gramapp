import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_app/ADMIN/AdminHome.dart';

class AdminSign extends StatefulWidget {
  @override
  _AdminSignState createState() => _AdminSignState();
}

class _AdminSignState extends State<AdminSign> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Enter Email Address",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Email Address';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email address!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Enter Password",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.lightBlue)),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            loginAdmin();
                          }
                        },
                        child: Text('Submit'),
                      ),
              )
            ]))));
  }

  void loginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.get("adminusername") != emailController.text.trim()) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Your ID is not correct")));
        } else if (result.get("adminpassword") !=
            passwordController.text.trim()) {
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("Your password is not correct")));
        } else {
          //Scaffold.of(context).showSnackBar(SnackBar(content: Text("Welcome Admin"  result.get(['name']))));
          setState(() {
            emailController.text = "";
            passwordController.text = "";
          });
          Route route = MaterialPageRoute(builder: (c) => AdminHome());
          Navigator.pushReplacement(context, route);
        }
      });
    });
  }
}

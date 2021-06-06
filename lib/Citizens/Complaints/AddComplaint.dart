import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_app/Citizens/Complaints/Detail.dart';
import 'package:flutter_new_app/services/crud2.dart';

class AddComplaint extends StatefulWidget {
  @override
  _AddComplaintState createState() => _AddComplaintState();
}

class _AddComplaintState extends State<AddComplaint> {
  var _formKey = GlobalKey<FormState>();
  String Name, Address, phone, complaint, id, details, CID;

  bool _isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Crud2Methods crud2Methods = new Crud2Methods();

  uploadComplaint() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();

    Map<String, String> complaintMap = {
      "Name": Name,
      "Address": Address,
      "phone": phone,
      "complaint": complaint,
      "details": details,
      "CID": CID,
      "id": FirebaseAuth.instance.currentUser.uid
    };

    crud2Methods.addData(complaintMap).then((result) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      appBar: AppBar(
        backgroundColor: Color(0xFFf38181),
        title: Text(
          'Add Complaint',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              uploadComplaint();
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.file_upload)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: _isLoading
            ? Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(hintText: "ID"),
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Please enter your Id';
                                } else if (val !=
                                    FirebaseAuth.instance.currentUser.uid) {
                                  return 'Please enter your correct Id';
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {},
                              onChanged: (val) {
                                CID = val;
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(hintText: "Name"),
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Please enter your Name';
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {},
                              onChanged: (val) {
                                Name = val;
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(hintText: "Address"),
                              onFieldSubmitted: (value) {},
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Please enter your Address';
                                }
                                return null;
                              },
                              onChanged: (val) {
                                Address = val;
                              },
                            ),
                            TextFormField(
                              controller: phoneController,
                              decoration:
                                  const InputDecoration(labelText: 'Mobile'),
                              keyboardType: TextInputType.phone,
                              onFieldSubmitted: (value) {},
                              validator: (val) {
                                if (val.length != 10) {
                                  return 'Please enter valid Mobile number';
                                }
                                return null;
                              },
                              onChanged: (val) {
                                phone = val;
                              },
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(hintText: "Complaint"),
                              onFieldSubmitted: (value) {},
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Please enter your Complaint subject';
                                }
                                return null;
                              },
                              onChanged: (val) {
                                complaint = val;
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Detail Explanation of complaint"),
                              onFieldSubmitted: (value) {},
                              maxLines: null,
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Please enter your complaint details';
                                }
                                return null;
                              },
                              onChanged: (val) {
                                details = val;
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

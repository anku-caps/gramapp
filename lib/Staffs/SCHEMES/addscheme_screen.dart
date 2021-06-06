import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_app/services/crud1.dart';
import 'package:random_string/random_string.dart';

class AddScheme extends StatefulWidget {
  @override
  _AddSchemeState createState() => _AddSchemeState();
}

class _AddSchemeState extends State<AddScheme> {
  String schemeName, descr, lastdate;
  File selectedFile;
  bool _isLoading = false;
  TextEditingController nameController = TextEditingController();
  final dateController = TextEditingController();
  Crud1Methods crud1Methods = new Crud1Methods();

  Future getFile() async {
    FilePickerResult pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );

    setState(() {
      if (pickedFile != null) {
        selectedFile = File(pickedFile.files.single.path);
      } else {
        print('No file selected.');
      }
    });
  }

  uploadScheme() async {
    if (selectedFile != null) {
      setState(() {
        _isLoading = true;
      });

      /// uploading image to firebase storage

      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child("schemeFiles")
          .child("${randomAlphaNumeric(9)}.pdf");

      final UploadTask uploadtask = storageReference.putFile(selectedFile);

      var fileUrl = await (await uploadtask).ref.getDownloadURL();
      fileUrl.toString();

      print("this is url $fileUrl");

      Map<String, String> schemeMap = {
        "fileUrl": fileUrl,
        "schemeName": schemeName,
        "descr": descr,
        "lastdate": dateController.text,
      };

      crud1Methods.addData(schemeMap).then((result) {
        Navigator.pop(context);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      appBar: AppBar(
        backgroundColor: Color(0xFFf38181),
        title: Text(
          'Add Scheme',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              uploadScheme();
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.file_upload)),
          )
        ],
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        getFile();
                      },
                      child: selectedFile != null
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              height: 170,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.file(
                                  selectedFile,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              height: 170,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6)),
                              width: MediaQuery.of(context).size.width,
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.black45,
                              ),
                            )),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(hintText: "Scheme Name"),
                          onChanged: (val) {
                            schemeName = val;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(hintText: "Description"),
                          onChanged: (val) {
                            descr = val;
                          },
                        ),
                        TextField(
                          readOnly: true,
                          controller: dateController,
                          decoration:
                              InputDecoration(hintText: 'Pick your Date'),
                          onTap: () async {
                            var date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));
                            dateController.text =
                                date.toString().substring(0, 10);
                          },
                          onChanged: (lastdate) {
                            dateController.text = lastdate;
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

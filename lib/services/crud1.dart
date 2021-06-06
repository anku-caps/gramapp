import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Crud1Methods {
  Future<void> addData(schemeData) async {
    FirebaseFirestore.instance
        .collection("schemes")
        .add(schemeData)
        .catchError((e) {
      print(e);
    });
  }

  getData() async {
    return FirebaseFirestore.instance.collection("schemes").snapshots();
  }
}

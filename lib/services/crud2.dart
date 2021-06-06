import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Crud2Methods {
  Future<void> addData(complaintData) async {
    FirebaseFirestore.instance
        .collection("complaints")
        .add(complaintData)
        .catchError((e) {
      print(e);
    });
  }

  getData() async {
    return FirebaseFirestore.instance.collection("complaints").snapshots();
  }
}

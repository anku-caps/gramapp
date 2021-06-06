import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_new_app/Staffs/COMPLAINTS/data/model/Status.dart';

class FirestoreService2 {
  static final _firestoreService2 = FirestoreService2._internal();
  FirebaseFirestore _db = FirebaseFirestore.instance;

  FirestoreService2._internal();

  factory FirestoreService2() {
    return _firestoreService2;
  }

  Stream<List<Status>> getStatus() {
    return _db.collection('Statuses').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Status.fromMap(doc.data(), doc.id),
              )
              .toList(),
        );
  }

  Future<void> addStatus(Status st) {
    return _db.collection('Statuses').add(st.toMap());
  }

  Future<void> deleteStatus(String id) {
    return _db.collection('Statuses').doc(id).delete();
  }

  Future<void> updateStatus(Status st) {
    return _db.collection('Statuses').doc(st.id).update(st.toMap());
  }
}

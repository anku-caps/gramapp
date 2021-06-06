import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_new_app/Staffs/Events/data/model/note.dart';

class FirestoreService {
  static final FirestoreService _firestoreService =
      FirestoreService._internal();
  FirebaseFirestore _db = FirebaseFirestore.instance;

  FirestoreService._internal();

  factory FirestoreService() {
    return _firestoreService;
  }

  Stream<List<Note>> getNotes() {
    return _db.collection('Events').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Note.fromMap(doc.data(), doc.id),
              )
              .toList(),
        );
  }

  Future<void> addEvent(Note note) {
    return _db.collection('Events').add(note.toMap());
  }

  Future<void> deleteEvent(String id) {
    return _db.collection('Events').doc(id).delete();
  }

  Future<void> updateEvent(Note note) {
    return _db.collection('Events').doc(note.id).update(note.toMap());
  }
}

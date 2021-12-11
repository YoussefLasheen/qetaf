import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class Api {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  late CollectionReference ref;

  Api(this.path) {
    ref = _db.collection(path);
  }
  
  Future<DocumentSnapshot> getDocumentById(String id) async {
    await Firebase.initializeApp();
    return ref.doc(id).get();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }

  updateDocument(Map data, String id) {
    ref.doc(id).set(data);
  }
}

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
    return ref.doc(id).get();
  }

  Future<DocumentReference> addDocument(data) {
    return ref.add(data);
  }

  Future<String> updateDocument(data, String id) async{
    String response = "Success";
    ref.doc(id).set(data).then((value) {
      response = 'Success';
    }).catchError((error) {
      response = error;
    });
    return response;
  }
}

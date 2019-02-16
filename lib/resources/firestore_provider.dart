import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreProvider {
  Firestore _firestore = Firestore.instance;
  Future<Null> saveUserData(FirebaseUser user) async {    
    await _firestore.collection("users").document(user.uid).setData({
      "email": user.email,
      "name": user.displayName,
    });
  }
}
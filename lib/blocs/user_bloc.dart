import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lender/resources/firestore_provider.dart';

class UserBloc {
  final _firestoreProvider = FirestoreProvider();

  Stream<QuerySnapshot> borrowed(String uid) {
    return _firestoreProvider.borrowed(uid);
  }

  Stream<QuerySnapshot> lent(String uid) {
    return _firestoreProvider.lent(uid);
  }



}
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

  Future<bool> addItem(Map<String,dynamic> item, String type, String uid) async {
    try {
      var ref = await _firestoreProvider.addItem(item, type, uid);
      return ref != null ? true : false;
    }catch(error){
      print(error);
      return false;
    }
  }



}
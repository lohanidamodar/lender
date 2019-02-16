import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lender/blocs/auth_bloc.dart';
import 'package:lender/resources/firestore_provider.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final _firestoreProvider = FirestoreProvider();
  final _user = BehaviorSubject<FirebaseUser>();
  
  AuthBloc _authBloc;

  UserBloc() {
    _authBloc = AuthBloc();
    _authBloc.userStream.listen((FirebaseUser user){
      _user.sink.add(user);
    });
  }

  FirebaseUser get user => _user.value;

  Stream<QuerySnapshot> borrowed() {
    return _firestoreProvider.borrowed(user.uid);
  }

  Stream<QuerySnapshot> lent() {
    return _firestoreProvider.lent(user.uid);
  }

  Future<bool> addItem(Map<String,dynamic> item, String type) async {
    try {
      var ref = await _firestoreProvider.addItem(item, type, user.uid);
      return ref != null ? true : false;
    }catch(error){
      print(error);
      return false;
    }
  }



}
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:lender/resources/firebase_auth_provider.dart';


class AuthBloc {
  final _authProvider = FirebaseAuthProvider();
  final _user = BehaviorSubject<FirebaseUser>();
  final _showProgress = BehaviorSubject<bool>();

    
  FirebaseUser get user => _user.value;

  Observable<FirebaseUser> get userStream => _user.stream;
  Observable<bool> get showProgress => _showProgress.stream;
  Function(bool) get changeShowProgress => _showProgress.sink.add;

  AuthBloc() {
    initUser();
  }


  Future<void> initUser() async {
    FirebaseUser user = await _authProvider.initUser();
    if(user != null){
      _user.sink.add(user);
    }else{
      _user.sink.addError("not logged in");
    }

    
  }

  Future<void> signInWithGoogle() async{
    try {
      FirebaseUser user = await _authProvider.signInWithGoogle();
      if(user == null) _user.sink.addError("Unable to login using google account");
      _user.sink.add(user);
    }catch(error){
      print(error);
      _user.sink.addError(error);
    }
  }

  Future<void> signOut() async {
    await _authProvider.signOut();
    initUser();
  }

  Future<Null> signUpWithEmailPassword(String email, String password, String fullName) async {
    try {
      FirebaseUser firebaseUser = await _authProvider.signUpWithEmailPassword(email,password,fullName);

      if(firebaseUser == null) _user.sink.addError("Unable to signup");
      _user.sink.add(firebaseUser);
    } catch(error) {
      _user.sink.addError(error);
      print(error);
    }

  }

  Future<Null> signinWithEmailPassword(String email, String password) async {
    try{
      FirebaseUser firebaseUser = await _authProvider.signinWithEmailPassword(email, password);
      if(firebaseUser == null) _user.sink.addError("Unable to Sign in with given details");
      _user.sink.add(firebaseUser);
    }catch(error) {
      _user.sink.addError(error.message);
      print(error.message);
    }
  }

  Future<Null> resendVerificationEmail(String email) async {
    if (user == null) return;
    try {
      await user.sendEmailVerification();
    }catch(e){
      print(e);
    }
  }

  void dispose() async {
    await _user.drain();
    _user.close();
    await _showProgress.drain();
    _showProgress.close();
  }
}
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lender/resources/firestore_provider.dart';

class FirebaseAuthProvider {
  FirestoreProvider _firestoreProvider = FirestoreProvider();
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount _googleAccount;

  Future<FirebaseUser> signIntoFirebase(
      GoogleSignInAccount googleSignInAccount) async {
    GoogleSignInAuthentication googleAuth =
        await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
    return await _auth.signInWithCredential(credential);
  }


  Future<FirebaseUser> initUser() async {
    FirebaseUser signedUser = await _auth.currentUser();
    if(signedUser != null) {
      if(!signedUser.isEmailVerified) await signedUser.reload();
      return signedUser;
    }
    return null;
  }

  Future<FirebaseUser> signInWithGoogle() async {
      _googleAccount = await _googleSignIn.signIn();
      if(_googleAccount == null) return null;
      FirebaseUser firebaseUser = await signIntoFirebase(_googleAccount);
      if(firebaseUser == null)return null;
      await _firestoreProvider.saveUserData(firebaseUser);
      return firebaseUser;
  }

  Future<FirebaseUser> signinWithEmailPassword(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(email: email,password: password);
    
  }

  Future<FirebaseUser> signUpWithEmailPassword(String email, String password, String fullName) async {
    try {
      FirebaseUser firebaseUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );

      if(firebaseUser != null) {
        await firebaseUser.sendEmailVerification();   
        UserUpdateInfo updateInfo = UserUpdateInfo();
        updateInfo.displayName = fullName;
        await firebaseUser.updateProfile(updateInfo);
        _firestoreProvider.saveUserData(firebaseUser);
      }
      return firebaseUser;
    } catch(error) {
      print(error);
      return error;
    }

  }

  Future<Null> resendVerificationEmail(FirebaseUser user) async {
    if (user == null) return;
    try {
      await user.sendEmailVerification();
    }catch(e){
      print(e);
    }
  }

  
  Future<Null> signOut() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:embark/services/Authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Profile {
  // Shared State for Widgets
  final AuthService _authService = AuthService();
  final Firestore _db = Firestore.instance;

  //profile information
  FirebaseUser user;

  Profile();

  Future<bool> setCurrentUser() async {
    if (await _authService.setCurrentUser()){
      await _initializeUser(await _authService.getUser());
      return true;
    } else {
      return false;
    }
  }

  // constructor
  Future<void> _initializeUser(FirebaseUser userFirebase) async {
    this.user = userFirebase;
    DocumentReference ref = _db.collection('users').document(user.uid);
    //update email, photoUrl, displayName, and last seen
    ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);
  }

  facebookSignIn() async {
    FirebaseUser user = await _authService.facebookSignIn();
    await _initializeUser(user);
  }

  googleSignIn() async {
    // initializes profile with information from google sign-in
    FirebaseUser user = await _authService.googleSignIn();
    await _initializeUser(user);
  }

  void signOut() {
    _authService.signOut();
  }
}

//Global user profile
Profile profile = Profile();

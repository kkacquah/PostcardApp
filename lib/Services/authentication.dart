import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthServiceEmailAndPassword {
  // Dependencies
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  // Shared State for Widgets
  Observable<FirebaseUser> user; // firebase user
  Observable<Map<String, dynamic>> profile; // custom user data in Firestore
  PublishSubject loading = PublishSubject();

  // constructor
  AuthServiceEmailAndPassword() {
    user = Observable(_auth.onAuthStateChanged);

    profile = user.switchMap((FirebaseUser u) {
      if (u != null) {
        return _db
            .collection('users')
            .document(u.uid)
            .snapshots()
            .map((snap) => snap.data);
      } else {
        return Observable.just({});
      }
    });
  }

  void _updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);
  }
  void _createUser(FirebaseUser user, String displayName) async {
    DocumentReference ref = _db.collection('users').document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': displayName,
      'lastSeen': DateTime.now()
    }, merge: true);
  }

  Future<FirebaseUser> signIn(String email, String password) async {
    // Start
    loading.add(true);

    // Step 1
    FirebaseUser user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    this._updateUserData(user);
    loading.add(false);
    // Step 3
    // Done
    return user;
  }

  Future<FirebaseUser> signUp(
      String displayName, String email, String password) async {
    // Start
    loading.add(true);

    // Step 1
    FirebaseUser user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    this._updateUserData(user);
    loading.add(false);
    // Step 3
    // Done
    return user;
  }

  void signOut() {
    _auth.signOut();
  }
}

class AuthServiceGoogle {
  // Dependencies
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  // Shared State for Widgets
  Observable<FirebaseUser> user; // firebase user
  Observable<Map<String, dynamic>> profile; // custom user data in Firestore
  PublishSubject loading = PublishSubject();

  // constructor
  AuthServiceGoogle() {
    user = Observable(_auth.onAuthStateChanged);

    profile = user.switchMap((FirebaseUser u) {
      if (u != null) {
        return _db
            .collection('users')
            .document(u.uid)
            .snapshots()
            .map((snap) => snap.data);
      } else {
        return Observable.just({});
      }
    });
  }

  void _updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);
  }

  Future<FirebaseUser> googleSignIn() async {
    // Start
    loading.add(true);

    // Step 1
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser user = await _auth.signInWithCredential(credential);
    this._updateUserData(user);
    // Step 3
    // Done
    loading.add(false);
    return user;
  }

  void signOut() {
    _auth.signOut();
  }
}

class AuthServiceFacebook {
  // Shared State for Widgets
  var _facebookSignIn = FacebookLogin();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Observable<FirebaseUser> user; // firebase user
  Observable<Map<String, dynamic>> profile; // custom user data in Firestore
  PublishSubject loading = PublishSubject();

  AuthServiceFacebook() {
    user = Observable(_auth.onAuthStateChanged);

    profile = user.switchMap((FirebaseUser u) {
      if (u != null) {
        return _db
            .collection('users')
            .document(u.uid)
            .snapshots()
            .map((snap) => snap.data);
      } else {
        return Observable.just({});
      }
    });
  }

  // constructor
  void _updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);
  }

  //TODO: FINISH
  Future<FirebaseUser> facebookSignIn() async {
    // Start
    loading.add(true);

    // Step 1
    final facebookLoginResult = await _facebookSignIn
        .logInWithReadPermissions(['email', 'public_profile']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");
        break;
    }
    AuthCredential credential = FacebookAuthProvider.getCredential(
        accessToken: facebookLoginResult.accessToken.token);
    //get user info
    var graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${facebookLoginResult.accessToken.token}');
    // Stqep 3
    print("authCredential initialized");
    FirebaseUser user = await _auth.signInWithCredential(credential);
    //get more facebook data
    //var facebookProfile = jsonDecode(graphResponse.body);
    _updateUserData(user);
    loading.add(false);
    return user;
  }

  void signOut() {
    _auth.signOut();
  }
}

final AuthServiceGoogle authServiceGoogle = AuthServiceGoogle();
final AuthServiceFacebook authServiceFacebook = AuthServiceFacebook();
final AuthServiceEmailAndPassword authServiceEmailAndPassword =
    AuthServiceEmailAndPassword();

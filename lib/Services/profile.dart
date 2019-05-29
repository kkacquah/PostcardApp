import 'package:firebase_auth/firebase_auth.dart';
import 'package:embark/services/authentication.dart';
import 'PostcardInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:embark/Components/LoginPostcard.dart';

class Profile {
  // Shared State for Widgets
  final AuthService _authService = AuthService();
  final Firestore _db = Firestore.instance;

  //profile information
  FirebaseUser user;
  List<PostcardInfo> myPostcards;
  List<PostcardInfo> savedPostcards;

  Profile();

  Future<bool> setCurrentUser() async {
    return _authService.setCurrentUser();
  }

  // constructor
  void _intializeUser(FirebaseUser userFirebase) async {
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
    //get my postcards save on device
    QuerySnapshot myPostcardsQuery = await _db
        .collection('users')
        .document(user.uid)
        .collection('myPostcards')
        .getDocuments();
    this.myPostcards = this._queryPostcards(myPostcardsQuery);
    //get saved postcards save on device
    QuerySnapshot savedPostcardsQuery = await _db
        .collection('users')
        .document(user.uid)
        .collection('myPostcards')
        .getDocuments();
    this.savedPostcards = this._queryPostcards(savedPostcardsQuery);
  }

  facebookSignIn() async {
    FirebaseUser user = await _authService.facebookSignIn();
    _intializeUser(user);
  }

  googleSignIn() async {
    // initializes profile with information from google sign-in
    FirebaseUser user = await _authService.googleSignIn();
    await _intializeUser(user);
  }

  List<PostcardInfo> _queryPostcards(QuerySnapshot postcardsQuery) {
    List<DocumentSnapshot> postcardDocuments = postcardsQuery.documents;
    print("got here");
    print(postcardDocuments);
    List<PostcardInfo> postcards = postcardDocuments.map((
        DocumentSnapshot docSnapshot) {
      //TODO: IF Exists
      if (docSnapshot.data == null) {
        return null;
      }
      print(docSnapshot.data['aspectRatio']);
      return PostcardInfo(docSnapshot.data['title'], docSnapshot.documentID,
          docSnapshot.data['photoUrl'], docSnapshot.data['locationString'],docSnapshot.data['fontFamily'],docSnapshot.data['aspectRatio']);
    }).where((info) => info != null).toList();
    return postcards;
  }


  void signOut() {
    _authService.signOut();
  }
}
//Global user profile
Profile profile = Profile();

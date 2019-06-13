import 'package:firebase_auth/firebase_auth.dart';
import 'package:embark/services/authentication.dart';
import 'PostcardInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:embark/Components/LoginPostcard.dart';
import 'package:embark/Styles/Themes.dart';

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
<<<<<<< HEAD
  void _intializeUser(FirebaseUser userFirebase) async {
=======
  Future<void> _initializeUser(FirebaseUser userFirebase) async {
>>>>>>> c61d9e111f67ca40237d9a670fdcbbec38c1bed1
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
    this.myPostcards = await this._queryPostcards(myPostcardsQuery);
    //get saved postcards save on device
    QuerySnapshot savedPostcardsQuery = await _db
        .collection('users')
        .document(user.uid)
        .collection('myPostcards')
        .getDocuments();
    this.savedPostcards = await this._queryPostcards(savedPostcardsQuery);
  }

  facebookSignIn() async {
    FirebaseUser user = await _authService.facebookSignIn();
<<<<<<< HEAD
    _intializeUser(user);
=======
    await _initializeUser(user);
>>>>>>> c61d9e111f67ca40237d9a670fdcbbec38c1bed1
  }

  googleSignIn() async {
    // initializes profile with information from google sign-in
    FirebaseUser user = await _authService.googleSignIn();
<<<<<<< HEAD
    await _intializeUser(user);
  }

  Future<List<PostcardInfo>> _queryPostcards(QuerySnapshot postcardsQuery) async {
    List<DocumentSnapshot> postcardDocuments = postcardsQuery.documents;
    List<String> postcardIDs = postcardDocuments.map((
        DocumentSnapshot docSnapshot)  {
=======
    await _initializeUser(user);
  }

  Future<List<PostcardInfo>> _queryPostcards(
      QuerySnapshot postcardsQuery) async {
    List<DocumentSnapshot> postcardDocuments = postcardsQuery.documents;
    List<String> postcardIDs =
        postcardDocuments.map((DocumentSnapshot docSnapshot) {
>>>>>>> c61d9e111f67ca40237d9a670fdcbbec38c1bed1
      //TODO: IF Exists
      if (docSnapshot.data == null) {
        return null;
      }
      return docSnapshot.documentID;
    }).toList();
    print(postcardIDs);
<<<<<<< HEAD
     QuerySnapshot postcardDocumentFromIDs = await _db
        .collection('postcards')
        .getDocuments();
    return postcardDocumentFromIDs.documents.where((
        //Only get document snapshots where data != null and the documentID is a postcardid
        DocumentSnapshot docSnapshot)  {

=======
    QuerySnapshot postcardDocumentFromIDs =
        await _db.collection('postcards').getDocuments();
    return postcardDocumentFromIDs.documents.where((
        //Only get document snapshots where data != null and the documentID is a postcardid
        DocumentSnapshot docSnapshot) {
>>>>>>> c61d9e111f67ca40237d9a670fdcbbec38c1bed1
      if (docSnapshot.data == null) {
        return false;
      }
      return postcardIDs.contains(docSnapshot.documentID);
<<<<<<< HEAD
    }).map((DocumentSnapshot postcardDocument){
      //Map document snapshots into the postcardDocuments
      return PostcardInfo(
          postcardDocument.data['title'], postcardDocument.documentID,
          postcardDocument.data['photoUrl'],
          postcardDocument.data['locationString'],
          EmbarkTheme.fromMap(Map<String, dynamic>.from(postcardDocument.data['theme'])),
          postcardDocument.data['aspectRatio']);
=======
    }).map((DocumentSnapshot postcardDocument) {
      //Map document snapshots into the postcardDocuments
      return PostcardInfo(
        title: postcardDocument.data['title'],
        uid: postcardDocument.documentID,
        photoUrl: postcardDocument.data['photoUrl'],
        location: postcardDocument.data['locationString'],
        themeID:postcardDocument.data['themeID'],
        fontID:postcardDocument.data['fontID'],
        aspectRatio:postcardDocument.data['aspectRatio'],
        sentiments:postcardDocument.data['sentiments'],
        geopoint:postcardDocument.data['geopoint'],
        timestamp:postcardDocument.data['timestamp'],
        status:postcardDocument.data['status'],
      );
>>>>>>> c61d9e111f67ca40237d9a670fdcbbec38c1bed1
    }).toList();
  }

  Future<PostcardInfo> _postCardFromPostcardId(String documentID) async {
    DocumentSnapshot postcardDocument;
    print("setting");
    await _db
        .collection('postcards')
<<<<<<< HEAD
        .document(documentID).get().then((value) => {print(value)});
//    print(postcardDocument);

=======
        .document(documentID)
        .get()
        .then((value) => {print(value)});
//    print(postcardDocument);
>>>>>>> c61d9e111f67ca40237d9a670fdcbbec38c1bed1
  }

  void signOut() {
    _authService.signOut();
  }
}
<<<<<<< HEAD
=======

>>>>>>> c61d9e111f67ca40237d9a670fdcbbec38c1bed1
//Global user profile
Profile profile = Profile();

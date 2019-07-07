import 'package:firebase_auth/firebase_auth.dart';
import 'package:embark/services/Authentication.dart';
import 'ScrapbookInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    await _initializeUser(user);
  }

  googleSignIn() async {
    // initializes profile with information from google sign-in
    FirebaseUser user = await _authService.googleSignIn();
    await _initializeUser(user);
  }

  Future<List<PostcardInfo>> _queryPostcards(
      QuerySnapshot postcardsQuery) async {
    List<DocumentSnapshot> postcardDocuments = postcardsQuery.documents;
    List<String> postcardIDs =
        postcardDocuments.map((DocumentSnapshot docSnapshot) {
      //TODO: IF Exists
      if (docSnapshot.data == null) {
        return null;
      }
      return docSnapshot.documentID;
    }).toList();
    print(postcardIDs);
    QuerySnapshot postcardDocumentFromIDs =
        await _db.collection('postcards').getDocuments();
    return postcardDocumentFromIDs.documents.where((
        //Only get document snapshots where data != null and the documentID is a postcardid
        DocumentSnapshot docSnapshot) {
      if (docSnapshot.data == null) {
        return false;
      }
      return postcardIDs.contains(docSnapshot.documentID);
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
        geopoint:postcardDocument.data['geopoint'],
        timestamp:postcardDocument.data['timestamp'],
        status:postcardDocument.data['status'],
      );
    }).toList();
  }

  Future<PostcardInfo> _postCardFromPostcardId(String documentID) async {
    DocumentSnapshot postcardDocument;
    print("setting");
    await _db
        .collection('postcards')
        .document(documentID)
        .get()
        .then((value) => {print(value)});
//    print(postcardDocument);
  }

  void signOut() {
    _authService.signOut();
  }
}

//Global user profile
Profile profile = Profile();

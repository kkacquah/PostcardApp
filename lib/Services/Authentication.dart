import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
class AuthService {
  // Shared State for Widgets
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _facebookSignIn = FacebookLogin();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser user; // firebase user
  Observable<Map<String, dynamic>> profile; // custom user data in Firestore
  PublishSubject loading = PublishSubject();

  AuthService();

  Future<bool> setCurrentUser() async{
    user = await _auth.currentUser();
    return user != null;
  }
  // constructor

  Future<FirebaseUser> getUser() async {
    var ret = await _auth.currentUser();
    return ret;
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
    // Step 3
    // Done
    loading.add(false);
    return user;
  }
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
    loading.add(false);
    return user;
  }

  void signOut() {
    _auth.signOut();
  }
}

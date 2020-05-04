import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("error logging out");
    }
  }

  static Future<String> loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();

      final Firestore _db = Firestore.instance;
      DocumentReference ref = _db.collection('users').document(account.email.substring(0, 6));
      ref.setData({
        'email': account.email,
        'photoURL': account.photoUrl,
        'firstName': account.displayName.split(" ")[0],
        'lastName': account.displayName.split(" ")[1],
        'points': FieldValue.increment(0)
      }, merge: true);

      if(account == null)
        return "null1";
      AuthResult res = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken,
      ));
      if(res.user == null)
        return "null2";
      return account.email;
    } catch (e) {
      return e.message;
    }
  }
}
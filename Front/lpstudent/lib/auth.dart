import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'storage.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final Firestore _db = Firestore.instance;

String email;
String imageUrl;
String firstName;
String lastName;

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  try{
    //int.parse(user.email.substring(0, 6));

    DocumentReference ref = _db.collection('users').document(user.email.substring(0, 6));
    ref.setData({
      'email': user.email,
      'photoURL': user.photoUrl,
      'firstName': user.displayName.split(" ")[0],
      'lastName': user.displayName.split(" ")[1],
      'points': FieldValue.increment(0)
    }, merge: true);

    firstName = user.displayName.split(" ")[0];
    lastName = user.displayName.split(" ")[1];
    email = user.email;
    imageUrl = user.photoUrl;
    
    //Storage.writeContent(firstName, "firstName");
    // Storage.writeContent(lastName, "lastName");
    Storage.writeContent(email, "email");
    // Storage.writeContent(imageUrl, "imageURL");

    print(user.displayName);
    print(user.email);
    print(user.photoUrl);

    return user.email;

  } catch (Exception){
    signOutGoogle();
    return '0';
  }
}

void signOutGoogle() async{
  await FirebaseAuth.instance.signOut();
  await googleSignIn.signOut();
  print("User Sign Out");
}
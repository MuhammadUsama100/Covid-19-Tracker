import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coronavirus/Utils/localStorage.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore();
  Observable<FirebaseUser> user;
  Observable<Map<String, dynamic>> profile;
  PublishSubject loading = PublishSubject();

  AuthService() {
    user = Observable(_auth.onAuthStateChanged);
    profile = user.switchMap((FirebaseUser u) {
      if (u != null) {
        return _db
            .collection('user')
            .document(u.uid)
            .snapshots()
            .map((snap) => snap.data);
      } else {
        return Observable.just({});
      }
    });
  }
  Future<FirebaseUser> googleSignIn() async {
    loading.add(true);
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    updateUserData(user);
    print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    print("Signed in " + user.displayName);
    loading.add(false);
    return user;
  }

  void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection("user").document(user.uid);

    Storage.setValue("UserID", user.uid);
    Storage.setValue("UserName", user.displayName);
    Storage.setValue("UserEmail", user.email);
    Storage.setValue("Phone", user.phoneNumber);
    Storage.setValue("Image", user.photoUrl);
    Storage.setValue("time", DateTime.now().toString());

    return ref.setData({
      "uid": user.uid,
      "email": user.email,
      "name": user.displayName,
      "friends": [],
      "status": "No",
      "logo": user.photoUrl
    });
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

final AuthService authService = AuthService();

import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

final googleSignin = GoogleSignIn();

class Auth extends ChangeNotifier {
  bool _isSigningIn = false;

  get siginStatus => _isSigningIn;
  void setSigningIn() {
    _isSigningIn = !_isSigningIn;
    notifyListeners();
  }

  Future login() async {
    setSigningIn();
    final user = await googleSignin.signIn();
    if (user == null) {
      return;
    } else {
      final googleAuth = await user.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
    }
    setSigningIn();
  }

  static void logout() async {
    await googleSignin.disconnect();
    FirebaseAuth.instance.signOut();
  }
}

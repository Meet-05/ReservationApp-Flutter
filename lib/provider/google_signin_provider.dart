import 'package:flutter/material.dart';

class GoogleSignInProvider extends ChangeNotifier {
  bool _isSigningIn;

  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool status) {
    _isSigningIn = status;
    notifyListeners();
  }
}

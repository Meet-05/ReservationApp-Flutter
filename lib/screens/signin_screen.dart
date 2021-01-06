import 'package:flutter/material.dart';
import '../widgets/google_signup_button.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.png',
            ),
            SizedBox(
              height: 20.0,
            ),
            GoogleSignUpButton(),
          ],
        ),
      ),
    );
  }
}

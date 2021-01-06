import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/auth.dart';

import 'package:provider/provider.dart';

class GoogleSignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 50.0),
      child: OutlineButton.icon(
        padding: EdgeInsets.all(15.0),
        onPressed: () {
          Provider.of<Auth>(context, listen: false).login();
        },
        icon: FaIcon(
          FontAwesomeIcons.google,
          color: Colors.white,
        ),
        label: Text('Sign in with Google',
            style: TextStyle(fontSize: 20.0, color: Colors.white)),
        shape: StadiumBorder(),
        borderSide: BorderSide(color: Colors.black),
      ),
    );
  }
}

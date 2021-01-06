import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import './screens/signin_screen.dart';
import './services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          canvasColor: Colors.transparent,
          primaryColor: Color(0xFF706897),
          accentColor: Colors.white,
          scaffoldBackgroundColor: Color(0xFF9088d4),
        ),
        home: ChangeNotifierProvider(
            create: (context) => Auth(),
            builder: (context, child) {
              return StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (Provider.of<Auth>(context).siginStatus) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.hasData) {
                        return HomeScreen();
                      } else {
                        return SignInScreen();
                      }
                    }
                  });
            }));
  }
}

import 'package:coastal_heaven/components/bottomBar.dart';
import 'package:coastal_heaven/screens/dashboard.dart';
import 'package:coastal_heaven/screens/homePage.dart';
import 'package:coastal_heaven/screens/signIn.dart';
import 'package:coastal_heaven/screens/signUp.dart';
import 'package:coastal_heaven/screens/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BottomBar();
          } else {
            return Splash();
          }
        },
      ),
    );
  }
}

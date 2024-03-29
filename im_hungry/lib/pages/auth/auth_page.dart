import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:im_hungry/pages/auth/setup_page.dart';
import 'package:im_hungry/pages/auth/sign_up.dart';
import 'package:im_hungry/pages/main_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
              return const Setup();
          } else {
            return const SignUp();
          }
        }
        ),
    );
  }
}
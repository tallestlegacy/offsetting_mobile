import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:offsetting_mobile/screens/app.dart';
import 'package:offsetting_mobile/screens/onboard.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  get isOnBoarded {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SignInScreen(
              providerConfigs: [EmailProviderConfiguration()]);
        }

        if (FirebaseAuth.instance.currentUser!.displayName == null) {
          return OnBoard();
        }

        return const App();
      },
    );
  }
}

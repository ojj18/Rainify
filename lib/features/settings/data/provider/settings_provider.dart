import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class SettingsProvider {
  Future logoutMethod() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Authentication failed';
    } catch (error) {
      log("Error message: $error");

      throw 'Something went wrong';
    }
  }
}

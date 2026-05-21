import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordProvider {
  Future passwordResetMethod({required String email}) async {
    try {
      /// CREATE USER
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Authentication failed';
    } catch (error) {
      log("Error message: $error");

      throw 'Something went wrong';
    }
  }
}

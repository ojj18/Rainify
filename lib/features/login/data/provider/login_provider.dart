import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginProvider {
  Future loginMethod({required String email, required String password}) async {
    try {
      final authResponse = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = authResponse.user;
      if (user == null) {
        throw 'User creation failed';
      }
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Authentication failed';
    } catch (error) {
      log("Error message: $error");

      throw 'Something went wrong';
    }
  }

  Future googleSignUpMethod({
    required double latitude,
    required double longitude,
  }) async {
    try {
      /// GOOGLE INSTANCE
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      /// INITIALIZE
      await googleSignIn.initialize();

      /// LOGIN
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final authResponse = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      final user = authResponse.user;
      if (user == null) {
        throw 'User creation failed';
      }

      /// STORE USER DATA
      await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        'uid': user.uid,

        'email': user.email,

        'name': user.email,

        'latitude': latitude,

        'longitude': longitude,

        'createdAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Authentication failed';
    } catch (error) {
      log("Error message: $error");

      throw 'Something went wrong';
    }
  }

  Future appleSignUpMethod({
    required double latitude,
    required double longitude,
  }) async {
    try {
      /// APPLE CREDENTIAL
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,

          AppleIDAuthorizationScopes.fullName,
        ],
      );

      /// OAUTH CREDENTIAL
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,

        accessToken: appleCredential.authorizationCode,
      );

      final authResponse = await FirebaseAuth.instance.signInWithCredential(
        oauthCredential,
      );

      final user = authResponse.user;
      if (user == null) {
        throw 'User creation failed';
      }

      /// STORE USER DATA
      await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        'uid': user.uid,

        'email': user.email,

        'name': user.email,

        'latitude': latitude,

        'longitude': longitude,

        'createdAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Authentication failed';
    } catch (error) {
      log("Error message: $error");

      throw 'Something went wrong';
    }
  }
}

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterProvider {
  Future<void> registerFunction({
    required String fullName,

    required String email,

    required String password,

    required double latitude,

    required double longitude,
  }) async {
    try {
      /// CREATE USER
      final authResponse = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = authResponse.user;

      if (user == null) {
        throw 'User creation failed';
      }

      /// STORE USER DATA
      await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        'uid': user.uid,

        'email': user.email,

        'name': fullName,

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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:justagain_tesk_task/services/navigation_services.dart';

class ServiceProvider with ChangeNotifier {
  signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(NavigationService.context!).showSnackBar(const SnackBar(
          content: Text('The password provided is too weak.'),
        ));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(NavigationService.context!).showSnackBar(const SnackBar(
          content: Text('The account already exists for that email.'),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  login(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(NavigationService.context!).showSnackBar(const SnackBar(
          content: Text('No user found for that email..'),
        ));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(NavigationService.context!).showSnackBar(const SnackBar(
          content: Text('Wrong password provided for that user.'),
        ));
      }
    }
  }
}

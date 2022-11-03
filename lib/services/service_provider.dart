import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:justagain_tesk_task/services/navigation_services.dart';

class ServiceProvider with ChangeNotifier {
  signUp(String email, String password) async {
    bool status = false;
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

        await addUser(email,'Hi Iam Using Justagain','').then((res){
          if(res == true){
            status = true;
            notifyListeners();

          }
        });

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
    return status;
  }

  login(String email, String password) async {
    bool status = false;
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if(userCredential.user != null){
        print(userCredential.credential);
        status = true;
        notifyListeners();
      }
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

    return status;
  }

  addUser(String email,String desc,String imageUrl)async{
    bool status = false;
    await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).set({
      'email' : email,
      'desc' :desc,
      'imageUrl' :imageUrl,
      'userType' : 'user'
    }).then((res) {
      status = true;
      notifyListeners();

    }).catchError((err){
      print(err);
    });

    return status;
  }

  getUserData()async{
    return await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get();
  }

  getUserDegrees()async{
    return await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('Degrees').get();
  }

  forgotPassword(String email)async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  addQuiz(String name, String desc,String imageUrl,List questions)async{
    await FirebaseFirestore.instance.collection('Quizzes').doc().set({
      'quizName' : name,
      'quizDesc':desc,
      'quizImageUrl':imageUrl,
      'questions' : questions
    });
  }

  getQuizzes()async{
    return await FirebaseFirestore.instance.collection('Quizzes').get();
  }

  saveDegree(String quizName, String degree)async{
    await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('Degrees').doc().set({
      'quizName' : quizName,
      'degree' :degree
    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier {
  //instance of Auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign in
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Sign in
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //add a new document for the users collections if it does not exixt
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid' : userCredential.user!.uid,
        'email' : email,
      },SetOptions(merge:true));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuthException
      throw Exception(e.code);
    } catch (e) {
      // Catch more general exceptions if needed
      throw Exception('An unexpected error occurred: $e');
    }
  }

  //create a new user
  Future<UserCredential> signUpWithEmailandPassword(String email ,String password) async{
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password);

      //user collection
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid' : userCredential.user!.uid,
        'email' : email,
      });

      return userCredential;
    } on FirebaseAuthException catch(e){
      throw Exception(e.code);
        }
  }


  //sign user out
Future<void> signOut() async{
    return await FirebaseAuth.instance.signOut();
}
}

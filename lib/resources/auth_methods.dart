import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_sharing_app/models/user.dart' as model;
import 'package:photo_sharing_app/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async{
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snapshot = await _firebaseFirestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snapshot);
  }
  // function for sign up the user.
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String userName,
      required String bio,
      required Uint8List file}) async {
    String res = "Some Error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          userName.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //register the user
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print('user created ' + credential.user!.uid);
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePicture', file, false);
        // add user to our database
        model.User user = model.User(
          username: userName,
          uid: credential.user!.uid,
          email: email,
          bio: bio,
          photoUrl: photoUrl,
          followers: [],
          following: [],
        );

        await _firebaseFirestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson());
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // logging in the user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occurred while logging in";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      } else {
        res = "Please enter all the fields";
      }
    }
    // } on FirebaseAuthException catch(e){
    //   if(e.code == "user-not-found"){
    //
    //   }
    // }
    catch (err) {
      res = err.toString();
    }
    return res;
  }
}

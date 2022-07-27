import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_sharing_app/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // function for sign up the user.
  Future<String> signUpUser({
    required String email,
    required String password,
    required String userName,
    required String bio,
    required Uint8List file
  }) async {
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
        await _firebaseFirestore
            .collection('users')
            .doc(credential.user!.uid)
            .set({
          'username': userName,
          'uid': credential.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl,
        });
        // another way of doing this
        // await _firebaseFirestore.collection('users').add(
        //  {
        //    'username' : userName,
        //    'uid' : credential.user!.uid,
        //    'email' : email,
        //    'bio' : bio,
        //    'followers' : [],
        //    'following' : [],
        //  });
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}

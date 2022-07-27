import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageMethods{
  //create instance of firebase storage
  final FirebaseStorage _storage = FirebaseStorage.instance;
  //to get user id
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // adding the image to firebase storage
  //we will use this to store profile pictures and the posts
  Future<String> uploadImageToStorage(String childName,Uint8List file,bool isPost) async{
    //ref method is pointed to the file in our storage
    //child can be a folder that exists or if not then will create one
    //file structure in firebase would be like profilePicture/uid/...
    Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);

    //uploading
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_sharing_app/models/post.dart';
import 'package:photo_sharing_app/resources/storage_methods.dart';

class FirestoreMethods {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  //upload a post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profileImage,
  ) async {
    String res = "some error occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();
      //create the post here
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          //here I have installed a package uuid which gives us v1 and v4
          //v1 is responsible to give unique id every time
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profileImage: profileImage,
          likes: []);
      //taking post and uploading it to the firebase
      firebaseFirestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      //if user has already liked the post in the past
      if (likes.contains(uid)) {
        await firebaseFirestore.collection('posts').doc(postId).update({
          'likes':FieldValue.arrayRemove([uid]),
          //so we will only go to the likes and remove the uid so as to show user that the user unliked the image

        });
      }else{
        await firebaseFirestore.collection('posts').doc(postId).update({
          'likes':FieldValue.arrayUnion([uid]),
        });
          };
    } catch (e) {
      //catch exception in string format
      print(
        e.toString(),
      );
    }
  }
}

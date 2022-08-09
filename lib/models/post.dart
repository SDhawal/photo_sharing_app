import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  //adding the properties of the user class
  final String description;
  final String uid;
  final String username;
  final String postId;
  final  datePublished;
  final String postUrl;
  final String profileImage;
  final likes;

  const Post(
      {required this.description,
      required this.uid,
      required this.username,
      required this.postId,
      required this.datePublished,
      required this.postUrl,
      required this.profileImage,
      required this.likes});

  //json methods to convert user object required to n object

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "profileImage": profileImage,
        "likes" : likes,
      };

  //take a document snapshot a dn return a user model
  //we are taking in a document snapshot and returning a user model
  static Post fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return Post(
        description: snap['description'],
        uid: snap['uid'],
        username: snap['username'],
        postId: snap['postId'],
        datePublished: snap['datePublished'],
        postUrl: snap['postUrl'],
        profileImage: snap['profileImage'],
        likes: snap['likes']);
  }
}

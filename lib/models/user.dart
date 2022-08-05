import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  //adding the properties of the user class
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  const User(
      {required this.email,
      required this.uid,
      required this.photoUrl,
      required this.username,
      required this.bio,
      required this.followers,
      required this.following});

  //json methods to convert user object required to n object

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "photoUrl": photoUrl,
        "email": email,
        "bio": bio,
        "followers": followers,
        "following": following
      };

  //take a document snapshot a dn return a user model
  //we are taking in a document snapshot and returning a user model
  static User fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return User(
        username: snap['username'],
        uid: snap['uid'],
        email: snap['email'],
        bio: snap['bio'],
        followers: snap['followers'],
        following: snap['following'],
        photoUrl: snap['photoUrl']);
  }
}

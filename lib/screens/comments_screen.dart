import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_sharing_app/models/user.dart';
import 'package:photo_sharing_app/providers/user_provider.dart';
import 'package:photo_sharing_app/resources/firestore_method.dart';
import 'package:photo_sharing_app/utils/colors.dart';
import 'package:provider/provider.dart';

import '../widgets/comments_card.dart';

class CommentsScreen extends StatefulWidget {
  final snap;

  const CommentsScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Comments'),
        backgroundColor: mobileBackgroundColor,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.snap['postId'])
            .collection('comments')
            .orderBy('datePublished',descending: true)//this will display comments in descending order
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) => CommentCard(
              snap: (snapshot.data! as dynamic).docs[index].data()
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(
            left: 16,
            right: 8,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(user.photoUrl),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Comment as ${user.username}',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await FirestoreMethods().postComment(
                    widget.snap['postId'],
                    _commentController.text,
                    user.uid,
                    user.username,
                    user.photoUrl,
                  );
                  setState(() {
                    _commentController.text = "";
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: const Text(
                    'post',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

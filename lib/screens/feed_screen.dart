import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_sharing_app/utils/colors.dart';
import 'package:photo_sharing_app/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          'assets/photogram.svg',
          color: primaryColor,
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.messenger_outline_rounded),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,//docs will give us list of document ids available and whereas length will give you length of postcards
              itemBuilder: (context , index) => PostCard(
                 //mentioning that these are data of our post
                 snap:snapshot.data!.docs[index].data(),
               ),
            );
          }),
    );
  }
}

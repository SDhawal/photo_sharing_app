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
      body:const PostCard(),
    );
  }
}

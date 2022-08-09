import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_sharing_app/resources/firestore_method.dart';
import 'package:photo_sharing_app/utils/colors.dart';
import 'package:photo_sharing_app/utils/utils.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  bool isLoading = false;

  void clearImage(){
    setState(() {
      _file = null;
    });
  }
  void postImage(String uid, String username, String profileImage) async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
        profileImage,
      );
      if (res == 'success') {
        setState(() {
          isLoading = false;
        });
        showSnackBar('Image Posted', context);
        clearImage;
      } else {
        setState(() {
          isLoading = false;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Create a post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.camera,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.gallery,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider
        .of<UserProvider>(context)
        .getUser;
    return _file == null
        ? Center(
      child: IconButton(
        icon: Icon(Icons.upload),
        onPressed: () => _selectImage(context),
      ),
    )
        : Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: clearImage,
          ),
          title: const Text('Post To'),
          centerTitle: false,
          actions: [
            TextButton(
                onPressed: () =>
                    postImage(user.uid, user.username, user.photoUrl),
                child: const Text(
                  'Post',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ))
          ],
        ),
        body: Column(
            children: [
            isLoading? const LinearProgressIndicator()
            :const Padding(padding: EdgeInsets.only(top:0)),
    const Divider(),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            user.photoUrl,
          ),
          radius: 40,
        ),
        SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.6,
          child: TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              hintText: ' write a caption...',
              border: InputBorder.none,
            ),
            maxLines: 8,
          ),
        ),
        SizedBox(
          height: 45,
          width: 45,
          child: AspectRatio(
            aspectRatio: 487 / 451,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: MemoryImage(_file!),
                    fit: BoxFit.fill,
                    alignment: FractionalOffset.topCenter,
                  )),
            ),
          ),
        )
      ],
    )
    ,
    const Divider(),
    SizedBox(
    height: 200,
    width: 350,
    child: AspectRatio(
    aspectRatio: 500 / 300,
    child: Container(
    decoration: BoxDecoration(
    image: DecorationImage(
    image: MemoryImage(_file!),
    //! because we never want it to be null
    fit: BoxFit.fill,
    alignment: FractionalOffset.topCenter,
    )),
    ),
    ),
    )
    ],
    ),
    );
  }
}

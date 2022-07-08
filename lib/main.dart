import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_sharing_app/responsive/mobile_screen_layout.dart';
import 'package:photo_sharing_app/responsive/responsive_layout_screen.dart';
import 'package:photo_sharing_app/responsive/web_screen_layout.dart';
import 'package:photo_sharing_app/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
// C:\Users\isi.751FJW2\AppData\Local\Pub\Cache\bin
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(apiKey: "AIzaSyBFyJC6oNjs26jrOdgWJW1qZ1tY2Idv0AU",
          appId: "1:124914797818:web:61e8f08c40ab32b6814d43",
          messagingSenderId: "124914797818",
          projectId: "photo-sharing-app-24e2d",
          storageBucket: "photo-sharing-app-24e2d.appspot.com"
      ),
    );
  }else{
    await Firebase.initializeApp();
  }
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insta Share ',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home:const ResponsiveLayout(
        mobileScreenLayout:MobileScreenLayout() ,
        webScreenLayout: WebScreenLayout() ,
      ),
    );
  }
}


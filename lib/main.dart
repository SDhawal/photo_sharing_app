import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_sharing_app/providers/user_provider.dart';
import 'package:photo_sharing_app/responsive/mobile_screen_layout.dart';
import 'package:photo_sharing_app/responsive/responsive_layout_screen.dart';
import 'package:photo_sharing_app/responsive/web_screen_layout.dart';
import 'package:photo_sharing_app/screens/login_screen.dart';
import 'package:photo_sharing_app/screens/signup_screen.dart';
import 'package:photo_sharing_app/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

// C:\Users\isi.751FJW2\AppData\Local\Pub\Cache\bin
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBFyJC6oNjs26jrOdgWJW1qZ1tY2Idv0AU",
          appId: "1:124914797818:web:61e8f08c40ab32b6814d43",
          messagingSenderId: "124914797818",
          projectId: "photo-sharing-app-24e2d",
          storageBucket: "photo-sharing-app-24e2d.appspot.com"),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> UserProvider()),
      ],
      child: MaterialApp(
          title: 'photogram',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: mobileBackgroundColor,
          ),
          // home:const ResponsiveLayout(
          //   mobileScreenLayout:MobileScreenLayout() ,
          //   webScreenLayout: WebScreenLayout() ,
          // ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const ResponsiveLayout(
                      webScreenLayout: WebScreenLayout(),
                      mobileScreenLayout: MobileScreenLayout());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }
              //what if snapshot does not has any data, then return Login Screen
              return const LoginScreen();
            },
          )),
    );
  }
}

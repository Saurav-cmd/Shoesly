import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'my_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Check the platform and initialize Firebase accordingly
  if (isAndroid()) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        appId: '1:821451738018:android:6c623ce02281192bd980fb',
        apiKey: 'AIzaSyAMeq88JPNFD3k_UyPqLR7UDPwgXYuqvUU',
        projectId: 'shoesly-8bd52',
        messagingSenderId: '821451738018',
        storageBucket: 'shoesly-8bd52.appspot.com',
      ),
    );
  } else if (isIOS()) {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

bool isAndroid() {
  return defaultTargetPlatform == TargetPlatform.android;
}

bool isIOS() {
  return defaultTargetPlatform == TargetPlatform.iOS;
}




import 'package:app/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Check if Firebase app has already been initialized
  
    // Initialize Firebase only if it hasn't been initialized yet
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDscSp3LRvAFGCR7mshRmGjdnSQ7ced1ug",
        appId: "1:610148525403:android:3b3d2d10eb3d79a93c267e",
        messagingSenderId: "610148525403",
        projectId: "sirusman-c5809",
        databaseURL: "https://sirusman-c5809-default-rtdb.firebaseio.com/",
        authDomain: "sirusman-c5809.firebaseapp.com",
        storageBucket: "sirusman-c5809.appspot.com"
      ),
    );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

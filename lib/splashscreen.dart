import 'dart:async';
import 'package:app/postscreen/postscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/auth/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
final user = FirebaseAuth.instance.currentUser; 
void initState(){
setState(() {
  super.initState();
if (user!=null) {
    Timer(const Duration(seconds: 2), () { 
    Navigator.push(context, MaterialPageRoute(builder:((context) =>const PostScreen())));
  });
} else {
    Timer(const Duration(seconds: 2), () { 
    Navigator.push(context, MaterialPageRoute(builder:((context) =>const Login())));
  });
}

});
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Login and Sign UP with Firebase", style: TextStyle(color: Colors.deepPurple, fontSize: 25, fontWeight: FontWeight.bold),),
      ),
    );
  }
}
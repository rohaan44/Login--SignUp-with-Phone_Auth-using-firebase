import 'package:app/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
        actions: [IconButton(onPressed: (){
          auth.signOut();
          Navigator.pop(context, MaterialPageRoute(builder: (context)=>Login()));
        }, icon: const Icon(Icons.power_settings_new,color: Colors.white,))],
          backgroundColor: Colors.deepPurple,
        title: Text("POST SCREEN"),
      ),
    );
  }
}
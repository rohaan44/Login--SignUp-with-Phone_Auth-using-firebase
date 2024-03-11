import 'package:app/components/components.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: const Text("Add Post Screen"),
    ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
            Container(
              width: 300,
              child: TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                   hintText: "What's in your mind?",
                  focusColor: Colors.deepPurple,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: const BorderSide(
                      color: Colors.grey
                    )
                  )
                ),
              ),
            ),
            RoundButton(Onpress: (){
              
            }, title: Text("Add Post"))
          ],),
        ),
      ),
    );
  }
}
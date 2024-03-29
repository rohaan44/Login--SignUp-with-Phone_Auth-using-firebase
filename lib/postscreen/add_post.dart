import 'package:app/components/components.dart';
import 'package:app/postscreen/postscreen.dart';
import 'package:app/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  final postController = TextEditingController();
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
                  controller: postController,
                  maxLines: 5,
                  decoration: InputDecoration(
                      hintText: "What's in your mind?",
                      focusColor: Colors.deepPurple,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: const BorderSide(color: Colors.grey))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RoundButton(
                  Onpress: () {
                    setState(() {
                      loading = true;
                    });
                    String id =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    setState(() {
                      loading = false;
                    });
                    databaseRef
                        .child(id)
                        .set(
                            {'ID': id, 'title': postController.text.toString()})
                        .then((value) => Utils().toast("Post Uploaded"))
                        .then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PostScreen()));
                        });
                  },
                  title: const Text(
                    "Add Post",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

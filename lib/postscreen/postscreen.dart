import 'package:app/auth/login.dart';
import 'package:app/postscreen/add_post.dart';
import 'package:app/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const AddPostScreen())));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut();
                Navigator.pop(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              icon: const Icon(
                Icons.power_settings_new,
                color: Colors.white,
              ))
        ],
        backgroundColor: Colors.deepPurple,
        title: const Text("POST SCREEN"),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: StreamBuilder<DatabaseEvent>(
                stream: databaseRef.onValue,
                builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                  if (snapshot.hasError) {
                    Utils().toast(snapshot.error.toString());
                  }

                  if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data!.snapshot.value == null) {
                    return  Center(
                      child: Container(
                        width: 100,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.deepPurple,
                        ),
                      ),
                    );
                  } else {
                    Map obj = snapshot.data!.snapshot.value as Map;
                    List list = obj.values.toList();

                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(list[index]['title'] ?? ''),
                          subtitle: Text(list[index]['ID'] ?? ''),
                          trailing: PopupMenuButton(
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                    child: ListTile(
                                  leading:const Icon(Icons.edit),
                                  title:const Text("Edit"),
                                  onTap: (){

                                  },
                                )),
                                PopupMenuItem(
                                    child: ListTile(
                                  leading: const Icon(Icons.delete),
                                  title:const Text("Delete"),
                                  onTap: (){

                                  },
                                ))
                              ];
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ]),
    );
  }





}

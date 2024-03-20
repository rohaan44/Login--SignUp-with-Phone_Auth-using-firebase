import 'package:app/auth/login.dart';
import 'package:app/postscreen/add_post.dart';
import 'package:app/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  FirebaseAuth auth = FirebaseAuth.instance;
  final editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const AddPostScreen())));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut();
                Navigator.pop(context,
                    MaterialPageRoute(builder: (context) => const Login()));
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
                    return Center(
                      child: Container(
                        width: 30,
                        child: const CircularProgressIndicator(
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
                        final title = list[index]['title'];
                        final id = list[index]['ID'];
                        return ListTile(
                          title: Text(title ?? ''),
                          subtitle: Text(id ?? ''),
                          trailing: PopupMenuButton(
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  child: ListTile(
                                    leading: const Icon(Icons.edit),
                                    title: const Text("Update"),
                                    onTap: () {
                                      Navigator.pop(context);
                                      showMyDialog(title, id);
                                    },
                                  ),
                                ),
                                PopupMenuItem(
                                  child: ListTile(
                                    leading: const Icon(Icons.delete),
                                    title: const Text("Delete"),
                                    onTap: () {
                                      Navigator.pop(context);
                                      databaseRef
                                          .child(list[index]['ID'])
                                          .remove();
                                    },
                                  ),
                                ),
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

  Future<void> showMyDialog(String title, String ID) async {
    editController.text = title;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: TextField(
              controller: editController,
              decoration: const InputDecoration(
                hintText: "Edit",
                prefixIcon: Icon(Icons.edit),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    databaseRef.child(ID).update(
                        {'ID': ID, 'title': editController.text}).then((value) {
                      Utils().toast("Post Updated");
                    }).onError((error, stackTrace) {
                      Utils().toast(error.toString());
                    });
                  },
                  child: Text('Update'))
            ],
          );
        });
  }
}

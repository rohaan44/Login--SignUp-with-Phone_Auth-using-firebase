import 'package:app/auth/login.dart';
import 'package:app/components/components.dart';
import 'package:app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool Loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  final formKey = GlobalKey<FormState>();


  void SignUp(){
         setState(() {
                      Loading = true;
                    });
                    auth
                        .createUserWithEmailAndPassword(
                            email: emailcontroller.text.toString(),
                            password: passwordcontroller.text.toString())
                        .then((value) {
                      setState(() {
                        Loading = false;
                      });
                    }).onError((error, stackTrace) {
                      Utils().toast(error.toString());
                      setState(() {
                        Loading = false;
                      });
                    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 350,
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailcontroller,
                        decoration: InputDecoration(
                            hintText: "Email: abc@gmail.com",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Write your email';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passwordcontroller,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                          )),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Write your password';
                        }
                        return null;
                      },
                    )
                  ],
                )),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: RoundButton(
              Loading: Loading,
                Onpress: () {
                  if (formKey.currentState!.validate()) {
               SignUp();
                  }
                },
                title: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account"),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text("Sign In"))
              ],
            ),
          )
        ],
      ),
    );
  }
}

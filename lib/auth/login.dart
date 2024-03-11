import 'package:app/auth/login_with_phone.dart';
import 'package:app/auth/signup.dart';
import 'package:app/components/components.dart';
import 'package:app/postscreen/postscreen.dart';
import 'package:app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool Loading = false;
  final formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() {
    if (formKey.currentState!.validate()) {
      setState(() {
        Loading = true;
      });
      auth
          .signInWithEmailAndPassword(
              email: emailController.text.toString(),
              password: passwordController.text.toString())
          .then((value) {
            setState(() {
              Loading= false;
            });
            Utils().toast(value.user!.toString());
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const PostScreen()));
          })
          .onError((error, stackTrace) {
            setState(() {
              Loading=false;
            });
            debugPrint(error.toString());
        Utils().toast(error.toString());
      });
      print("Login button pressed");
    }
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
                    controller: emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your email';
                      }
                      return null;
                    },
                  ),
                 const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Password',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your password';
                      }
                      return null;
                    },
                  )
                ],
              ),
            ),
          ),
        const  SizedBox(
            height: 50,
          ),
          Center(
            child: RoundButton(
              Loading: Loading,
              Onpress: () {
                login();
              },
              title: const Text(
                "Login",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account"),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const SignUp()));
                    },
                    child: const Text("Sign Up"))
              ],
            ),
          ),
          RoundButton(
            Loading: Loading,
            Onpress: (){
            setState(() {
              Loading= true;
            });
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginWithPhone()));
            setState(() {
              Loading= false;
            });
          }, title:const Text("Login With Phone",style: TextStyle(color: Colors.white),))
        ],
      ),
    );
  }
}

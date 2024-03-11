import 'package:app/auth/verify_with_phone.dart';
import 'package:app/components/components.dart';
import 'package:app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  bool loading = false;
  final auth = FirebaseAuth.instance;
  final phoneNumberController = TextEditingController();
  void dispose() {
    super.dispose();
    phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login With Phone"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            width: 300,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: phoneNumberController,
              decoration: const InputDecoration(
                hintText: "+92-3213955205",
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          RoundButton(
              Loading: loading,
              Onpress: () {
                setState(() {
                  loading = true;
                });
                auth.verifyPhoneNumber(
                    verificationCompleted: (_) {
                      setState(() {
                        loading = false;
                      });
                    },
                    phoneNumber: phoneNumberController.text.toString(),
                    
                    verificationFailed: (e) {
                      Utils().toast(e.toString());
                      setState(() {
                        loading=false;
                      });
                    },
                    codeSent: (String VerificationID, int? token) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => VerifyWithPhone(
                                  VerificationID: VerificationID))));
                                  setState(() {
                                    loading=false;
                                  });
                    },
                    codeAutoRetrievalTimeout: (e) {
                      Utils().toast(e.toString());
                    });
              },
              title: const Text("Verify"))
        ],
      ),
    );
  }
}

import 'package:app/components/components.dart';
import 'package:app/postscreen/postscreen.dart';
import 'package:app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyWithPhone extends StatefulWidget {
  final String VerificationID;
  const VerifyWithPhone({super.key,required this.VerificationID});

  @override
  State<VerifyWithPhone> createState() => _VerifyWithPhoneState();
}

class _VerifyWithPhoneState extends State<VerifyWithPhone> {
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
                hintText: "Write 6 Digit Code",
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          RoundButton(
              Loading: loading,
              Onpress: () async{
                setState(() {
                  loading=true;
                });
                final credential = PhoneAuthProvider.credential(verificationId: widget.VerificationID, smsCode: phoneNumberController.text.toString());
              try {
                setState(() {
                  loading = false;
                });
                await auth.signInWithCredential(credential);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const PostScreen()));
                
              } catch (e) {
               setState(() {
                 loading= false;
               });
                Utils().toast(e.toString());
              }
              },
              title: const Text("Verify"))
        ],
      ),
    );
  }
}

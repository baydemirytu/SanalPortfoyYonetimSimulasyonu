import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/constants/functions/customShowDialog.dart'
    as CSD;

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController mailController = TextEditingController();

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: mailController.text.trim());

      CSD.CustomShowDialog.showDialog(
          context, "Email sent to ${mailController.text.trim()}");
    } on FirebaseAuthException catch (e) {
      CSD.CustomShowDialog.showDialog(context, e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Reset Password"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Enter your email to get reset password link!",
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              maxLines: 1,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: mailController,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await resetPassword();
            },
            child: const Text(
              'Send Reset Email',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

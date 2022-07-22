import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future signIn() async {
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: mailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  @override
  void dispose() {
    mailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                  controller: mailController,
                  text: 'Enter your email',
                  icon: const Icon(Icons.email)),
              const SizedBox(height: 10),
              CustomTextField(
                  controller: passwordController,
                  text: 'Enter your password',
                  icon: const Icon(Icons.password)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  signIn();
                },
                child: const Text('Sign In'),
              ),
              GestureDetector(
                onTap: widget.showRegisterPage,
                child: const Text('Register!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

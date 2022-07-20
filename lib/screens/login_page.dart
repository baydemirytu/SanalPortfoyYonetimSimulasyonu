import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: mailController,
              ),
              TextField(
                controller: passwordController,
              ),
              ElevatedButton(
                onPressed: () {
                  signIn();
                },
                child: const Text('Press'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

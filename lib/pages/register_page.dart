import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future signUp() async {
    FirebaseAuth.instance.createUserWithEmailAndPassword(
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
                  signUp();
                },
                child: const Text('Sign Up'),
              ),
              GestureDetector(
                onTap: widget.showLoginPage,
                child: const Text('Already a member?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

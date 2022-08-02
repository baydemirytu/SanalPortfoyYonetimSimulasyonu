import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/authentication_pages/login_page.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/authentication_pages/verify_email_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong.'));
          } else if (snapshot.hasData) {
            return const VerifyEmailPage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}

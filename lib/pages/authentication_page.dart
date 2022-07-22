import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool loginPage = true;

  void changePage() {
    setState(() {
      loginPage = !loginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loginPage) {
      return LoginPage(showRegisterPage: changePage);
    } else {
      return RegisterPage(showLoginPage: changePage);
    }
  }
}

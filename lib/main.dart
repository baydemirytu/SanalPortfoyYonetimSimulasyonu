import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/authentication_pages/main_page.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/intro_page.dart';
import 'constants/constantThemes.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var introduction = prefs.getBool("intro");

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: darkTheme),
      home: introduction == null ? const IntroductionPage() : const MainPage(),
    ),
  );
}

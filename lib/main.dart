import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/intro_page.dart';
import 'constants/constantThemes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const IntroductionPage(),
      theme: ThemeData(colorScheme: darkTheme),
    );
  }
}

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

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: darkTheme),
      home: const SplashScreen(),
    ),
  );
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var introduction;

  Future getIntroduction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    introduction = prefs.getBool("intro");
  }

  @override
  void initState() {
    // TODO: implement initState
    getIntroduction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          introduction == null
              ? (Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const IntroductionPage(),
                  ),
                ))
              : (Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainPage(),
                  ),
                ));
        },
        child: Scaffold(
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Sanal Portföy Yönetim Uygulaması',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40),
                ),
              ),
              Text('Devam etmek için dokunun...')
            ],
          )),
        ));
  }
}

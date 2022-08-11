import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/authentication_pages/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  saveDone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("intro", true);
  }

  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        image: Image.asset("assets/images/yapi_kredi_logo.png"),
        title: "Page 1",
        body: "Page 1's body",
        footer: const Text("Page 1's footer"),
      ),
      PageViewModel(
        image: Image.asset("assets/images/yapi_kredi_logo.png"),
        title: "Page 2",
        body: "Page 2's body",
        footer: const Text("Page 2's footer"),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: getPages(),
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        showSkipButton: true,
        showBackButton: false,
        showNextButton: false,
        skip: const Text("Skip"),
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        onDone: () {
          saveDone();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPage(),
            ),
          );
        },
        onSkip: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPage(),
            ),
          );
        },
      ),
    );
  }
}

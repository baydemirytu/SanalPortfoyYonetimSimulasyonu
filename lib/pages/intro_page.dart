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
        title: "Sabit Getirili Menkul Kıymetler\nStaj Projesi",
        body: "",
        footer: const Text(""),
      ),
      PageViewModel(
        image: Image.asset("assets/images/yapi_kredi_logo.png"),
        title: "Üyeler",
        body: "Mentörler",
        footer: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Oğuzhan Şengül - Danışman Yazılım Mühendisi")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Text("Mehmet Abay - Danışman İş Analisti")],
            )
          ],
        ),
      ),
      PageViewModel(
        image: Image.asset("assets/images/yapi_kredi_logo.png"),
        title: "Üyeler",
        body: "Stajyerler",
        footer: Column(
          children: const [
            Text("Bahadır Patlak - İş Analisti Stajyeri",
                textAlign: TextAlign.center),
            Text("Barış Söke - Yazılım Mühendisi Stajyeri",
                textAlign: TextAlign.center),
            Text("Batuhan Ahmet Aydemir - Yazılım Mühendisi Stajyeri",
                textAlign: TextAlign.center),
            Text("Bora Polater - İş Analisti Stajyeri",
                textAlign: TextAlign.center),
            Text("Doğu Özcan - Yazılım Mühendisi Stajyeri",
                textAlign: TextAlign.center),
            Text("Emre Düzakın - Yazılım Mühendisi Stajyeri",
                textAlign: TextAlign.center),
            Text("Muzaffer Mert Akkan - Yazılım Mühendisi Stajyeri",
                textAlign: TextAlign.center),
          ],
        ),
      ),
      PageViewModel(
        image: Image.asset("assets/images/yapi_kredi_logo.png"),
        title: "Sanal Portföy Uygulaması",
        body: "Üyelik Aç",
        footer: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('1) Email hesabınızla kayıt olun'),
            Text('2) Başlangıç bakiyenizi kendiniz belirleyin'),
            Text('3) Spam klasörüne düşebilecek olan maildeki linke tıklayın'),
            Text(
                '4) Diğer üyeler arasında kar yarışmasında sıralamanızı görün'),
            Text('5) Sanal Portföy\'ünüzü yönetmeye başlayın 🚀')
          ],
        ),
      ),
      PageViewModel(
        image: Image.asset("assets/images/yapi_kredi_logo.png"),
        title: "Sanal Portföy Uygulaması",
        body: "Hesaplama Araçları",
        footer: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('1) Tahvil'),
            Text('2) Bono'),
            Text('3) Vadeli Mevduat'),
            Text('4) Döviz Kurları'),
            Text('hesaplamalarınızı kolaylıkla yapın')
          ],
        ),
      ),
      PageViewModel(
        image: Image.asset("assets/images/yapi_kredi_logo.png"),
        title: "Sanal Portföy Uygulaması",
        body: "Fiyatlar",
        footer: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('1) Döviz kurlarını görüntüleyin, alın, satın'),
            Text('2) Kripto paraları görüntüleyin, alın, satın'),
          ],
        ),
      ),
      PageViewModel(
        image: Image.asset("assets/images/yapi_kredi_logo.png"),
        title: "Hazır mısın?",
        body: "",
        footer: const Text(""),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: getPages(),
        dotsDecorator: DotsDecorator(
          size: const Size.square(5.0),
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
        skip: const Text("Atla"),
        done: const Text("Hem de nasıl",
            style: TextStyle(fontWeight: FontWeight.w600)),
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

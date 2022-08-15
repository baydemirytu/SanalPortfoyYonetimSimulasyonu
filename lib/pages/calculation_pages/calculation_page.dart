import 'package:flutter/material.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/constants/widgets/app_bar_drawer.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/calculation_pages/doviz_hesaplama.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/calculation_pages/vadeli_mevduat_hesaplama.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/portfolio_page.dart';

import 'tahvil_ve_bono_hesaplama.dart';

class CalculationPage extends StatefulWidget {
  const CalculationPage({Key? key}) : super(key: key);

  @override
  State<CalculationPage> createState() => _CalculationPageState();
}

class _CalculationPageState extends State<CalculationPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const PortfolioScreen(),
            ));
        return false;
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: const AppBarDrawer(),
          appBar: AppBar(
            shadowColor: Colors.white,
            elevation: 2,
            title: const Text('Hesaplama Ekranı'),
            centerTitle: true,
            bottom: const TabBar(
                isScrollable: true,
                indicatorWeight: 4,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Color.fromARGB(255, 63, 101, 133),
                tabs: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(
                      'Döviz Hesaplama',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(
                      'Vadeli Mevduat',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(
                      'Bono Ve Tahvil',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ]),
          ),
          body: const TabBarView(
            children: <Widget>[
              DovizHesaplama(),
              VadeliMevduatHesaplama(),
              TahvilVeBono(),
            ],
          ),
        ),
      ),
    );
  }
}

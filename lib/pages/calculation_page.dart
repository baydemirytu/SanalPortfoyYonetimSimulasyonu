import 'package:flutter/material.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/constants/widgets/app_bar_drawer.dart';

import '../tahvil_ve_bono_hesaplama.dart';

class CalculationPage extends StatefulWidget {
  const CalculationPage({Key? key}) : super(key: key);

  @override
  State<CalculationPage> createState() => _CalculationPageState();
}

class _CalculationPageState extends State<CalculationPage> {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
      drawer: AppBarDrawer(),
      appBar: AppBar(
        title: const Text('Hesaplama Ekranı'),
        centerTitle: true,
      ),
      body: PageView(
        controller: controller,
        children: <Widget>[
          TahvilVeBono(),
        ],
      ),
    );
  }
}

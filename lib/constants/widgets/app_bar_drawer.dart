import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/authentication_pages/main_page.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/portfolio_page.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/prices_pages/loading_screen_crypto.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/settings_page.dart';
import '../../pages/calculation_pages/calculation_page.dart';
import '../../pages/leaderboard_page.dart';
import '../../pages/prices_pages/loading_screen_forex.dart';

class AppBarDrawer extends StatefulWidget {
  const AppBarDrawer({Key? key}) : super(key: key);

  @override
  State<AppBarDrawer> createState() => _AppBarDrawerState();
}

class _AppBarDrawerState extends State<AppBarDrawer> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.65,
      child: ListView(
        children: [
          DrawerHeader(
            curve: Curves.fastLinearToSlowEaseIn,
            child: Center(
              child: Text(
                '${user.email}',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.assured_workload_rounded,
              color: Colors.indigo,
            ),
            title: const Text('Portföy'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const PortfolioScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.calculate,
              color: Colors.blueAccent,
            ),
            title: const Text('Hesaplama'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const CalculationPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.attach_money,
              color: Colors.green,
            ),
            title: const Text('Döviz'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ForexPricesLoading(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.currency_bitcoin,
              color: Colors.orange,
            ),
            title: const Text('Kripto Para'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const CryptoPricesLoading(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.leaderboard,
              color: Colors.yellow,
            ),
            title: const Text('Lider Tablosu'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LeaderboardPage(),
                ),
              );
            },
          ),
          const Divider(height: 20, color: Colors.white, thickness: 2),
          ListTile(
            leading: const Icon(Icons.power_settings_new),
            title: const Text('Çıkış Yap'),
            iconColor: Colors.red,
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const MainPage()));
            },
          ),
        ],
      ),
    );
  }
}

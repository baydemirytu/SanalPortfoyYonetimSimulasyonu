import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../fiyatlar.dart';
import '../../pages/calculation_page.dart';

class AppBarDrawer extends StatelessWidget {
  AppBarDrawer({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            curve: Curves.fastLinearToSlowEaseIn,
            child: Text('${user.email}'),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.leaderboard),
            title: const Text('Leaderboard'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.calculate),
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
            leading: const Icon(Icons.attach_money),
            title: const Text('Fiyatlar'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Fiyatlar(),
                ),
              );
            },
          ),
          const Divider(height: 10, color: Colors.white),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
          ListTile(
            leading: const Icon(Icons.power_settings_new),
            title: const Text('Log Out'),
            iconColor: Colors.red,
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}

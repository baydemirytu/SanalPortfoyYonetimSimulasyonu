import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
            leading: const Icon(Icons.leaderboard),
            title: const Text('Leaderboard'),
            onTap: () {},
          ),
          const Divider(height: 10, color: Colors.white),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: () {},
          )
        ],
      ),
    );
  }
}

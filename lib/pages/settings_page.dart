import 'package:flutter/material.dart';
import '../constants/widgets/app_bar_drawer.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool wantedToBeInLeaderBoard = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          textAlign: TextAlign.center,
        ),
      ),
      drawer: AppBarDrawer(),
      body: Column(
        children: [
          Text('Settings are going to be here'),
        ],
      ),
    );
  }
}

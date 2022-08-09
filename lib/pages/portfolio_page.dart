import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/home_page.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const HomePage();
              }));
            }),
        title: const Text('Portfolio'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Döviz ismi arayın',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (text) {},
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                portfolioCard('🇦🇺', 'AUD', 'Avustralya Doları', 0),
                portfolioCard('🇨🇦', 'CAD', 'Kanada Doları', 50),
                portfolioCard('🇯🇵', 'JPY', 'Japon Yeni', 233),
                portfolioCard('🇸🇦', 'SAR', 'Arabistan  Riyali', 488.5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Card portfolioCard(
      String flag, String currencyCode, String currencyName, double owned) {
    return Card(
      color: Colors.black54,
      child: ListTile(
        leading: Text(
          flag,
          style: TextStyle(fontSize: 32),
        ),
        title: Text(currencyCode, style: const TextStyle(color: Colors.white)),
        subtitle: Text(currencyName),
        trailing: Text("$owned"),
      ),
    );
  }
}

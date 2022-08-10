import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/home_page.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final Map<String, double> portfolioElements = {};
  Future getPortfolioElements() async {
    DocumentSnapshot variable = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    var elements = variable.get('Yatırım.Döviz');

    elements
        .forEach((k, v) => v > 0 ? portfolioElements[k.toString()] = v : null);

    // not sure about this line
    portfolioElements.keys.toList().sort();
  }

  final Map<String?, String> currencyEmojis = {
    'USD': '🇺🇸',
    'EUR': '🇪🇺',
    'GBP': '🇬🇧',
    'AED': '🇦🇪',
    'AUD': '🇦🇺',
    'CAD': '🇨🇦',
    'CHF': '🇨🇭',
    'DKK': '🇩🇰',
    'JPY': '🇯🇵',
    'KWD': '🇰🇼',
    'NOK': '🇳🇴',
    'SAR': '🇸🇦',
    'SEK': '🇸🇪',
  };

  final Map<String?, String> currencyNames = {
    'USD': 'Amerikan Doları',
    'EUR': 'Avrupa Para Birimi',
    'GBP': 'İngiliz Sterlini',
    'AED': 'Bae Dirhemi',
    'AUD': 'Avustralya Doları',
    'CAD': 'Kanada Doları',
    'CHF': 'İsviçre Frangı',
    'DKK': 'Danimarka Kronu',
    'JPY': 'Japon Yeni',
    'KWD': 'Kuveyt Dinarı',
    'NOK': 'Norveç Kronu',
    'SAR': 'Arabistan  Riyali',
    'SEK': 'İsveç Kronu',
  };

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
            child: FutureBuilder(
              future: getPortfolioElements(),
              builder: (context, index) {
                return ListView.builder(
                  itemCount: portfolioElements.values.length,
                  itemBuilder: ((context, index) {
                    return portfolioCard(
                      currencyEmojis[portfolioElements.keys.elementAt(index)],
                      portfolioElements.keys.elementAt(index),
                      currencyNames[portfolioElements.keys.elementAt(index)],
                      portfolioElements.values.elementAt(index),
                    );
                  }),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Card portfolioCard(
      String? flag, String currencyCode, String? currencyName, double owned) {
    return Card(
      color: Colors.black54,
      child: ListTile(
        leading: Text(
          flag!,
          style: TextStyle(fontSize: 32),
        ),
        title: Text(currencyCode, style: const TextStyle(color: Colors.white)),
        subtitle: Text(currencyName!),
        trailing: Text("$owned"),
      ),
    );
  }
}

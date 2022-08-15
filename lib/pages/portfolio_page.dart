import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/home_page.dart';
import 'package:intl/intl.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final Map<String, double> portfolioElements = {};
  final Map<String, dynamic> kriptoElements = {};
  final Map<String, dynamic> vadeliMevduatElements = {};

  Future getPortfolioElements() async {
    DocumentSnapshot variable = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    var elements = variable.get('Yatırım.Döviz');

    elements
        .forEach((k, v) => v > 0 ? portfolioElements[k.toString()] = v : null);
  }

  Future getKriptoElements() async {
    DocumentSnapshot variable = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    var elements = variable.get('Yatırım.Kripto');

    elements.forEach((k, v) => v > 0 ? kriptoElements[k.toString()] = v : null);
  }

  Future getVadeliMevduatElements() async {
    DocumentSnapshot variable = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    var elements = variable.get('Yatırım.Vadeli Mevduat');

    elements.forEach((currency, mevduatBilgileri) =>
        mevduatBilgileri['Aktif'] == true
            ? vadeliMevduatElements[currency.toString()] = mevduatBilgileri
            : null);
  }

  Future getAllAssets() async {
    await getPortfolioElements();
    await getKriptoElements();
    await getVadeliMevduatElements();
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
    'TRY': '🇹🇷'
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
    'TRY': 'Türk Lirası'
  };

  final Map<String?, String> kriptoNames = {
    'BTC': 'Bitcoin',
    'ETH': 'Ethereum',
    'BNB': 'Binance Coin',
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
          Expanded(
            child: Container(
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
          ),
          Expanded(
            child: FutureBuilder(
              future: getPortfolioElements(),
              builder: ((context, index) {
                if (portfolioElements.length == 0) {
                  return Container();
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PieChart(
                      dataMap: portfolioElements,
                      chartRadius: MediaQuery.of(context).size.width / 2,
                      chartType: ChartType.ring,
                      ringStrokeWidth: 16,
                      chartValuesOptions: const ChartValuesOptions(
                        decimalPlaces: 2,
                        showChartValuesInPercentage: true,
                        showChartValuesOutside: false,
                      ),
                    ),
                  );
                }
              }),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getAllAssets(),
              builder: (context, index) {
                return ListView.builder(
                  itemCount: portfolioElements.values.length +
                      kriptoElements.values.length +
                      vadeliMevduatElements.values.length,
                  itemBuilder: ((context, index) {
                    if (index < portfolioElements.values.length) {
                      return portfolioCard(
                        currencyEmojis[portfolioElements.keys.elementAt(index)],
                        portfolioElements.keys.elementAt(index),
                        currencyNames[portfolioElements.keys.elementAt(index)],
                        portfolioElements.values.elementAt(index),
                      );
                    } else if (index <
                        portfolioElements.values.length +
                            kriptoElements.values.length) {
                      return kriptoCard(
                          kriptoElements.keys.elementAt(
                              index - portfolioElements.values.length),
                          kriptoNames[kriptoElements.keys.elementAt(
                              index - portfolioElements.values.length)],
                          kriptoElements.values.elementAt(
                              index - portfolioElements.values.length));
                    } else {
                      String key = vadeliMevduatElements.keys.elementAt(index -
                          portfolioElements.values.length -
                          kriptoElements.values.length);
                      return vadeliMevduatCard(
                          currencyEmojis[key],
                          vadeliMevduatElements[key]['Anapara'],
                          key,
                          vadeliMevduatElements[key]['Yatırma Tarihi'],
                          vadeliMevduatElements[key]['Vade Tarihi'],
                          vadeliMevduatElements[key]['Net Getiri']);
                    }
                  }),
                );
              },
            ),
          ),
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
          style: const TextStyle(fontSize: 32),
        ),
        title: Text(currencyCode, style: const TextStyle(color: Colors.white)),
        subtitle: Text(currencyName!),
        trailing: Text("$owned"),
      ),
    );
  }

  Card kriptoCard(String currencyCode, String? currencyName, double owned) {
    return Card(
      color: Colors.black54,
      child: ListTile(
        title: Text(currencyCode, style: const TextStyle(color: Colors.white)),
        subtitle: Text(currencyName!),
        trailing: Text("$owned"),
      ),
    );
  }

  Card vadeliMevduatCard(String? emoji, int anapara, String? currency,
      String yatirmaTarihi, String vadeTarihi, double netGetiri) {
    DateTime dtYatirmaTarihi = DateFormat('dd-MM-yyyy').parse(yatirmaTarihi);
    DateTime dtVadeTarihi = DateFormat('dd-MM-yyyy').parse(vadeTarihi);

    DateTime dtNow =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    return Card(
      color: Colors.red,
      child: ListTile(
        leading: Text(emoji!, style: const TextStyle(fontSize: 32)),
        title: Text('$anapara ${currency!} Vadeli Mevduat'),
        subtitle: Text(
            '$yatirmaTarihi - $vadeTarihi\nNet Getiri: $netGetiri $currency'),
        trailing: MaterialButton(
          onPressed: () {
            double getiri = netGetiri;

            String dialogMessage =
                'Toplamda kazancınız $getiri $currency. Emin misiniz?';

            if (dtVadeTarihi.compareTo(dtNow) >= 0) {
              // Vade dolmamış, geçen gün sayısına oranla gelir
              getiri = netGetiri *
                  (DateTime.now().difference(dtYatirmaTarihi).inDays) /
                  (dtVadeTarihi.difference(dtYatirmaTarihi).inDays);

              dialogMessage =
                  'Vade tarihi bitmediği için $getiri $currency kazanacaksınız. Emin misiniz?';
            }

            showDialog(
                context: context,
                builder: ((context) {
                  return AlertDialog(
                    title: const Text('Onayla!'),
                    content: Text(dialogMessage),
                    actions: [
                      MaterialButton(
                        onPressed: () async {
                          DocumentReference docUser = FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.uid);

                          if (currency == 'TRY') {
                            docUser.update({
                              'Current Balance': FieldValue.increment(
                                  anapara.toDouble() + getiri),
                              'Yatırım.Vadeli Mevduat.TRY.Aktif': false,
                            });
                          } else {
                            docUser.update({
                              'Yatırım.Döviz.$currency': FieldValue.increment(
                                  anapara.toDouble() + getiri),
                              'Yatırım.Vadeli Mevduat.$currency.Aktif': false
                            });
                          }
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('İşlem Başarılı')));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PortfolioScreen(),
                            ),
                          );
                        },
                        child: const Text('Onayla!'),
                      ),
                      MaterialButton(
                          child: const Text('İptal'),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                  );
                }));

            setState(() {});
          },
          color: Colors.black,
          child: const Text('Boz'),
        ),
      ),
    );
  }
}

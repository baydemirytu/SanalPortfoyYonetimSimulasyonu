import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:intl/intl.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/constants/widgets/app_bar_drawer.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/prices_pages/networking.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final Map<String, double> dovizElements = {};
  final Map<String, dynamic> kriptoElements = {};
  final Map<String, dynamic> vadeliMevduatElements = {};
  Map<String, double> allAssets = {};

  Future getDovizElements() async {
    DocumentSnapshot variable = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    var elements = variable.get('Yatırım.Döviz');

    elements.forEach((k, v) => v > 0 ? dovizElements[k.toString()] = v : null);
    elements.forEach((k, v) {
      if (v > 0) {
        dovizElements[k.toString()] = v;
        calculateDoviz(k);
      }
    });
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

  Future calculateDoviz(String doviz) async {
    NetworkHelper myNetworkHelper = NetworkHelper(
        'https://api.exchangerate.host/convert?from=$doviz&to=TRY');
    var dovizData = await myNetworkHelper.requestData();
    double dovizPrice = dovizData['result'];
    allAssets[doviz] = dovizElements[doviz]! * dovizPrice;
  }

  Future getCurrentBalance() async {
    DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    dovizElements['TRY'] = userData['Current Balance'];
    allAssets['TRY'] = userData['Current Balance'];
  }

  Future getAllAssets() async {
    await getCurrentBalance();
    await getDovizElements();
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
      drawer: const AppBarDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Ana Sayfa'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getDovizElements(),
              builder: ((context, index) {
                if (dovizElements.isEmpty) {
                  return Container();
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PieChart(
                      dataMap: allAssets,
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
                  itemCount: dovizElements.values.length +
                      kriptoElements.values.length +
                      vadeliMevduatElements.values.length,
                  itemBuilder: ((context, index) {
                    if (index < dovizElements.values.length) {
                      return portfolioCard(
                        currencyEmojis[dovizElements.keys.elementAt(index)],
                        dovizElements.keys.elementAt(index),
                        currencyNames[dovizElements.keys.elementAt(index)],
                        dovizElements.values.elementAt(index),
                      );
                    } else if (index <
                        dovizElements.values.length +
                            kriptoElements.values.length) {
                      return kriptoCard(
                          kriptoElements.keys
                              .elementAt(index - dovizElements.values.length),
                          kriptoNames[kriptoElements.keys
                              .elementAt(index - dovizElements.values.length)],
                          kriptoElements.values
                              .elementAt(index - dovizElements.values.length));
                    } else {
                      String key = vadeliMevduatElements.keys.elementAt(index -
                          dovizElements.values.length -
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
        trailing:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            '${owned.toStringAsFixed(2)} $currencyCode',
            style: const TextStyle(fontSize: 16),
          ),
          currencyCode != 'TRY'
              ? Text('${allAssets[currencyCode]!.toStringAsFixed(2)} TRY',
                  style: const TextStyle(fontSize: 12, color: Colors.grey))
              : const SizedBox(),
        ]),
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

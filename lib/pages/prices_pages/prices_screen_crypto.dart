import 'package:flutter/material.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/home_page.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/prices_pages/transaction_screen.dart';

class CryptoPriceScreen extends StatefulWidget {
  CryptoPriceScreen(
    this.btcData,
    this.ethData,
  );
  final btcData;
  final ethData;

  @override
  State<CryptoPriceScreen> createState() => _CryptoPriceScreenState();
}

class _CryptoPriceScreenState extends State<CryptoPriceScreen> {
  late double btcPrice;
  late double ethPrice;

  @override
  void initState() {
    super.initState();
    updatePrices(
      widget.btcData,
      widget.ethData,
    );
  }

  updatePrices(
    dynamic btcData,
    ethData,
  ) {
    btcPrice = btcData['result'];
    ethPrice = ethData['result'];
  }

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
        title: const Text('Fiyatlar'),
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
              //Fiyatlar anlik olarak cekiliyor, degerler dogru.
              //Fiyatlarin renkleri hard coded, fikir versin diye boyle yapildi.
              //Sonra yukselme-alcalmaya gore degisecek sekilde yapmayi planliyorum.
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                currencyCard(
                    '🇺🇸', 'BTC', 'Bitcoin', btcPrice * 1.01, btcPrice * 0.99),
                currencyCard('🇪🇺', 'ETH', 'Ethereum', ethPrice * 1.01,
                    ethPrice * 0.99),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Card currencyCard(String flag, String currencyCode, String currencyName,
      double buyPrice, double sellPrice) {
    return Card(
      color: Colors.black54,
      child: ListTile(
        leading: Text(
          flag,
          style: TextStyle(fontSize: 32),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 90,
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TransactionScreen(
                          currencyCode, 'Alım', buyPrice, flag);
                    }));
                    print(
                        'Kullanici $buyPrice dan $currencyCode almak istiyor');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        buyPrice.toStringAsFixed(4),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Text(
                        'Al',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 90,
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TransactionScreen(
                          currencyCode, 'Satım', sellPrice, flag);
                    }));
                    print(
                        'Kullanici $sellPrice dan $currencyCode satmak istiyor');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        sellPrice.toStringAsFixed(4),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Text(
                        'Sat',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  )),
            ),
          ],
        ),
        title: Text(currencyCode, style: const TextStyle(color: Colors.white)),
        subtitle: Text(currencyName),
      ),
    );
  }
}

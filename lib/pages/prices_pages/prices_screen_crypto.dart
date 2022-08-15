import 'package:flutter/material.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/portfolio_page.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/prices_pages/transaction_screen_crypto.dart';

class CryptoPriceScreen extends StatefulWidget {
  CryptoPriceScreen(this.btcData, this.ethData, this.bnbData, this.curTime);
  final btcData;
  final ethData;
  final bnbData;
  final curTime;

  @override
  State<CryptoPriceScreen> createState() => _CryptoPriceScreenState();
}

class _CryptoPriceScreenState extends State<CryptoPriceScreen> {
  late double btcPrice;
  late double ethPrice;
  late double bnbPrice;
  late String currentTime;

  @override
  void initState() {
    super.initState();
    updatePrices(
        widget.btcData, widget.ethData, widget.bnbData, widget.curTime);
  }

  updatePrices(dynamic btcData, ethData, bnbData, curTime) {
    btcPrice = btcData['rate'];
    ethPrice = ethData['rate'];
    bnbPrice = bnbData['rate'];
    currentTime = curTime;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const PortfolioScreen(),
            ));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const PortfolioScreen();
                }));
              }),
          title: Column(
            children: [
              Text('Fiyatlar'),
              SizedBox(height: 8),
              Text(
                'Son Güncelleme: $currentTime',
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
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
                  hintText: 'Kripto para ismi arayın',
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
                      '', 'BTC', 'Bitcoin', btcPrice * 1.01, btcPrice * 0.99),
                  currencyCard(
                      '', 'ETH', 'Ethereum', ethPrice * 1.01, ethPrice * 0.99),
                  currencyCard('', 'BNB', 'Binance Coin', bnbPrice * 1.01,
                      bnbPrice * 0.99)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card currencyCard(String flag, String currencyCode, String currencyName,
      double buyPrice, double sellPrice) {
    return Card(
      color: Colors.black54,
      child: ListTile(
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 110,
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TransactionScreen(
                          currencyCode, 'Alım', buyPrice, '🪙');
                    }));
                    print(
                        'Kullanici $buyPrice dan $currencyCode almak istiyor');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        buyPrice.toStringAsFixed(2),
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
              width: 110,
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TransactionScreen(
                          currencyCode, 'Satım', sellPrice, '🪙');
                    }));
                    print(
                        'Kullanici $sellPrice dan $currencyCode satmak istiyor');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        sellPrice.toStringAsFixed(2),
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

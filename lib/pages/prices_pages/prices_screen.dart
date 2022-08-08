import 'package:flutter/material.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/home_page.dart';

//Bazi seyler hard coded, cunku api yi degistirmemiz gerekecek.
//Duzgun bir api buldukltan sonra kalabaligi alacagim.

class PriceScreen extends StatefulWidget {
  PriceScreen(
      this.usdData,
      this.eurData,
      this.gbpData,
      this.aedData,
      this.audData,
      this.cadData,
      this.chfData,
      this.dkkData,
      this.jpyData,
      this.kwdData,
      this.nokData,
      this.sarData,
      this.sekData);
  final usdData;
  final eurData;
  final gbpData;
  final aedData;
  final audData;
  final cadData;
  final chfData;
  final dkkData;
  final jpyData;
  final kwdData;
  final nokData;
  final sarData;
  final sekData;

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  late double usdPrice;
  late double eurPrice;
  late double gbpPrice;
  late double aedPrice;
  late double audPrice;
  late double cadPrice;
  late double chfPrice;
  late double dkkPrice;
  late double jpyPrice;
  late double kwdPrice;
  late double nokPrice;
  late double sarPrice;
  late double sekPrice;
  @override
  void initState() {
    super.initState();
    updatePrices(
        widget.usdData,
        widget.eurData,
        widget.gbpData,
        widget.aedData,
        widget.audData,
        widget.cadData,
        widget.chfData,
        widget.dkkData,
        widget.jpyData,
        widget.kwdData,
        widget.nokData,
        widget.sarData,
        widget.sekData);
  }

  updatePrices(dynamic usdData, eurData, gbpData, aedData, audData, cadData,
      chfData, dkkData, jpyData, kwdData, nokData, sarData, sekData) {
    usdPrice = usdData['result'];
    eurPrice = eurData['result'];
    gbpPrice = gbpData['result'];
    aedPrice = aedData['result'];
    audPrice = audData['result'];
    cadPrice = cadData['result'];
    chfPrice = chfData['result'];
    dkkPrice = dkkData['result'];
    jpyPrice = jpyData['result'];
    kwdPrice = kwdData['result'];
    nokPrice = nokData['result'];
    sarPrice = sarData['result'];
    sekPrice = sekData['result'];
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
                    '🇺🇸', 'USD', 'Amerikan Doları', usdPrice, usdPrice),
                currencyCard(
                    '🇪🇺', 'EUR', 'Avrupa Para Birimi', eurPrice, eurPrice),
                currencyCard(
                    '🇬🇧', 'GBP', 'İngiliz Sterlini', gbpPrice, gbpPrice),
                currencyCard('🇦🇪', 'AED', 'Bae Dirhemi', aedPrice, aedPrice),
                currencyCard(
                    '🇦🇺', 'AUD', 'Avustralya Doları', audPrice, audPrice),
                currencyCard(
                    '🇨🇦', 'CAD', 'Kanada Doları', cadPrice, cadPrice),
                currencyCard(
                    '🇨🇭', 'CHF', 'İsviçre Frangı', chfPrice, chfPrice),
                currencyCard(
                    '🇩🇰', 'DKK', 'Danimarka Kronu', dkkPrice, dkkPrice),
                currencyCard('🇯🇵', 'JPY', 'Japon Yeni', jpyPrice, jpyPrice),
                currencyCard(
                    '🇰🇼', 'KWD', 'Kuveyt Dinarı', kwdPrice, kwdPrice),
                currencyCard('🇳🇴', 'NOK', 'Norveç Kronu', nokPrice, nokPrice),
                currencyCard(
                    '🇸🇦', 'SAR', 'Arabistan  Riyali', sarPrice, sarPrice),
                currencyCard('🇸🇪', 'SEK', 'İsveç Kronu', sekPrice, sekPrice),
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
                  onPressed: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        buyPrice.toStringAsFixed(4),
                        style: TextStyle(color: Colors.white),
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
              width: 84,
              child: OutlinedButton(
                  onPressed: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        sellPrice.toStringAsFixed(4),
                        style: TextStyle(color: Colors.white),
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
        title: Text(currencyCode, style: TextStyle(color: Colors.white)),
        subtitle: Text(currencyName),
      ),
    );
  }
}

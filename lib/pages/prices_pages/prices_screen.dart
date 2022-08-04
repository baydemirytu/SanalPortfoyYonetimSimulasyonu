import 'package:flutter/material.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/home_page.dart';

class PriceScreen extends StatefulWidget {
  PriceScreen(this.usdData, this.eurData, this.gbpData);
  final usdData;
  final eurData;
  final gbpData;

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  late double usdPrice;
  late double eurPrice;
  late double gbpPrice;
  @override
  void initState() {
    super.initState();
    updatePrices(widget.usdData, widget.eurData, widget.gbpData);
  }

  updatePrices(dynamic usdData, eurData, gbpData) {
    usdPrice = usdData['result'];
    eurPrice = eurData['result'];
    gbpPrice = gbpData['result'];
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
        //Fiyatlar anlik olarak cekiliyor, degerler dogru.
        //Fiyatlarin renkleri hard coded, fikir versin diye boyle yapildi.
        //Sonra yukselme-alcalmaya gore degisecek sekilde yapmayi planliyorum.
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            color: Colors.black54,
            child: ListTile(
              leading: Icon(Icons.attach_money),
              title: Text(usdPrice.toStringAsFixed(3),
                  style: TextStyle(color: Colors.green)),
              subtitle: Text('Amerikan Doları'),
            ),
          ),
          Card(
            color: Colors.black54,
            child: ListTile(
              leading: Icon(Icons.euro),
              title: Text(eurPrice.toStringAsFixed(3),
                  style: TextStyle(color: Colors.green)),
              subtitle: Text('AB Para Birimi'),
            ),
          ),
          Card(
            color: Colors.black54,
            child: ListTile(
              leading: Icon(Icons.currency_pound),
              title: Text(gbpPrice.toStringAsFixed(3),
                  style: TextStyle(color: Colors.red)),
              subtitle: Text('İngiliz Sterlini'),
            ),
          ),
        ],
      ),
    );
  }
}

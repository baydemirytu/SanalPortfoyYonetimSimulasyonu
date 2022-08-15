import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/prices_pages/networking.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/prices_pages/prices_screen_crypto.dart';

import '../portfolio_page.dart';

//This page loads data
class CryptoPricesLoading extends StatefulWidget {
  const CryptoPricesLoading({Key? key}) : super(key: key);

  @override
  State<CryptoPricesLoading> createState() => _CryptoPricesLoadingState();
}

class _CryptoPricesLoadingState extends State<CryptoPricesLoading> {
  String choosenPair = '';

  void getCurrencyData() async {
    choosenPair = 'BTC';
    NetworkHelper myNetworkHelper =
        NetworkHelper('https://rest.coinapi.io/v1/exchangerate');
    var btcData = await myNetworkHelper.requestCoinData(choosenPair, 'TRY');
    choosenPair = 'ETH';
    myNetworkHelper = NetworkHelper('https://rest.coinapi.io/v1/exchangerate');
    var ethData = await myNetworkHelper.requestCoinData(choosenPair, 'TRY');
    choosenPair = 'BNB';
    myNetworkHelper = NetworkHelper('https://rest.coinapi.io/v1/exchangerate');
    var bnbData = await myNetworkHelper.requestCoinData(choosenPair, 'TRY');
    /*****/
    DateTime now = new DateTime.now();
    var formatter = new DateFormat.Hm();
    String formattedDate = formatter.format(now);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CryptoPriceScreen(btcData, ethData, bnbData, formattedDate);
    }));
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrencyData();
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
        body: ModalProgressHUD(
          inAsyncCall: true,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                Text('Fiyatlar yükleniyor...'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

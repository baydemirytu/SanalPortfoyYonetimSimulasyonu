import 'package:flutter/material.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/prices_pages/networking.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/prices_pages/prices_screen_crypto.dart';

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
    NetworkHelper myNetworkHelper = NetworkHelper(
        'https://api.exchangerate.host/convert?from=$choosenPair&to=TRY');
    var btcData = await myNetworkHelper.requestData();
    choosenPair = 'ETH';
    myNetworkHelper = NetworkHelper(
        'https://api.exchangerate.host/convert?from=$choosenPair&to=TRY');
    var ethData = await myNetworkHelper.requestData();
    /*****/

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CryptoPriceScreen(
        btcData,
        ethData,
      );
    }));
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrencyData();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:
            Text(' Data loading, a good loading screen will be added crypto'),
      ),
    );
  }
}

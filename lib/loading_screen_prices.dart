import 'package:flutter/material.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/networking.dart';
import 'prices_screen.dart';

//This page loads data
class PricesLoading extends StatefulWidget {
  const PricesLoading({Key? key}) : super(key: key);

  @override
  State<PricesLoading> createState() => _PricesLoadingState();
}

class _PricesLoadingState extends State<PricesLoading> {
  String choosenPair = '';

  void getCurrencyData() async {
    choosenPair = 'EUR';
    NetworkHelper myNetworkHelper = NetworkHelper(
        'https://api.exchangerate.host/convert?from=$choosenPair&to=TRY');
    var eurData = await myNetworkHelper.requestData();
    choosenPair = 'USD';
    myNetworkHelper = NetworkHelper(
        'https://api.exchangerate.host/convert?from=$choosenPair&to=TRY');
    var usdData = await myNetworkHelper.requestData();
    choosenPair = 'GBP';
    myNetworkHelper = NetworkHelper(
        'https://api.exchangerate.host/convert?from=$choosenPair&to=TRY');
    var gbpData = await myNetworkHelper.requestData();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PriceScreen(usdData, eurData, gbpData);
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
        child: Text(' Data loading, a good loading screen will be added'),
      ),
    );
  }
}

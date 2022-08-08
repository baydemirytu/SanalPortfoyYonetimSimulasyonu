import 'package:flutter/material.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/prices_pages/networking.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/prices_pages/prices_screen.dart';

//Bazi seyler hard coded, cunku api yi degistirmemiz gerekecek.
//Duzgun bir api buldukltan sonra kalabaligi alacagim.

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
    /*****/

    choosenPair = 'AED';
    myNetworkHelper = NetworkHelper(
        'https://api.exchangerate.host/convert?from=$choosenPair&to=TRY');
    var aedData = await myNetworkHelper.requestData();
    choosenPair = 'AUD';
    myNetworkHelper = NetworkHelper(
        'https://api.exchangerate.host/convert?from=$choosenPair&to=TRY');
    var audData = await myNetworkHelper.requestData();
    choosenPair = 'CAD';
    myNetworkHelper = NetworkHelper(
        'https://api.exchangerate.host/convert?from=$choosenPair&to=TRY');
    var cadData = await myNetworkHelper.requestData();
    choosenPair = 'CHF';
    myNetworkHelper = NetworkHelper(
        'https://api.exchangerate.host/convert?from=$choosenPair&to=TRY');
    var chfData = await myNetworkHelper.requestData();
    choosenPair = 'DKK';
    myNetworkHelper = NetworkHelper(
        'https://api.exchangerate.host/convert?from=$choosenPair&to=TRY');
    var dkkData = await myNetworkHelper.requestData();
    choosenPair = 'JPY';
    myNetworkHelper = NetworkHelper(
        'https://api.exchangerate.host/convert?from=$choosenPair&to=TRY');
    var jpyData = await myNetworkHelper.requestData();
    choosenPair = 'KWD';
    myNetworkHelper = NetworkHelper(
        'https://api.exchangerate.host/convert?from=$choosenPair&to=TRY');
    var kwdData = await myNetworkHelper.requestData();
    choosenPair = 'NOK';
    myNetworkHelper = NetworkHelper(
        'https://api.exchangerate.host/convert?from=$choosenPair&to=TRY');
    var nokData = await myNetworkHelper.requestData();
    choosenPair = 'SAR';
    myNetworkHelper = NetworkHelper(
        'https://api.exchangerate.host/convert?from=$choosenPair&to=TRY');
    var sarData = await myNetworkHelper.requestData();
    choosenPair = 'SEK';
    myNetworkHelper = NetworkHelper(
        'https://api.exchangerate.host/convert?from=$choosenPair&to=TRY');
    var sekData = await myNetworkHelper.requestData();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PriceScreen(usdData, eurData, gbpData, aedData, audData, cadData,
          chfData, dkkData, jpyData, kwdData, nokData, sarData, sekData);
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

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/prices_pages/networking.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/prices_pages/prices_screen_forex.dart';

//This page loads data
class ForexPricesLoading extends StatefulWidget {
  const ForexPricesLoading({Key? key}) : super(key: key);

  @override
  State<ForexPricesLoading> createState() => _ForexPricesLoadingState();
}

class _ForexPricesLoadingState extends State<ForexPricesLoading> {
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

    DateTime now = new DateTime.now();
    var formatter = new DateFormat.Hm();
    String formattedDate = formatter.format(now);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ForexPriceScreen(
          usdData,
          eurData,
          gbpData,
          aedData,
          audData,
          cadData,
          chfData,
          dkkData,
          jpyData,
          kwdData,
          nokData,
          sarData,
          sekData,
          formattedDate);
    }));
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrencyData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/calculation_pages/vadeli_mevduat_hesaplama.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/portfolio_page.dart'
    as prt;
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/prices_pages/networking.dart';

class DovizHesaplama extends StatefulWidget {
  const DovizHesaplama({Key? key}) : super(key: key);

  @override
  State<DovizHesaplama> createState() => _DovizHesaplamaState();
}

class _DovizHesaplamaState extends State<DovizHesaplama> {
  var euroData;
  var dolarData;
  var poundData;
  var aedData;
  var audData;
  var cadData;
  var chfData;
  var dkkData;
  var jpyData;
  var kwdData;
  var nokData;
  var sarData;
  var sekData;

  var euro = 18.25;
  var dolar = 17.931;
  var pound = 21.669;
  var aed = 4.86;
  var aud = 12.55;
  var cad = 14.0;
  var chf = 18.95;
  var dkk = 2.47;
  var jpy = 0.1342;
  var kwd = 58.0;
  var nok = 1.87;
  var sar = 4.73;
  var sek = 1.78;
  double lira = 1;

  TextEditingController miktarController = TextEditingController();
  String dropdownValue = 'TRY';
  var selectedDoviz;
  int? miktar = 0;

  void getCurrencyData() async {
    NetworkHelper helper =
        NetworkHelper('https://api.exchangerate.host/convert?from=USD&to=TRY');
    dolarData = await helper.requestData();
    dolar = dolarData['result'];

    helper =
        NetworkHelper('https://api.exchangerate.host/convert?from=EUR&to=TRY');
    euroData = await helper.requestData();
    euro = euroData['result'];

    helper =
        NetworkHelper('https://api.exchangerate.host/convert?from=GBP&to=TRY');
    poundData = await helper.requestData();
    pound = poundData['result'];

    helper =
        NetworkHelper('https://api.exchangerate.host/convert?from=AED&to=TRY');
    aedData = await helper.requestData();
    aed = aedData['result'];

    helper =
        NetworkHelper('https://api.exchangerate.host/convert?from=AUD&to=TRY');
    audData = await helper.requestData();
    aud = audData['result'];

    helper =
        NetworkHelper('https://api.exchangerate.host/convert?from=CAD&to=TRY');
    cadData = await helper.requestData();
    cad = cadData['result'];

    helper =
        NetworkHelper('https://api.exchangerate.host/convert?from=CHF&to=TRY');
    chfData = await helper.requestData();
    chf = chfData['result'];

    helper =
        NetworkHelper('https://api.exchangerate.host/convert?from=DKK&to=TRY');
    dkkData = await helper.requestData();
    dkk = dkkData['result'];

    helper =
        NetworkHelper('https://api.exchangerate.host/convert?from=JPY&to=TRY');
    jpyData = await helper.requestData();
    jpy = jpyData['result'];

    helper =
        NetworkHelper('https://api.exchangerate.host/convert?from=KWD&to=TRY');
    kwdData = await helper.requestData();
    kwd = kwdData['result'];

    helper =
        NetworkHelper('https://api.exchangerate.host/convert?from=NOK&to=TRY');
    nokData = await helper.requestData();
    nok = nokData['result'];

    helper =
        NetworkHelper('https://api.exchangerate.host/convert?from=SAR&to=TRY');
    sarData = await helper.requestData();
    sar = sarData['result'];

    helper =
        NetworkHelper('https://api.exchangerate.host/convert?from=SEK&to=TRY');
    sekData = await helper.requestData();
    sek = sekData['result'];
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

  List<DropdownMenuItem<String>> dovizList = <String>[
    'TRY',
    'USD',
    'EUR',
    'GBP',
    'AED',
    'AUD',
    'CAD',
    'CHF',
    'DKK',
    'JPY',
    'KWD',
    'NOK',
    'SAR',
    'SEK',
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Center(
        child: Text(value, style: const TextStyle(fontSize: 18)),
      ),
    );
  }).toList();

  void onMiktarChanged() {
    setState(() {
      miktar = int.tryParse(miktarController.text);

      miktar ??= 0;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedDoviz = lira;
    miktarController.addListener(onMiktarChanged);
    getCurrencyData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextField(
                    controller: miktarController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      icon: const Icon(
                        Icons.payments_outlined,
                        color: Colors.greenAccent,
                      ),
                      labelText: 'Miktar',
                      hintText: 'Örnek: 100000',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.blue),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.red),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('${currencyEmojis[dropdownValue]}'),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.white),
                          underline: Container(
                            height: 0,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;

                              switch (dropdownValue) {
                                case 'TRY':
                                  selectedDoviz = lira;
                                  break;
                                case 'USD':
                                  selectedDoviz = dolar;
                                  break;
                                case 'EUR':
                                  selectedDoviz = euro;
                                  break;
                                case 'GBP':
                                  selectedDoviz = pound;
                                  break;
                                case 'AED':
                                  selectedDoviz = aed;
                                  break;
                                case 'AUD':
                                  selectedDoviz = aud;
                                  break;
                                case 'CAD':
                                  selectedDoviz = cad;
                                  break;
                                case 'CHF':
                                  selectedDoviz = chf;
                                  break;
                                case 'DKK':
                                  selectedDoviz = dkk;
                                  break;
                                case 'JPY':
                                  selectedDoviz = jpy;
                                  break;
                                case 'KWD':
                                  selectedDoviz = kwd;
                                  break;
                                case 'NOK':
                                  selectedDoviz = nok;
                                  break;
                                case 'SAR':
                                  selectedDoviz = sar;
                                  break;
                                case 'SEK':
                                  selectedDoviz = sek;
                                  break;

                                default:
                                  {
                                    selectedDoviz = lira;
                                  }
                              }
                            });
                          },
                          items: dovizList,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            buildListTile('🇹🇷', 'TRY', lira),
            buildListTile('🇺🇸', 'USD', dolar),
            buildListTile('🇪🇺', 'EUR', euro),
            buildListTile('🇬🇧', 'GBP', pound),
            buildListTile('🇦🇪', 'AED', aed),
            buildListTile('🇦🇺', 'AUD', aud),
            buildListTile('🇨🇦', 'CAD', cad),
            buildListTile('🇨🇭', 'CHF', chf),
            buildListTile('🇩🇰', 'DKK', dkk),
            buildListTile('🇯🇵', 'JPY', jpy),
            buildListTile('🇰🇼', 'KWD', kwd),
            buildListTile('🇳🇴', 'NOK', nok),
            buildListTile('🇸🇦', 'SAR', sar),
            buildListTile('🇸🇪', 'SEK', sek),
          ],
        ),
      ),
    );
  }

  Padding buildListTile(String flag, String country, double currency) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.cyan),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          leading: Text(
            flag,
            style: const TextStyle(fontSize: 25),
          ),
          title: Text(country),
          trailing:
              Text((miktar! * selectedDoviz / currency).toStringAsFixed(4)),
        ),
      ),
    );
  }
}

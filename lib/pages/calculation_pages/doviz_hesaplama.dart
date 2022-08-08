import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/calculation_pages/vadeli_mevduat_hesaplama.dart';
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

  var euro = 18.25;
  var dolar = 17.931;
  var pound = 21.669;
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
  }

  Icon liraIcon = const Icon(
    Icons.currency_lira_outlined,
    color: Colors.green,
  );
  Icon usdIcon = const Icon(
    Icons.attach_money_outlined,
    color: Colors.green,
  );
  Icon euroIcon = const Icon(
    Icons.euro_symbol_outlined,
    color: Colors.green,
  );
  Icon poundIcon = const Icon(
    Icons.currency_pound_outlined,
    color: Colors.green,
  );

  Icon dovizIcon = const Icon(
    Icons.currency_lira_outlined,
    color: Colors.green,
  );

  List<DropdownMenuItem<String>> dovizList = <String>[
    'TRY',
    'USD',
    'EUR',
    'GBP'
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
                      dovizIcon,
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
                                  dovizIcon = liraIcon;
                                  selectedDoviz = lira;
                                  break;
                                case 'USD':
                                  dovizIcon = usdIcon;
                                  selectedDoviz = dolar;
                                  break;
                                case 'EUR':
                                  dovizIcon = euroIcon;
                                  selectedDoviz = euro;
                                  break;
                                case 'GBP':
                                  dovizIcon = poundIcon;
                                  selectedDoviz = pound;
                                  break;
                                default:
                                  {
                                    dovizIcon = liraIcon;
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
            ListTile(
                title: const Text('TRY'),
                leading: const Text(
                  '🇹🇷',
                  style: TextStyle(fontSize: 25),
                ),
                trailing:
                    Text((miktar! * selectedDoviz / lira).toStringAsFixed(4))),
            ListTile(
                leading: const Text('🇺🇸', style: TextStyle(fontSize: 25)),
                title: const Text('USD'),
                trailing:
                    Text((miktar! * selectedDoviz / dolar).toStringAsFixed(4))),
            ListTile(
                leading: const Text('🇪🇺', style: TextStyle(fontSize: 25)),
                title: const Text('EUR'),
                trailing:
                    Text((miktar! * selectedDoviz / euro).toStringAsFixed(4))),
            ListTile(
                leading: const Text('🇬🇧', style: TextStyle(fontSize: 25)),
                title: const Text('GBP'),
                trailing:
                    Text((miktar! * selectedDoviz / pound).toStringAsFixed(4))),
          ],
        ),
      ),
    );
  }
}

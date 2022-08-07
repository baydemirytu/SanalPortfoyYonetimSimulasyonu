import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VadeliMevduatHesaplama extends StatefulWidget {
  const VadeliMevduatHesaplama({Key? key}) : super(key: key);

  @override
  State<VadeliMevduatHesaplama> createState() => _VadeliMevduatHesaplamaState();
}

class _VadeliMevduatHesaplamaState extends State<VadeliMevduatHesaplama> {
  TextEditingController anaParaController = TextEditingController();

  bool anaParaValidate = true;
  String anaParaError = '1.000 - 5.000.000 TRY';

  String dropdownValue = 'TRY';

  List<DropdownMenuItem<String>> dovizList = <String>[
    'TRY',
    'USD',
    'EUR',
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Center(
        child: Text(value, style: const TextStyle(fontSize: 18)),
      ),
    );
  }).toList();

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
  Icon dovizIcon = const Icon(
    Icons.currency_lira_outlined,
    color: Colors.green,
  );

  final List<List<double>> liraFaizOranlari = [
    [4.5, 8.75, 11.65, 11.65, 11.65, 11.80, 11.80],
    [4.5, 15, 16, 16, 16.5, 16.5, 17],
    [4.5, 15.5, 16.5, 16.5, 17, 17, 17.5],
    [4.5, 5.05, 5.35, 5.35, 5.65, 5.7, 5.7]
  ];

  final List<List<double>> dolarFaizOranlari = [
    [0.1, 0.1, 0.1, 0.1],
    [0.35, 0.35, 0.35, 0.35],
    [0.6, 0.6, 0.6, 0.6],
    [0.1, 0.1, 0.1, 0.1]
  ];

  final List<List<double>> euroFaizOranlari = [
    [0.01, 0.01, 0.01, 0.01],
    [0.1, 0.1, 0.1, 0.1],
    [0.2, 0.2, 0.2, 0.2],
    [0.01, 0.01, 0.01, 0.01]
  ];

  int vadegun = 28;
  int daysIndex = 0;
  double brutGetiri = 0;
  double netGetiri = 0;
  double faizOrani = 0;
  String brutMessage = '';
  String netMessage = '';

  void liraGunIndexSec() {
    if (vadegun <= 31) {
      daysIndex = 0;
    } else if (32 <= vadegun && vadegun <= 91) {
      daysIndex = 1;
    } else if (92 <= vadegun && vadegun <= 368) {
      daysIndex = 2;
    } else if (369 <= vadegun && vadegun <= 730) {
      daysIndex = 3;
    }
  }

  void dolarGunIndexSec() {
    if (vadegun <= 91) {
      daysIndex = 0;
    } else if (92 <= vadegun && vadegun <= 182) {
      daysIndex = 1;
    } else if (183 <= vadegun && vadegun <= 364) {
      daysIndex = 2;
    } else if (365 <= vadegun && vadegun <= 730) {
      daysIndex = 3;
    }
  }

  void euroGunIndexSec() {
    if (vadegun <= 91) {
      daysIndex = 0;
    } else if (92 <= vadegun && vadegun <= 182) {
      daysIndex = 1;
    } else if (183 <= vadegun && vadegun <= 364) {
      daysIndex = 2;
    } else if (365 <= vadegun && vadegun <= 730) {
      daysIndex = 3;
    }
  }

  void liraFaizHesapla() {
    int? anaPara = int.tryParse(anaParaController.text);
    if (anaPara == null || anaPara < 1000 || anaPara > 5000000) {
      anaParaError = '1.000 - 5.000.000 TRY';
      anaParaValidate = false;
    } else {
      anaParaValidate = true;
      if (1000 <= anaPara && anaPara < 10000) {
        faizOrani = liraFaizOranlari[daysIndex][0];
      } else if (10000 <= anaPara && anaPara < 50000) {
        faizOrani = liraFaizOranlari[daysIndex][1];
      } else if (50000 <= anaPara && anaPara < 100000) {
        faizOrani = liraFaizOranlari[daysIndex][2];
      } else if (100000 <= anaPara && anaPara < 250000) {
        faizOrani = liraFaizOranlari[daysIndex][3];
      } else if (250000 <= anaPara && anaPara < 500000) {
        faizOrani = liraFaizOranlari[daysIndex][4];
      } else if (500000 <= anaPara && anaPara < 1000000) {
        faizOrani = liraFaizOranlari[daysIndex][5];
      } else if (1000000 <= anaPara && anaPara <= 5000000) {
        faizOrani = liraFaizOranlari[daysIndex][6];
      }
      brutGetiri = anaPara * faizOrani * vadegun / 36500;

      brutMessage =
          '% $faizOrani faiz ile brüt getiri: ${brutGetiri.toStringAsFixed(2)} $dropdownValue';
      if (vadegun < 180) {
        netGetiri = brutGetiri * 0.95;
      } else if (180 < vadegun && vadegun < 365) {
        netGetiri = brutGetiri * 0.97;
      } else {
        netGetiri = brutGetiri;
      }
      netMessage =
          '% $faizOrani faiz ile net getiri: ${netGetiri.toStringAsFixed(2)} $dropdownValue';
    }
  }

  void dolarFaizHesapla() {
    int? anaPara = int.tryParse(anaParaController.text);
    if (anaPara == null || anaPara < 25000 || anaPara > 1000000) {
      anaParaError = '25.000 - 1.000.000 USD';
      anaParaValidate = false;
    } else {
      anaParaValidate = true;
      if (25000 <= anaPara && anaPara < 100000) {
        faizOrani = dolarFaizOranlari[daysIndex][0];
      } else if (100000 <= anaPara && anaPara < 250000) {
        faizOrani = dolarFaizOranlari[daysIndex][1];
      } else if (250000 <= anaPara && anaPara < 500000) {
        faizOrani = dolarFaizOranlari[daysIndex][2];
      } else if (500000 <= anaPara && anaPara <= 1000000) {
        faizOrani = dolarFaizOranlari[daysIndex][3];
      }
      brutGetiri = anaPara * faizOrani * vadegun / 36500;

      brutMessage =
          '% $faizOrani faiz ile brüt getiri: ${brutGetiri.toStringAsFixed(2)} $dropdownValue';
      if (vadegun < 366) {
        netGetiri = brutGetiri * 0.80;
      } else {
        netGetiri = brutGetiri * 0.82;
      }
      netMessage =
          '% $faizOrani faiz ile net getiri: ${netGetiri.toStringAsFixed(2)} $dropdownValue';
    }
  }

  void euroFaizHesapla() {
    int? anaPara = int.tryParse(anaParaController.text);
    if (anaPara == null || anaPara < 25000 || anaPara > 1000000) {
      anaParaError = '50.000 - 1.000.000 EUR';
      anaParaValidate = false;
    } else {
      anaParaValidate = true;
      if (50000 <= anaPara && anaPara < 100000) {
        faizOrani = euroFaizOranlari[daysIndex][0];
      } else if (100000 <= anaPara && anaPara < 250000) {
        faizOrani = euroFaizOranlari[daysIndex][1];
      } else if (250000 <= anaPara && anaPara < 500000) {
        faizOrani = euroFaizOranlari[daysIndex][2];
      } else if (500000 <= anaPara && anaPara <= 1000000) {
        faizOrani = euroFaizOranlari[daysIndex][3];
      }
      brutGetiri = anaPara * faizOrani * vadegun / 36500;

      brutMessage =
          '% $faizOrani faiz ile brüt getiri: ${brutGetiri.toStringAsFixed(2)} $dropdownValue';
      if (vadegun < 366) {
        netGetiri = brutGetiri * 0.80;
      } else {
        netGetiri = brutGetiri * 0.82;
      }
      netMessage =
          '% $faizOrani faiz ile net getiri: ${netGetiri.toStringAsFixed(2)} $dropdownValue';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 8, bottom: 8, top: 8),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextField(
                    controller: anaParaController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      icon: const Icon(
                        Icons.payments_outlined,
                        color: Colors.greenAccent,
                      ),
                      errorText: anaParaValidate ? null : anaParaError,
                      labelText: 'Ana Para',
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
                                  break;
                                case 'USD':
                                  dovizIcon = usdIcon;
                                  break;
                                case 'EUR':
                                  dovizIcon = euroIcon;
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
            Slider(
              min: 28,
              max: 730,
              value: vadegun.toDouble(),
              divisions: 703,
              label: vadegun.toStringAsFixed(0),
              onChanged: (value) {
                setState(() {
                  vadegun = value.toInt();
                  if (dropdownValue == 'TRY') {
                    liraGunIndexSec();
                  } else if (dropdownValue == 'USD') {
                    dolarGunIndexSec();
                  } else if (dropdownValue == 'EUR') {
                    euroGunIndexSec();
                  }
                });
              },
            ),
            Text('$vadegun gün'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                if (dropdownValue == 'TRY') {
                  liraFaizHesapla();
                } else if (dropdownValue == 'USD') {
                  dolarFaizHesapla();
                } else if (dropdownValue == 'EUR') {
                  euroFaizHesapla();
                }
                setState(() {});
              },
              child: const Text(
                'Hesapla',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              brutMessage,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              netMessage,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 40),
            const Text(
              '* Faiz oranları YapıKredi Bankası\'nın vadeli mevduat faiz oranları baz alınarak hesaplanmıştır.\n** Brüt ve Net gelir arasındaki fark stopajdan kaynaklanmaktadır.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 30),
            ExpansionTile(
              backgroundColor: Colors.black12,
              title: const Text(
                'TRY Faiz Oranları',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              children: [
                Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(children: [
                      buildTableCell(''),
                      buildTableCell('28-31 gün'),
                      buildTableCell('32-91 gün'),
                      buildTableCell('92-368 gün'),
                      buildTableCell('369-730 gün'),
                    ]),
                    TableRow(children: [
                      buildTableCell('1.000-\n9.999 TRY'),
                      buildTableCell(
                          '% ${liraFaizOranlari[0][0].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${liraFaizOranlari[1][0].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${liraFaizOranlari[2][0].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${liraFaizOranlari[3][0].toStringAsFixed(2)}'),
                    ]),
                    TableRow(children: [
                      buildTableCell('10.000-\n49.999 TRY'),
                      buildTableCell(
                          '% ${liraFaizOranlari[0][1].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${liraFaizOranlari[1][1].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${liraFaizOranlari[2][1].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${liraFaizOranlari[3][1].toStringAsFixed(2)}'),
                    ]),
                    TableRow(children: [
                      buildTableCell('50.000-\n99.999 TRY'),
                      buildTableCell(
                          '% ${liraFaizOranlari[0][2].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${liraFaizOranlari[1][2].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${liraFaizOranlari[2][2].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${liraFaizOranlari[3][2].toStringAsFixed(2)}'),
                    ]),
                    TableRow(children: [
                      buildTableCell('100.000-\n249.999 TRY'),
                      buildTableCell(
                          '% ${liraFaizOranlari[0][3].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${liraFaizOranlari[1][3].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${liraFaizOranlari[2][3].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${liraFaizOranlari[3][3].toStringAsFixed(2)}'),
                    ]),
                    TableRow(children: [
                      buildTableCell('250.000-\n499.999 TRY'),
                      buildTableCell(
                          '% ${liraFaizOranlari[0][4].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${liraFaizOranlari[1][4].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${liraFaizOranlari[2][4].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${liraFaizOranlari[3][4].toStringAsFixed(2)}'),
                    ]),
                    TableRow(children: [
                      buildTableCell('500.000-\n999.999 TRY'),
                      buildTableCell(
                          '% ${liraFaizOranlari[0][5].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${liraFaizOranlari[1][5].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${liraFaizOranlari[2][5].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${liraFaizOranlari[3][5].toStringAsFixed(2)}'),
                    ]),
                    TableRow(children: [
                      buildTableCell('1.000.000-\n5.000.000 TRY'),
                      buildTableCell(
                          '% ${liraFaizOranlari[0][6].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${liraFaizOranlari[1][6].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${liraFaizOranlari[2][6].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${liraFaizOranlari[3][6].toStringAsFixed(2)}'),
                    ]),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              backgroundColor: Colors.black12,
              title: const Text(
                'USD Faiz Oranları',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              children: [
                Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(children: [
                      buildTableCell(''),
                      buildTableCell('28-91 gün'),
                      buildTableCell('92-182 gün'),
                      buildTableCell('183-364 gün'),
                      buildTableCell('365-730 gün'),
                    ]),
                    TableRow(children: [
                      buildTableCell('25.000-\n99.999 USD'),
                      buildTableCell(
                          '% ${dolarFaizOranlari[0][0].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${dolarFaizOranlari[1][0].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${dolarFaizOranlari[2][0].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${dolarFaizOranlari[3][0].toStringAsFixed(2)}'),
                    ]),
                    TableRow(children: [
                      buildTableCell('100.000-\n249.999 USD'),
                      buildTableCell(
                          '% ${dolarFaizOranlari[0][1].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${dolarFaizOranlari[1][1].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${dolarFaizOranlari[2][1].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${dolarFaizOranlari[3][1].toStringAsFixed(2)}'),
                    ]),
                    TableRow(children: [
                      buildTableCell('250.000-\n499.999 USD'),
                      buildTableCell(
                          '% ${dolarFaizOranlari[0][2].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${dolarFaizOranlari[1][2].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${dolarFaizOranlari[2][2].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${dolarFaizOranlari[3][2].toStringAsFixed(2)}'),
                    ]),
                    TableRow(children: [
                      buildTableCell('500.000-\n1.000.000 USD'),
                      buildTableCell(
                          '% ${dolarFaizOranlari[0][3].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${dolarFaizOranlari[1][3].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${dolarFaizOranlari[2][3].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${dolarFaizOranlari[3][3].toStringAsFixed(2)}'),
                    ]),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              backgroundColor: Colors.black12,
              title: const Text(
                'EUR Faiz Oranları',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              children: [
                Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(children: [
                      buildTableCell(''),
                      buildTableCell('28-91 gün'),
                      buildTableCell('92-182 gün'),
                      buildTableCell('183-364 gün'),
                      buildTableCell('365-730 gün'),
                    ]),
                    TableRow(children: [
                      buildTableCell('50.000-\n99.999 EUR'),
                      buildTableCell(
                          '% ${euroFaizOranlari[0][0].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${euroFaizOranlari[1][0].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${euroFaizOranlari[2][0].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${euroFaizOranlari[3][0].toStringAsFixed(2)}'),
                    ]),
                    TableRow(children: [
                      buildTableCell('100.000-\n249.999 EUR'),
                      buildTableCell(
                          '% ${euroFaizOranlari[0][1].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${euroFaizOranlari[1][1].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${euroFaizOranlari[2][1].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${euroFaizOranlari[3][1].toStringAsFixed(2)}'),
                    ]),
                    TableRow(children: [
                      buildTableCell('250.000-\n499.999 EUR'),
                      buildTableCell(
                          '% ${euroFaizOranlari[0][2].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${euroFaizOranlari[1][2].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${euroFaizOranlari[2][2].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${euroFaizOranlari[3][2].toStringAsFixed(2)}'),
                    ]),
                    TableRow(children: [
                      buildTableCell('500.000-\n1.000.000 EUR'),
                      buildTableCell(
                          '% ${euroFaizOranlari[0][3].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${euroFaizOranlari[1][3].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${euroFaizOranlari[2][3].toStringAsFixed(2)}'),
                      buildTableCell(
                          '% ${euroFaizOranlari[3][3].toStringAsFixed(2)}'),
                    ]),
                  ],
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }

  TableCell buildTableCell(String text) {
    return TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Text(
          text,
          textAlign: TextAlign.center,
        ));
  }

  @override
  void dispose() {
    anaParaController.dispose();
    super.dispose();
  }
}

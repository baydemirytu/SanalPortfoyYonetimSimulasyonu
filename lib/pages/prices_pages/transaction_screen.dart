import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen(this.currencyType, this.transactionType,
      this.currencyRate, this.currencyFlag);
  final double currencyRate;
  final String currencyType;
  final String transactionType;
  final String currencyFlag;

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  late double currencyRate;
  late String currencyType;
  late String transactionType;
  late String currencyFlag;
  late String shownFlag;
  late String shownType;

  Color? tryColor = Colors.grey[700];
  Color? excColor = Colors.black;

  double transactionLiraAmount = 0;
  double transactionFXAmount = 0;
  double enteredAmount = 0;

  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    currencyRate = widget.currencyRate;
    transactionType = widget.transactionType;
    currencyType = widget.currencyType;
    currencyFlag = widget.currencyFlag;
    shownFlag = widget.currencyFlag;
    shownType = widget.currencyType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('$currencyType $transactionType İşlemi'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: excColor,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          excColor = Colors.black;
                          tryColor = Colors.grey[700];
                          shownFlag = currencyFlag;
                          shownType = currencyType;
                        });
                      },
                      child: Text(
                        currencyType,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: tryColor,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          excColor = Colors.grey[700];
                          tryColor = Colors.black;
                          shownFlag = '🇹🇷';
                          shownType = 'TRY';
                        });
                      },
                      child: const Text(
                        'TRY',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                icon: Text(
                  shownFlag,
                  style: const TextStyle(fontSize: 32),
                ),
                fillColor: Colors.white,
                hintText: '$shownType cinsinden tutar giriniz',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (text) {
                if (text != '') {
                  enteredAmount = double.parse(text);
                } else {
                  enteredAmount = 0;
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.deepOrangeAccent,
                    child: TextButton(
                      onPressed: () {
                        if (enteredAmount > 0) {
                          if (excColor == Colors.black) {
                            transactionLiraAmount = double.parse(
                                (enteredAmount * currencyRate)
                                    .toStringAsFixed(2));
                            transactionFXAmount = enteredAmount;
                          } else {
                            transactionLiraAmount = enteredAmount;
                            transactionFXAmount = double.parse(
                                (enteredAmount / currencyRate)
                                    .toStringAsFixed(2));
                          }
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('İşleminizi Onaylayın'),
                                content: Text(
                                    '$transactionLiraAmount TRY karşılığında '
                                    '$transactionFXAmount $currencyType '
                                    '${transactionType.toLowerCase()}ı '
                                    'gerçekleştirmeyi onaylıyor musunuz?'
                                    '\n\nİşlem Kuru: '
                                    '${currencyRate.toStringAsFixed(4)}'),
                                actions: [
                                  MaterialButton(
                                    child: const Text('Evet'),
                                    onPressed: () async {
                                      DocumentSnapshot variable =
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user.uid)
                                              .get();
                                      // 1) İşlem alım mı satım mı belirleme
                                      if (transactionType.toLowerCase() ==
                                          'alım') {
                                        // 2 - Alım işlemi yapacak bakiye var mı kontrolü (transactionTryAmounttan)
                                        if (transactionLiraAmount <=
                                            variable.get('Current Balance')) {
                                          double newTL =
                                              variable.get('Current Balance') -
                                                  transactionLiraAmount;
                                          double newCurrency = variable.get(
                                                  'Yatırım.Döviz.$currencyType') +
                                              transactionFXAmount;
                                          final docUser = FirebaseFirestore
                                              .instance
                                              .collection('users')
                                              .doc(user.uid);
                                          // 3 - Varsa transactionTryAmount'un arka tarafta düşülmesi, transactionFXAmountun eklenmesi.
                                          docUser.update(
                                            {
                                              'Current Balance': newTL,
                                              'Yatırım.Döviz.$currencyType':
                                                  newCurrency,
                                            },
                                          );
                                          Navigator.pop(context);
                                          FocusScope.of(context).unfocus();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Alımınız gerçekleşti',
                                              ),
                                            ),
                                          );
                                        } else {
                                          // 4 - Yoksa hata mesajı basılması.
                                          Navigator.pop(context);
                                          FocusScope.of(context).unfocus();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Yeterli bakiyeniz yok',
                                              ),
                                            ),
                                          );
                                        }
                                      } else if (transactionType
                                              .toLowerCase() ==
                                          'satım') {
                                        // 2 - Satış işlemi yapacak bakiye var mı kontrolü (transactionTryAmounttan)
                                        if (transactionFXAmount <=
                                            variable.get(
                                                'Yatırım.Döviz.$currencyType')) {
                                          double newTL =
                                              variable.get('Current Balance') +
                                                  transactionLiraAmount;
                                          double newCurrency = variable.get(
                                                  'Yatırım.Döviz.$currencyType') -
                                              transactionFXAmount;
                                          final docUser = FirebaseFirestore
                                              .instance
                                              .collection('users')
                                              .doc(user.uid);
                                          docUser.update(
                                            {
                                              'Current Balance': newTL,
                                              'Yatırım.Döviz.$currencyType':
                                                  newCurrency,
                                            },
                                          );
                                          Navigator.pop(context);
                                          FocusScope.of(context).unfocus();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Satımınız gerçekleşti',
                                              ),
                                            ),
                                          );
                                        } else {
                                          Navigator.pop(context);
                                          FocusScope.of(context).unfocus();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Yeterli döviziniz yok',
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                  ),
                                  MaterialButton(
                                    child: const Text('Hayır'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Uyarı'),
                                  content: const Text(
                                      'Lütfen geçerli bir tutar girin.'),
                                  actions: [
                                    MaterialButton(
                                        child: const Text('Tamam'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ],
                                );
                              });
                        }
                      },
                      child: const Text(
                        'Devam',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

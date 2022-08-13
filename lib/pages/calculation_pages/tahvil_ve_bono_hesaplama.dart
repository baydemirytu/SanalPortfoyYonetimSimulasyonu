import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import "package:flutter/services.dart";

class TahvilVeBonoHesaplamaFonksiyonu {
  TahvilVeBonoHesaplamaFonksiyonu({
    required this.anaPara,
    required this.yillikFaiz,
    required this.kalanGun,
  });

  final int anaPara;
  final double yillikFaiz;
  final int kalanGun;

  double getiri() {
    double sonuc;
    sonuc = ((yillikFaiz / 365) / 100) * anaPara * kalanGun;
    return sonuc;
  }
}

class BilesikFaizHesaplamaFonksiyonu {
  BilesikFaizHesaplamaFonksiyonu({
    required this.basitFaiz,
    required this.kalanGun,
  });

  final double basitFaiz;
  final int kalanGun;

  double bilesikFaiz() {
    double sonuc;
    sonuc =
        (pow(1 + basitFaiz / 100 * kalanGun / 365, 365 / kalanGun) - 1) * 100;
    return sonuc;
  }
}

class TahvilVeBono extends StatefulWidget {
  const TahvilVeBono({Key? key}) : super(key: key);

  @override
  State<TahvilVeBono> createState() => _TahvilVeBonoState();
}

class _TahvilVeBonoState extends State<TahvilVeBono> {
  final TextEditingController remaningDaysInput = TextEditingController();
  final TextEditingController dateInput = TextEditingController();
  final TextEditingController anaParaController = TextEditingController();
  final TextEditingController faizController = TextEditingController();
  final TextEditingController fiyatController = TextEditingController();
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 1));

  bool validateDays = true;
  bool validateFiyat = true;
  bool isPlaying = true;

  double getiri = 0;
  double bilesikFaiz = 0;

  @override
  void initState() {
    remaningDaysInput.addListener(this.onRemainingDaysChanged);
    dateInput.addListener(this.onDateChanged);
    fiyatController.addListener(this.onFiyatChanged);
    faizController.addListener(this.onFaizChanged);
    super.initState();
  }

  void onFaizChanged() {
    faizController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: faizController.text.length,
      ),
    );
    double? faiz = double.tryParse(faizController.text);
    int? days = int.tryParse(remaningDaysInput.text);

    if (days != null && faiz != null) {
      double fiyat =
          100 / (faiz / (365 / int.parse(remaningDaysInput.text)) + 1);
      if (fiyatController.text != fiyat.toStringAsFixed(2)) {
        fiyatController.text = fiyat.toStringAsFixed(2);
      }
    }
    setState(() {});
  }

  void onFiyatChanged() {
    fiyatController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: fiyatController.text.length,
      ),
    );
    double? fiyatControllerInt = double.tryParse(fiyatController.text);
    print(fiyatControllerInt);
    if (fiyatControllerInt != null &&
        fiyatControllerInt >= 50 &&
        fiyatControllerInt <= 200) {
      validateFiyat = true;
      if (remaningDaysInput.text != null) {
        double basitFaiz = (100 / fiyatControllerInt - 1) *
            (365 / int.parse(remaningDaysInput.text));

        if (faizController.text != basitFaiz.toStringAsFixed(4)) {
          faizController.text = basitFaiz.toStringAsFixed(4);

          // Eğer fiyat girilirse Basit Faiz= (İtfa fiyatı/Fiyat-1)(Yıl gün sayısı/Vadeye kalan gün sayısı)100 formülü ile Basit Faiz bulunacak,
          // sonra YBF girilmiş gibi hesaplama devam edecek
        }
      }
    } else {
      validateFiyat = false;
    }
    setState(() {});
  }

  void onRemainingDaysChanged() {
    remaningDaysInput.selection = TextSelection.fromPosition(
      TextPosition(
        offset: remaningDaysInput.text.length,
      ),
    );
    int? days = int.tryParse(remaningDaysInput.text);
    if (days != null && days < 100000) {
      validateDays = true;
      DateTime dt = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day + days + 1);
      dateInput.text = DateFormat('dd-MM-yyyy').format(dt);
    } else if (days != null && days >= 100000) {
      validateDays = false;
    }
    setState(() {});
  }

  void onDateChanged() {
    DateTime dt = DateTime.parse(dateInput.text);
    remaningDaysInput.text = dt.difference(DateTime.now()).inDays.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 8, bottom: 8, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: anaParaController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: 'Ana Para',
                hintText: 'Örnek: 100000',
                icon: const Icon(
                  Icons.currency_lira,
                  color: Colors.greenAccent,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.blue),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.red),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const Divider(
              height: 25,
              color: Colors.white,
              thickness: 0.5,
            ),
            TextField(
              controller: dateInput,
              decoration: InputDecoration(
                icon: const Icon(Icons.date_range_sharp, color: Colors.white),
                hintText: 'Örnek: 01.01.2023',
                labelText: 'Vade Bitiş Tarihi',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.blue),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.red),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                  context: context,
                  initialDate: DateTime(DateTime.now().year,
                      DateTime.now().month, DateTime.now().day + 1), // tomorrow
                  firstDate: DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day + 1), // tomorrow
                  lastDate: DateTime(2099),
                );

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);

                  setState(
                    () {
                      dateInput.text = formattedDate;
                    },
                  );
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: remaningDaysInput,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                errorText: !validateDays ? '100000\'den az değer girin' : null,
                icon: const Icon(
                  Icons.hourglass_bottom,
                  color: Colors.deepOrange,
                ),
                hintText: 'Örnek: 50',
                labelText: 'Vadeye Kalan Gün',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.blue),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.red),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const Divider(
              height: 25,
              color: Colors.white,
              thickness: 0.5,
            ),
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: TextField(
                    controller: faizController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                      FilteringTextInputFormatter.deny(RegExp('[.][.]'))
                    ],
                    decoration: InputDecoration(
                      icon: const Icon(Icons.percent, color: Colors.blueGrey),
                      labelText: 'Basit Faiz Oranı (%)',
                      hintText: 'Örnek: 14.1',
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
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 5,
                  child: TextField(
                    controller: fiyatController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                      FilteringTextInputFormatter.deny(RegExp('[.][.]'))
                    ],
                    decoration: InputDecoration(
                      icon: const Icon(
                        Icons.payments_outlined,
                        color: Colors.lightGreen,
                      ),
                      labelText: 'Fiyat',
                      hintText: 'Örnek: 200',
                      errorText: !validateFiyat ? '50-200' : null,
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
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                double? fiyat = double.tryParse(fiyatController.text);
                if (fiyat != null && fiyat >= 50 && fiyat <= 200) {
                  TahvilVeBonoHesaplamaFonksiyonu f =
                      TahvilVeBonoHesaplamaFonksiyonu(
                    anaPara: int.parse(anaParaController.text),
                    yillikFaiz: double.parse(faizController.text),
                    kalanGun: int.parse(remaningDaysInput.text),
                  );
                  BilesikFaizHesaplamaFonksiyonu b =
                      BilesikFaizHesaplamaFonksiyonu(
                          basitFaiz: double.parse(faizController.text),
                          kalanGun: int.parse(remaningDaysInput.text));
                  getiri = f.getiri();
                  bilesikFaiz = b.bilesikFaiz();
                  if (getiri > 0) {
                    _confettiController.play();
                  }
                  setState(() {});
                }
              },
              child: const Text(
                'Calculate',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.savings_outlined,
                  color: getiri > 0 ? Colors.green : Colors.red,
                  size: 40,
                ),
                Text(
                  'Getiri: ${getiri.toStringAsFixed(2)} TL',
                  style: GoogleFonts.roboto(fontSize: 32, color: Colors.white),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.percent,
                  size: 30,
                  color: Colors.blueGrey,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Bileşik Faiz: ${bilesikFaiz.toStringAsFixed(1)}',
                  style: GoogleFonts.roboto(fontSize: 32, color: Colors.white),
                ),
              ],
            ),
            Center(
              child: ConfettiWidget(
                maxBlastForce: 25,
                minBlastForce: 10,
                particleDrag: 0.05,
                emissionFrequency: 0.05,
                numberOfParticles: 50,
                gravity: 0.05,
                shouldLoop: false,
                blastDirectionality: BlastDirectionality.explosive,
                confettiController: _confettiController,
                colors: [
                  Colors.green,
                  Colors.green.shade200,
                  Colors.green.shade900
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    remaningDaysInput.dispose();
    dateInput.dispose();
    faizController.dispose();
    anaParaController.dispose();
    super.dispose();
  }
}

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

  @override
  void initState() {
    remaningDaysInput.addListener(this.onRemainingDaysChanged);
    dateInput.addListener(this.onDateChanged);
    fiyatController.addListener(this.onFiyatChanged);
    //faizController.addListener(this.onFaizChanged);
    super.initState();
  }

  // void onFaizChanged() {
  //   faizController.selection = TextSelection.fromPosition(
  //     TextPosition(
  //       offset: faizController.text.length,
  //     ),
  //   );
  //   double? faiz = double.tryParse(faizController.text);
  //   int? days = int.tryParse(remaningDaysInput.text);

  //   if (days != null && faiz != null) {
  //     double fiyat =
  //         100 / (faiz / (365 / int.parse(remaningDaysInput.text)) + 1);

  //     fiyatController.text = fiyat.toStringAsFixed(2);
  //   }
  //   setState(() {});
  // }

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
        print(basitFaiz);
        faizController.text = basitFaiz.toStringAsFixed(2);
        // Eğer fiyat girilirse Basit Faiz= (İtfa fiyatı/Fiyat-1)(Yıl gün sayısı/Vadeye kalan gün sayısı)100 formülü ile Basit Faiz bulunacak,
        // sonra YBF girilmiş gibi hesaplama devam edecek
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
            Text(
              'Bono ve Tahvil Hesaplama',
              style: Theme.of(context).textTheme.headline6,
            ),
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
                icon: const Icon(Icons.attach_money),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3, color: Colors.blue),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3, color: Colors.red),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: dateInput,
              decoration: InputDecoration(
                icon: const Icon(Icons.date_range_sharp),
                hintText: 'Örnek: 01.01.2023',
                labelText: 'Vade Bitiş Tarihi',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3, color: Colors.blue),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3, color: Colors.red),
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
                errorText:
                    !validateDays ? 'Enter a day value less than 100000' : null,
                icon: const Icon(Icons.hourglass_bottom),
                hintText: 'Örnek: 50',
                labelText: 'Vadeye Kalan Gün',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3, color: Colors.blue),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3, color: Colors.red),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: TextField(
                    controller: faizController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                    ],
                    decoration: InputDecoration(
                      icon: const Icon(Icons.percent),
                      labelText: 'Basit Faiz Oranı (%)',
                      hintText: 'Örnek: 14',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.blue),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.red),
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
                      FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                    ],
                    decoration: InputDecoration(
                      icon: const Icon(Icons.payments_outlined),
                      labelText: 'Fiyat',
                      hintText: 'Örnek: 200',
                      errorText: !validateFiyat ? '50-200' : null,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.blue),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.red),
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
                TahvilVeBonoHesaplamaFonksiyonu f =
                    TahvilVeBonoHesaplamaFonksiyonu(
                  anaPara: int.parse(anaParaController.text),
                  yillikFaiz: double.parse(faizController.text),
                  kalanGun: int.parse(remaningDaysInput.text),
                );
                getiri = f.getiri();
                print(num.parse(f.getiri().toStringAsFixed(2)));
                if (isPlaying) {
                  _confettiController.play();
                } else {
                  _confettiController.stop();
                }
                isPlaying = !isPlaying;
                setState(() {});
              },
              child: const Text('Calculate'),
            ),
            Text(
              'Getiri: ${getiri.toStringAsFixed(2)} TL',
              style: GoogleFonts.roboto(fontSize: 32, color: Colors.white),
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

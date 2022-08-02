import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "package:flutter/services.dart";

class TahvilVeBono extends StatefulWidget {
  const TahvilVeBono({Key? key}) : super(key: key);

  @override
  State<TahvilVeBono> createState() => _TahvilVeBonoState();
}

class _TahvilVeBonoState extends State<TahvilVeBono> {
  final TextEditingController remaningDaysInput = TextEditingController();
  final TextEditingController dateInput = TextEditingController();
  bool validateDays = true;

  @override
  void initState() {
    remaningDaysInput.addListener(this.onRemainingDaysChanged);
    dateInput.addListener(this.onDateChanged);
    super.initState();
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
      print(dt.year.toString() +
          '-' +
          dt.month.toString() +
          '-' +
          dt.day.toString());
    } else if (days != null && days >= 100000) {
      validateDays = false;
    }
    setState(() {});
  }

  void onDateChanged() {
    DateTime dt = DateTime.parse(dateInput.text);
    remaningDaysInput.text = dt.difference(DateTime.now()).inDays.toString();
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              labelText: 'Ana Para',
              hintText: 'Örnek: 100.000',
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
            decoration: InputDecoration(
              icon: const Icon(Icons.percent),
              labelText: 'Yıllık Basit Faiz Oranı (%)',
              hintText: 'Örnek: 14',
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
          const SizedBox(height: 20),
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
          TextField(
            controller: dateInput,
            decoration: InputDecoration(
              icon: const Icon(Icons.date_range_sharp),
              hintText: 'Örnek: 01.01.2023',
              labelText: 'Ya Da Vade Bitiş Tarihi',
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
                context: context,
                initialDate: DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day + 1), // tomorrow
                firstDate: DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day + 1), // tomorrow
                lastDate: DateTime(2099),
              );

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);

                setState(
                  () {
                    dateInput.text =
                        formattedDate; //set output date to TextField value.
                  },
                );
              } else {
                print("Date is not selected");
              }
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Calculate'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    remaningDaysInput.dispose();
    dateInput.dispose();
    super.dispose();
  }
}

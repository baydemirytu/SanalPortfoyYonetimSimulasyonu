import 'package:flutter/material.dart';

class TahvilVeBono extends StatefulWidget {
  const TahvilVeBono({Key? key}) : super(key: key);

  @override
  State<TahvilVeBono> createState() => _TahvilVeBonoState();
}

class _TahvilVeBonoState extends State<TahvilVeBono> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Bono ve Tahvil Hesaplama',
          style: Theme.of(context).textTheme.headline3,
        ),
        SizedBox(
          height: 10,
        ),
        //TODO box decoration ve controller eklenecek
        TextField(),
        TextField(),
        TextField(),
        TextField(),
      ],
    );
  }
}

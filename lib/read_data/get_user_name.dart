import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String documentID;

  const GetUserName({Key? key, required this.documentID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentID).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          double yuzde = (data['Current Balance'] - data['Initial Balance']) /
              data['Initial Balance'] *
              100;

          return Row(
            children: [
              Expanded(
                  flex: 7,
                  child: Text('${data['First name']} ${data['Last name']}')),
              Expanded(
                  flex: 3,
                  child: Text(
                    '% ${yuzde.toStringAsFixed(3)}',
                    style: TextStyle(
                        color: yuzde >= 0 ? Colors.green : Colors.red),
                  )),
            ],
          );
        }
        return const Text('Loading');
      }),
    );
  }
}

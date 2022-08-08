import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants/widgets/app_bar_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sanal Portföy'),
      ),
      drawer: const AppBarDrawer(),
      body: Center(
        child: Column(
          children: [
            FutureBuilder<DocumentSnapshot>(
              future: users.doc(user.uid).get(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Text(
                    'Your balance is ${data['Balance']} TL',
                    style: const TextStyle(fontSize: 36),
                  );
                }
                return const Text('Loading');
              }),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/pages/portfolio_page.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/read_data/get_user_name.dart';
import '../constants/widgets/app_bar_drawer.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  List<String> docIDS = [];
  List<String> finaldocIDS = [];

  Map<String, double> kullanicilarVeYuzdeler = {};

  Future getDocIDs() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('On The Leader Board', isEqualTo: true)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (element) {
              docIDS.add(element.reference.id);
            },
          ),
        );
  }

  Future setDocsIDSOrder() async {
    await getDocIDs();
    for (final id in docIDS) {
      DocumentSnapshot variable =
          await FirebaseFirestore.instance.collection('users').doc(id).get();
      double yuzde =
          (variable['Current Balance'] - variable['Initial Balance']) /
              variable['Initial Balance'] *
              100;
      kullanicilarVeYuzdeler[id] = yuzde;
    }
    print(kullanicilarVeYuzdeler);

    var sortMapByValue = Map.fromEntries(kullanicilarVeYuzdeler.entries.toList()
      ..sort((e2, e1) => e1.value.compareTo(e2.value)));

    print(sortMapByValue);

    for (final a in sortMapByValue.keys) {
      finaldocIDS.add(a);
    }
  }

  var medals = [
    FaIcon(
      FontAwesomeIcons.medal,
      color: Colors.amber[400],
    ),
    FaIcon(
      FontAwesomeIcons.medal,
      color: Colors.grey[400],
    ),
    FaIcon(
      FontAwesomeIcons.medal,
      color: Color.fromARGB(176, 141, 87, 14),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const PortfolioScreen(),
            ));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Leaderboard 🏆',
            textAlign: TextAlign.center,
          ),
        ),
        drawer: AppBarDrawer(),
        body: FutureBuilder(
          future: setDocsIDSOrder(),
          builder: (context, index) {
            return ListView.builder(
              itemCount: finaldocIDS.length,
              itemBuilder: ((context, index) {
                return index < 3
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: medals[index],
                          tileColor: user.uid != finaldocIDS[index]
                              ? Colors.black87
                              : Colors.yellow.shade800,
                          title: GetUserName(documentID: finaldocIDS[index]),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Icon(Icons.person),
                          tileColor: user.uid != finaldocIDS[index]
                              ? Colors.black87
                              : Colors.yellow.shade800,
                          title: GetUserName(documentID: finaldocIDS[index]),
                        ),
                      );
              }),
            );
          },
        ),
      ),
    );
  }
}

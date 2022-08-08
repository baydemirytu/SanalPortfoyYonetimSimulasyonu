import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sanal_portfoy_yonetim_simulasyonu/read_data/get_user_name.dart';
import '../constants/widgets/app_bar_drawer.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  List<String> docIDS = [];

  Future getDocIDs() async {
    await FirebaseFirestore.instance
        .collection('users')
        .orderBy('Balance', descending: true)
        .where('OnTheLeaderBoard', isEqualTo: true)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (element) {
              docIDS.add(element.reference.id);
            },
          ),
        );
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Leaderboard 🏆',
          textAlign: TextAlign.center,
        ),
      ),
      drawer: AppBarDrawer(),
      body: FutureBuilder(
        future: getDocIDs(),
        builder: (context, index) {
          return ListView.builder(
            itemCount: docIDS.length,
            itemBuilder: ((context, index) {
              return index < 3
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: medals[index],
                        tileColor: Colors.black87,
                        title: GetUserName(documentID: docIDS[index]),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Icon(Icons.person),
                        tileColor: Colors.black87,
                        title: GetUserName(documentID: docIDS[index]),
                      ),
                    );
            }),
          );
        },
      ),
    );
  }
}

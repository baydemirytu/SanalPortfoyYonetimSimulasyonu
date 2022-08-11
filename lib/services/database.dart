import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(
      String firstName,
      String lastName,
      String userEmail,
      double userBalance,
      bool wantedToBeInLeaderBoard) async {
    return await userCollection.doc(uid).set(
      {
        'First name': firstName,
        'Last name': lastName,
        'Email': userEmail,
        'Initial Balance': userBalance,
        'Current Balance': userBalance,
        'On The Leader Board': wantedToBeInLeaderBoard,
        'Yatırım': {
          'Döviz': {
            'USD': 0.0,
            'EUR': 0.0,
            'GBP': 0.0,
            'AED': 0.0,
            'AUD': 0.0,
            'CAD': 0.0,
            'CHF': 0.0,
            'DKK': 0.0,
            'JPY': 0.0,
            'KWD': 0.0,
            'NOK': 0.0,
            'SAR': 0.0,
            'SEK': 0.0,
          },
          'Vadeli Mevduat': {
            'TRY': {'Aktif': false},
            'USD': {'Aktif': false},
            'EUR': {'Aktif': false}
          }
        },
      },
    );
  }
}

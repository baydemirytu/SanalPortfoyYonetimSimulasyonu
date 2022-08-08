import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(
      String firstName,
      String lastName,
      String userEmail,
      double userBalance,
      bool wantedToBeInLeaderBoard) async {
    return await brewCollection.doc(uid).set({
      'First name': firstName,
      'Last name': lastName,
      'Email': userEmail,
      'Balance': userBalance,
      'OnTheLeaderBoard': wantedToBeInLeaderBoard,
    });
  }
}

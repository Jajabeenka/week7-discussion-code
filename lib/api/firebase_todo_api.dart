import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFriendAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addFriend(Map<String, dynamic> friend) async {
    try {
      final docRef = await db.collection("friends").add(friend);
      await db.collection("friends").doc(docRef.id).update({'id': docRef.id});

      return "Successfully added user data!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllFriends() {
    return db.collection("friends").snapshots();
  }

  Future<String> deleteFriend(String? id) async {
    try {
      await db.collection("friends").doc(id).delete();

      return "Successfully deleted user data!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}

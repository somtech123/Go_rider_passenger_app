import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_rider/app/resouces/app_logger.dart';

var log = getLogger('Firebase_method');

class FirebaseMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final CollectionReference<Map<String, dynamic>> _userCollection =
      _firestore.collection('users');

  Future<void> addUserLocation(
      {required Map<String, dynamic> payload, required String userType}) async {
    try {
      await _userCollection
          .doc(_auth.currentUser!.uid)
          .collection("location")
          .doc(userType)
          .set(payload, SetOptions(merge: true));
    } catch (e) {
      log.w(e);
    }
  }
}

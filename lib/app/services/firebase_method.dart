import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_rider/app/resouces/app_logger.dart';
import 'package:go_rider/ui/features/dashboard/data/rider_model.dart';

var log = getLogger('Firebase_method');

class FirebaseMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final CollectionReference<Map<String, dynamic>> _userCollection =
      _firestore.collection('user');

  static final CollectionReference<Map<String, dynamic>> _riderCollection =
      _firestore.collection('rider');

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

  Future<List<RiderModel>> getAllRider() async {
    List<RiderModel> userdata = [];

    try {
      var snap = await _riderCollection.get();

      userdata = snap.docs
          .map((DocumentSnapshot<Map<String, dynamic>> e) =>
              RiderModel.fromJson(e.data()!))
          .toList();
    } catch (e) {
      log.w(e);
      return [];
    }
    return userdata;
  }
}

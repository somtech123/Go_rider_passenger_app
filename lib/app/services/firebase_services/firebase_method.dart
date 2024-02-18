import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:go_rider/app/resouces/app_logger.dart';
import 'package:go_rider/ui/features/dashboard/data/location_model.dart';
import 'package:go_rider/ui/features/dashboard/data/rider_model.dart';
import 'package:go_rider/ui/features/history/data/history_model.dart';

var log = getLogger('Firebase_method');

class FirebaseMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  static final CollectionReference<Map<String, dynamic>> _userCollection =
      _firestore.collection('users');

  static final CollectionReference<Map<String, dynamic>> _riderCollection =
      _firestore.collection('rider');

  Future<void> bookRide(
      {required Map<String, dynamic> payload, required String uid}) async {
    try {
      await _userCollection
          .doc(_auth.currentUser!.uid)
          .collection('ride')
          .doc(uid)
          .set(payload, SetOptions(merge: false));
    } catch (e) {
      log.e(e);
    }
  }

  Future<void> cancelRide({
    required String uid,
    required Map<String, dynamic> payload,
  }) async {
    try {
      _userCollection
          .doc(_auth.currentUser!.uid)
          .collection('ride')
          .doc(uid)
          .update(payload);
    } catch (e) {
      log.e(e);
    }
  }

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

  Future<LocationModel> getLocation(String riderId) async {
    LocationModel locationModel = LocationModel();
    try {
      var snap = await _riderCollection
          .doc(riderId)
          .collection('location')
          .doc('rider')
          .get();

      locationModel = LocationModel.fromJson(snap.data()!);
    } catch (e) {
      log.w(e);
    }

    return locationModel;
  }

  Future<List<HistoryModel>> getRideHistory() async {
    List<HistoryModel> data = [];
    try {
      var snap = await _userCollection
          .doc(_auth.currentUser!.uid)
          .collection('ride')
          .get();

      data = snap.docs
          .map((DocumentSnapshot<Map<String, dynamic>> e) =>
              HistoryModel.fromJson(e.data()!))
          .toList();
    } catch (e) {
      log.w(e);
      return [];
    }
    return data;
  }

  Future<void> getFirebaaseuser(
      {required String collection, required String uid}) async {
    try {
      await _firestore.collection(collection).doc(uid).get();
    } catch (e) {
      log.e(e);
    }
  }

  Future<String> updateProfilePhoto(File file) async {
    String imageUrl = '';
    try {
      Reference ref = _storage
          .ref()
          .child('profilePhoto/${_auth.currentUser!.uid}')
          .child(_auth.currentUser!.uid);

      UploadTask uploadTask = ref.putFile(file);

      TaskSnapshot snap = await uploadTask;

      imageUrl = await snap.ref.getDownloadURL();
    } catch (e) {}
    return imageUrl;
  }

  Future<void> updateProfile({
    required Map<String, dynamic> payload,
  }) async {
    try {
      _userCollection.doc(_auth.currentUser!.uid).update(payload);
    } catch (e) {
      log.e(e);
    }
  }
}

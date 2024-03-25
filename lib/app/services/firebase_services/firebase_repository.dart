import 'dart:io';

import 'package:go_rider/app/services/firebase_services/firebase_method.dart';
import 'package:go_rider/ui/features/dashboard/data/location_model.dart';
import 'package:go_rider/ui/features/dashboard/data/rider_model.dart';
import 'package:go_rider/ui/features/history/data/history_model.dart';

class FirebaseRepository {
  final FirebaseMethod _firebaseMethod = FirebaseMethod();

  //adds a stream of user location to firebase

  Future<void> addUserLocation(
          {required Map<String, dynamic> payload,
          required String userType}) async =>
      _firebaseMethod.addUserLocation(payload: payload, userType: userType);

  Future<List<RiderModel>> getRider() async => _firebaseMethod.getAllRider();

  Future<LocationModel> getLocation(String riderId) async =>
      _firebaseMethod.getLocation(riderId);

  Future<void> bookRide(
          {required Map<String, dynamic> payload,
          required String uid,
          required String rider,
          required String fcm}) async =>
      _firebaseMethod.bookRide(
          payload: payload, uid: uid, fcm: fcm, rider: rider);

  Future<void> cancelRide(
          {required String uid,
          required Map<String, dynamic> payload,
          required String rider,
          required String fcm}) async =>
      _firebaseMethod.cancelRide(
          uid: uid, payload: payload, fcm: fcm, rider: rider);

  Future<List<HistoryModel>> getRideHistory() async =>
      _firebaseMethod.getRideHistory();

  Future<void> getFirebaseUser(
          {required String collection, required String uid}) async =>
      _firebaseMethod.getFirebaseUser(collection: collection, uid: uid);

  Future<String> updateProfilePhoto(File file) async =>
      _firebaseMethod.updateProfilePhoto(file);

  Future<void> updateProfile({required Map<String, dynamic> payload}) async =>
      _firebaseMethod.updateProfile(payload: payload);

  Future<void> storeFcmToken({required Map<String, dynamic> payload}) async =>
      _firebaseMethod.storeFcmToken(payload: payload);

  Future<void> rateRider(
          {required Map<String, dynamic> payload,
          required String riderId}) async =>
      _firebaseMethod.rateRider(riderId: riderId, payload: payload);

  Future<double> getRating(String id) async => _firebaseMethod.getRating(id);

  Future<void> createFireStoreUser(
          {required String uid,
          required String username,
          required String email,
          required String phone}) async =>
      _firebaseMethod.createFireStoreUser(
          uid: uid, username: username, email: email, phone: phone);
}

import 'package:go_rider/app/services/firebase_method.dart';
import 'package:go_rider/ui/features/dashboard/data/location_model.dart';
import 'package:go_rider/ui/features/dashboard/data/rider_model.dart';

class FirebaseRepository {
  final FirebaseMethod _firebaseMethod = FirebaseMethod();

  //adds a stream of user location to firebase

  Future<void> addUserLocation(
          {required Map<String, dynamic> payload, required String userType}) =>
      _firebaseMethod.addUserLocation(payload: payload, userType: userType);

  Future<List<RiderModel>> getRider() => _firebaseMethod.getAllRider();

  Future<LocationModel> getLocation(String riderId) =>
      _firebaseMethod.getLocation(riderId);

  Future<void> bookRide(
          {required Map<String, dynamic> payload, required String uid}) =>
      _firebaseMethod.bookRide(payload: payload, uid: uid);

  Future<void> cancelRide({
    required String uid,
    required Map<String, dynamic> payload,
  }) =>
      _firebaseMethod.cancelRide(uid: uid, payload: payload);
}

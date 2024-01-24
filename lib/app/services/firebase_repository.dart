import 'package:go_rider/app/services/firebase_method.dart';

class FirebaseRepository {
  final FirebaseMethod _firebaseMethod = FirebaseMethod();

  //adds a stream of user location to firebase

  Future<void> addUserLocation(
          {required Map<String, dynamic> payload, required String userType}) =>
      _firebaseMethod.addUserLocation(payload: payload, userType: userType);
}

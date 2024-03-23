import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_rider/app/services/auth_services/auth_method.dart';

class AuthRepository {
  final AuthMethods _authMethods = AuthMethods();

  Future<UserCredential?> getGooglecredential() async =>
      _authMethods.getGooglecredential();
}

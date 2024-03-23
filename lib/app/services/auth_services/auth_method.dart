import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_rider/app/resouces/app_logger.dart';
import 'package:google_sign_in/google_sign_in.dart';

var log = getLogger('Auth_Method');

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> getGooglecredential() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // obtain auth detail from request

    if (gUser != null) {
      final GoogleSignInAuthentication gauth = await gUser.authentication;

      final AuthCredential cred = GoogleAuthProvider.credential(
          accessToken: gauth.accessToken, idToken: gauth.idToken);
      return await _auth.signInWithCredential(cred);
    }

    return null;
  }
}

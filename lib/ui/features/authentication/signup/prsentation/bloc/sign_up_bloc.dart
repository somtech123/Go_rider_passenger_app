// ignore_for_file: invalid_use_of_visible_for_testing_member, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_rider/app/resouces/app_logger.dart';
import 'package:go_rider/app/services/auth_services/auth_repo.dart';
import 'package:go_rider/app/services/firebase_services/firebase_repository.dart';
import 'package:go_rider/ui/features/authentication/signup/prsentation/bloc/sign_up_event.dart';
import 'package:go_rider/ui/features/authentication/signup/prsentation/bloc/sign_up_state.dart';
import 'package:go_rider/ui/shared/dialog/error_diaglog.dart';
import 'package:go_rider/ui/shared/dialog/loading_widget.dart';
import 'package:go_router/go_router.dart';

var log = getLogger('Signup_bloc');

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState(isVisible: true)) {
    on<SignUp>((event, emit) async {
      await signup(event.context,
          email: event.email,
          password: event.password,
          username: event.username,
          phone: event.phone);
    });

    on<ObsureText>((event, emit) => obsureText());

    on<GoogleSignin>((event, emit) async => googleSigin(event.context));
  }

  obsureText() {
    emit(state.copyWith(isVisible: !state.isVisible!));
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final AuthRepository _authRepository = AuthRepository();

  final FirebaseRepository _firebaseRepository = FirebaseRepository();

  Future<void> signup(BuildContext context,
      {required String email,
      required String password,
      required String username,
      required String phone}) async {
    showloader(context);

    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _firebaseRepository.createFireStoreUser(
          uid: cred.user!.uid, username: username, email: email, phone: phone);

      await _auth.currentUser!.updateDisplayName(username);

      context.pop();

      context.replace('/homePage');
    } on FirebaseAuthException catch (e) {
      context.pop();
      if (e.code == 'weak-password') {
        showErrorDialog(context, message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showErrorDialog(context,
            message: 'The account already exists for that email.');
      } else {
        showErrorDialog(context, message: e.code);
      }
    } catch (e) {
      context.pop();

      showErrorDialog(context, message: e.toString());
    }
  }

  googleSigin(BuildContext context) async {
    try {
      UserCredential? cred = await _authRepository.getGooglecredential();
      if (cred != null) {
        if (cred.additionalUserInfo!.isNewUser) {
          await _firebaseRepository.createFireStoreUser(
              uid: _auth.currentUser!.uid,
              username: cred.user!.displayName!,
              email: cred.user!.email!,
              phone: cred.user!.phoneNumber!);

          context.replace('/homePage');
        }
      } else {
        showErrorDialog(context, message: 'an error occured try again later');
      }
    } on FirebaseAuthException catch (e) {
      showErrorDialog(context, message: e.message!);
    } catch (e) {
      showErrorDialog(context, message: e.toString());
    }
  }
}

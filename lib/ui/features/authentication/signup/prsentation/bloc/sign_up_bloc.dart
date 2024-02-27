// ignore_for_file: invalid_use_of_visible_for_testing_member, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_rider/app/helper/local_state_helper.dart';
import 'package:go_rider/app/resouces/app_logger.dart';
import 'package:go_rider/ui/features/authentication/signup/prsentation/bloc/sign_up_event.dart';
import 'package:go_rider/ui/features/authentication/signup/prsentation/bloc/sign_up_state.dart';
import 'package:go_rider/ui/shared/shared_widget/custom_snackbar.dart';
import 'package:go_router/go_router.dart';

var log = getLogger('Signup_bloc');

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc()
      : super(SignUpState(
            signUpMessage: '',
            loadingState: LoadingState.initial,
            isVisible: true)) {
    on<SignUp>((event, emit) async {
      await signup(event.context,
          email: event.email,
          password: event.password,
          username: event.username);
    });

    on<ObsureText>((event, emit) => obsureText());
  }

  obsureText() {
    emit(state.copyWith(isVisible: !state.isVisible!));
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signup(
    BuildContext context, {
    required String email,
    required String password,
    required String username,
  }) async {
    EasyLoading.show(status: 'loading...');

    emit(state.copyWith(loadingState: LoadingState.loading, signUpMessage: ''));
    log.wtf("Checking data . . .");

    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      log.wtf(
          "Successfully created auth ${cred.user!.uid}  started creation of firestore acct. . .");

      await _createFireStoreUser(
          uid: cred.user!.uid, username: username, email: email);

      emit(state.copyWith(
          loadingState: LoadingState.loaded, signUpMessage: 'success'));

      EasyLoading.showSuccess('Successfully Signup');

      context.replace('/homePage');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        EasyLoading.dismiss();
        emit(state.copyWith(
            loadingState: LoadingState.error,
            signUpMessage: 'an error occured try again later'));
        showCustomSnackBar(message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        EasyLoading.dismiss();
        emit(state.copyWith(
            loadingState: LoadingState.error,
            signUpMessage: 'an error occured try again later'));
        showCustomSnackBar(
            message: 'The account already exists for that email.');
      } else {
        EasyLoading.dismiss();
        emit(state.copyWith(
            loadingState: LoadingState.error,
            signUpMessage: 'an error occured try again later'));
        showCustomSnackBar(message: e.code);
      }
    } catch (e) {
      EasyLoading.dismiss();
      emit(state.copyWith(
          loadingState: LoadingState.error,
          signUpMessage: 'an error occured try again later'));
      showCustomSnackBar(message: e.toString());
    }
  }

  Future<void> _createFireStoreUser(
      {required String uid,
      required String username,
      required String email}) async {
    await _firestore.collection("users").doc(uid).set({
      "userName": username,
      'id': uid,
      'email': email,
      "dateCreated": DateTime.now().toIso8601String(),
      'profileImage': '',
    });
  }
}

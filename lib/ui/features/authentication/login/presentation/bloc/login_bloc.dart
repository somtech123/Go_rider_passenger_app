// ignore_for_file: invalid_use_of_visible_for_testing_member, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_rider/app/helper/local_state_helper.dart';
import 'package:go_rider/app/resouces/app_logger.dart';
import 'package:go_rider/app/services/auth_services/auth_repo.dart';
import 'package:go_rider/app/services/firebase_services/firebase_repository.dart';
import 'package:go_rider/ui/features/authentication/login/presentation/bloc/login_event.dart';
import 'package:go_rider/ui/features/authentication/login/presentation/bloc/login_state.dart';
import 'package:go_rider/ui/shared/dialog/error_diaglog.dart';
import 'package:go_rider/ui/shared/dialog/loading_widget.dart';
import 'package:go_rider/ui/shared/dialog/success_diaglog.dart';
import 'package:go_router/go_router.dart';

var log = getLogger('Login_bloc');

class LoginBloc extends Bloc<LoginEvenet, LoginState> {
  LoginBloc() : super(LoginState(isVisible: true)) {
    on<Login>((event, emit) async {
      await login(event.context, email: event.email, password: event.password);
    });

    on<ObsureText>((event, emit) => obsureText());

    on<ResetPassword>((event, emit) async {
      await forgottenPassword(event.context, email: event.email);
    });

    on<GoogleSignin>((event, emit) async => googleSigin(event.context));
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final AuthRepository _authRepository = AuthRepository();

  final FirebaseRepository _firebaseRepository = FirebaseRepository();

  obsureText() {
    emit(state.copyWith(isVisible: !state.isVisible!));
  }

  login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    showloader(context);

    emit(state.copyWith(loadingState: LoadingState.loading));

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      context.pop();

      context.replace('/homePage');
    } on FirebaseAuthException catch (e) {
      context.pop();

      showErrorDialog(context, message: e.message!);
    } catch (e) {
      context.pop();

      showErrorDialog(context, message: e.toString());
    }
  }

  forgottenPassword(BuildContext context, {required String email}) async {
    showloader(context);
    try {
      await _auth.sendPasswordResetEmail(email: email);

      context.pop();

      showSuccessDialog(context,
          message: 'A reset link have been sent to your email');
    } on FirebaseAuthException catch (e) {
      context.pop();

      if (e.code == 'user-not-found') {
        showErrorDialog(context,
            message: 'User not found. Please check your email.');
      } else if (e.code == 'invalid-email') {
        showErrorDialog(context, message: 'Invalid email address.');
      } else {
        showErrorDialog(context, message: 'An error occurred: ${e.message}');
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

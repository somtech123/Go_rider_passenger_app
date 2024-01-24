// ignore_for_file: invalid_use_of_visible_for_testing_member, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_rider/app/helper/local_state_helper.dart';
import 'package:go_rider/app/resouces/app_logger.dart';
import 'package:go_rider/ui/features/authentication/login/presentation/bloc/login_event.dart';
import 'package:go_rider/ui/features/authentication/login/presentation/bloc/login_state.dart';
import 'package:go_rider/ui/shared/shared_widget/custom_snackbar.dart';
import 'package:go_router/go_router.dart';

var log = getLogger('Login_bloc');

class LoginBloc extends Bloc<LoginEvenet, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<Login>((event, emit) async {
      await login(event.context, email: event.email, password: event.password);
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    log.w('staring the registration process');

    EasyLoading.show(status: 'loading...');

    emit(state.copyWith(loadingState: LoadingState.loading));

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      EasyLoading.showSuccess('Successfully Login');

      context.replace('/homePage');
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      showCustomSnackBar(message: e.message!);
    } catch (e) {
      EasyLoading.dismiss();

      showCustomSnackBar(message: e.toString());
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_rider/app/helper/local_state_helper.dart';
import 'package:go_rider/ui/features/authentication/login/presentation/bloc/login_event.dart';
import 'package:go_rider/ui/features/authentication/login/presentation/bloc/login_state.dart';

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
    EasyLoading.show(status: 'loading...');

    // ignore: invalid_use_of_visible_for_testing_member
    emit(state.copyWith(loadingState: LoadingState.loading));
  }
}

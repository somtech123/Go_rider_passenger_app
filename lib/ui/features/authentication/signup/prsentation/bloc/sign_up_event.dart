// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SignUpEvent extends Equatable {}

class SignUp extends SignUpEvent {
  final String email;
  final String password;
  final String username, phone;
  BuildContext context;
  SignUp(
      {required this.email,
      required this.password,
      required this.username,
      required this.phone,
      required this.context});
  @override
  List<Object?> get props => [email, password, username, context, phone];
}

class ObsureText extends SignUpEvent {
  @override
  List<Object?> get props => [];
}

class GoogleSignin extends SignUpEvent {
  BuildContext context;

  GoogleSignin(this.context);
  @override
  List<Object?> get props => [context];
}

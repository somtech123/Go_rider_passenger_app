// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvenet extends Equatable {}

class Login extends LoginEvenet {
  final String email;
  final String password;
  BuildContext context;

  Login({required this.email, required this.password, required this.context});

  @override
  List<Object?> get props => [email, password, context];
}

class ObsureText extends LoginEvenet {
  @override
  List<Object?> get props => [];
}

class ResetPassword extends LoginEvenet {
  final String email;
  BuildContext context;
  ResetPassword({required this.email, required this.context});

  @override
  List<Object?> get props => [email, context];
}

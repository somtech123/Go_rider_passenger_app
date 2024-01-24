import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvenet extends Equatable {}

// ignore: must_be_immutable
class Login extends LoginEvenet {
  final String email;
  final String password;
  BuildContext context;

  Login({required this.email, required this.password, required this.context});

  @override
  List<Object?> get props => [email, password, context];
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SignUpEvent extends Equatable {}

// ignore: must_be_immutable
class SignUp extends SignUpEvent {
  final String email;
  final String password;
  final String username;
  BuildContext context;
  SignUp(
      {required this.email,
      required this.password,
      required this.username,
      required this.context});
  @override
  List<Object?> get props => [email, password, username, context];
}

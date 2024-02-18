// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class AccountBlocEvent extends Equatable {}

class SelectProfileImage extends AccountBlocEvent {
  @override
  List<Object?> get props => [];
}

class GetAccountDetail extends AccountBlocEvent {
  @override
  List<Object?> get props => [];
}

class UpdateProfile extends AccountBlocEvent {
  String username;
  UpdateProfile({required this.username});

  @override
  List<Object?> get props => [username];
}

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class HomePageBlocEvent extends Equatable {}

class RequestLocation extends HomePageBlocEvent {
  @override
  List<Object?> get props => [];
}

class GetUserDetails extends HomePageBlocEvent {
  @override
  List<Object?> get props => [];
}

class SelectPickUpLocation extends HomePageBlocEvent {
  final BuildContext context;

  SelectPickUpLocation({required this.context});

  @override
  List<Object?> get props => [context];
}

class MoveCameraPosition extends HomePageBlocEvent {
  @override
  List<Object?> get props => [];
}

class ResetCameraPosition extends HomePageBlocEvent {
  @override
  List<Object?> get props => [];
}

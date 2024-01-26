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

// ignore: must_be_immutable
class UpdateRideIndex extends HomePageBlocEvent {
  final BuildContext context;
  int activeIndex;

  UpdateRideIndex({required this.activeIndex, required this.context});

  @override
  List<Object?> get props => [context, activeIndex];
}

class SelectPickUpLocation extends HomePageBlocEvent {
  final BuildContext context;

  SelectPickUpLocation({required this.context});

  @override
  List<Object?> get props => [context];
}

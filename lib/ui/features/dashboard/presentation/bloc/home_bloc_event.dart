// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_rider/ui/features/dashboard/data/rider_model.dart';

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

class GetRiderLocation extends HomePageBlocEvent {
  String riderId;
  GetRiderLocation({required this.riderId});

  @override
  List<Object?> get props => [riderId];
}

class BookRider extends HomePageBlocEvent {
  RiderModel rider;
  BookRider({required this.rider});

  @override
  List<Object?> get props => [rider];
}

class ViewActiveRide extends HomePageBlocEvent {
  BuildContext context;
  ViewActiveRide({required this.context});
  @override
  List<Object?> get props => [context];
}

class CancelRide extends HomePageBlocEvent {
  BuildContext context;
  CancelRide({required this.context});
  @override
  List<Object?> get props => [context];
}

class StoreFcmToken extends HomePageBlocEvent {
  @override
  List<Object?> get props => [];
}

class Logout extends HomePageBlocEvent {
  BuildContext context;
  Logout(this.context);

  @override
  List<Object?> get props => [context];
}

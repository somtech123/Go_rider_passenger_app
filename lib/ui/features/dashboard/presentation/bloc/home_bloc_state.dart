// ignore_for_file: override_on_non_overriding_member

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_rider/app/helper/booking_state_helper.dart';
import 'package:go_rider/app/helper/local_state_helper.dart';
import 'package:go_rider/ui/features/dashboard/data/location_model.dart';
import 'package:go_rider/ui/features/dashboard/data/rider_model.dart';
import 'package:go_rider/ui/features/dashboard/data/user_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePageState {
  LoadingState? loadingState;
  LatLng? currentLocation;

  LoadingState? riderLoadingState;

  LoadingState? arrivingTimeState;

  BookingState? bookingRideState;

  int? arivalDuration;

  LatLng? destinationLocation;

  Completer<GoogleMapController> mapController;

  UserModel? userModel;

  Set<Marker> markers;

  Map<PolylineId, Polyline> polyline;

  List<LatLng> plineCoordinate;

  TextEditingController pickUpAddress;

  TextEditingController destinationAddress;

  bool onCameraMove;

  LocationModel? riderLocation;

  List<RiderModel>? rider;

  RiderModel? currentRider;

  String? uid;

  double? riderRating;

  HomePageState({
    this.loadingState = LoadingState.initial,
    this.riderLoadingState = LoadingState.initial,
    this.bookingRideState = BookingState.initial,
    this.currentLocation,
    this.destinationLocation,
    this.userModel,
    this.riderLocation,
    required this.mapController,
    required this.markers,
    required this.plineCoordinate,
    required this.destinationAddress,
    required this.pickUpAddress,
    required this.polyline,
    required this.onCameraMove,
    this.arivalDuration,
    this.arrivingTimeState = LoadingState.initial,
    this.rider,
    this.uid,
    this.currentRider,
    this.riderRating,
  });

  HomePageState copyWith(
          {LoadingState? loadingState,
          LatLng? currentLocation,
          Completer<GoogleMapController>? mapController,
          UserModel? userModel,
          Set<Marker>? markers,
          List<LatLng>? plineCoordinate,
          TextEditingController? pickUpAddress,
          TextEditingController? destinationAddress,
          LatLng? destinationLocation,
          Map<PolylineId, Polyline>? polyline,
          List<RiderModel>? rider,
          LocationModel? riderLocation,
          LoadingState? riderLoadingState,
          bool? onCameraMove,
          LoadingState? arrivingTimeState,
          int? arivalDuration,
          BookingState? bookingRideState,
          String? uid,
          RiderModel? currentRider,
          double? riderRating}) =>
      HomePageState(
          loadingState: loadingState ?? this.loadingState,
          riderLoadingState: riderLoadingState ?? this.riderLoadingState,
          destinationLocation: destinationLocation ?? this.destinationLocation,
          currentLocation: currentLocation ?? this.currentLocation,
          mapController: mapController ?? this.mapController,
          userModel: userModel ?? this.userModel,
          markers: markers ?? this.markers,
          plineCoordinate: plineCoordinate ?? this.plineCoordinate,
          pickUpAddress: pickUpAddress ?? this.pickUpAddress,
          destinationAddress: destinationAddress ?? this.destinationAddress,
          polyline: polyline ?? this.polyline,
          rider: rider ?? this.rider,
          onCameraMove: onCameraMove ?? this.onCameraMove,
          riderLocation: riderLocation ?? this.riderLocation,
          arivalDuration: arivalDuration ?? this.arivalDuration,
          arrivingTimeState: arrivingTimeState ?? this.arrivingTimeState,
          bookingRideState: bookingRideState ?? this.bookingRideState,
          uid: uid ?? this.uid,
          riderRating: riderRating ?? this.riderRating,
          currentRider: currentRider ?? this.currentRider);

  @override
  List<Object?> get props => [
        loadingState,
        riderLocation,
        currentLocation,
        mapController,
        userModel,
        markers,
        uid,
        destinationLocation,
        plineCoordinate,
        destinationAddress,
        pickUpAddress,
        polyline,
        onCameraMove,
        rider,
        riderLoadingState,
        arivalDuration,
        arrivingTimeState,
        bookingRideState,
        currentRider,
        riderRating
      ];
}

// ignore_for_file: override_on_non_overriding_member

import 'dart:async';

import 'package:go_rider/app/helper/local_state_helper.dart';
import 'package:go_rider/ui/features/dashboard/data/user_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePageState {
  LoadingState? loadingState;
  LatLng? currentLocation;
  Completer<GoogleMapController> mapController;
  int activeIndex;
  UserModel? userModel;
  Set<Marker> markers;
  Set<Circle> circles;
  List<LatLng> plineCoordinate;

  Set<Polyline> polyLine;

  //Position userposition;

  BitmapDescriptor? activeNearByIcon;

  HomePageState(
      {this.loadingState = LoadingState.initial,
      this.currentLocation,
      required this.mapController,
      this.activeIndex = 0,
      this.userModel,
      required this.circles,
      required this.markers,
      required this.plineCoordinate,
      required this.polyLine,
      this.activeNearByIcon});

  HomePageState copyWith(
          {LoadingState? loadingState,
          LatLng? currentLocation,
          Completer<GoogleMapController>? mapController,
          int? activeIndex,
          UserModel? userModel,
          Set<Marker>? markers,
          Set<Circle>? circles,
          List<LatLng>? plineCoordinate,
          Set<Polyline>? polyLine,
          BitmapDescriptor? activeNearByIcon}) =>
      HomePageState(
          loadingState: loadingState ?? this.loadingState,
          currentLocation: currentLocation ?? this.currentLocation,
          mapController: mapController ?? this.mapController,
          activeIndex: activeIndex ?? this.activeIndex,
          userModel: userModel ?? this.userModel,
          markers: markers ?? this.markers,
          circles: circles ?? this.circles,
          plineCoordinate: plineCoordinate ?? this.plineCoordinate,
          polyLine: polyLine ?? this.polyLine,
          activeNearByIcon: activeNearByIcon ?? this.activeNearByIcon);

  @override
  List<Object?> get props => [
        loadingState,
        currentLocation,
        activeNearByIcon,
        mapController,
        activeIndex,
        userModel,
        circles,
        markers,
        plineCoordinate,
        polyLine
      ];
}

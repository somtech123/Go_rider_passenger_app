// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_rider/app/resouces/app_logger.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_event.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

var log = getLogger('Home_bloc');

class HomePageBloc extends Bloc<HomePageBlocEvent, HomePageState> {
  final Location _locationctr = Location();

  HomePageBloc()
      : super(HomePageState(mapController: Completer<GoogleMapController>())) {
    on<RequestLocation>((event, emit) async {
      await getLocationUpdate();
    });
  }

  @override
  Future<void> close() {
    state.mapController = Completer();
    return super.close();
  }

  _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await state.mapController.future;
    CameraPosition _position = CameraPosition(target: pos, zoom: 14);
    await controller.animateCamera(CameraUpdate.newCameraPosition(_position));
  }

  getLocationUpdate() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationctr.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationctr.requestService();
    } else {
      return;
    }
    _permissionGranted = await _locationctr.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationctr.requestPermission();

      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationctr.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        emit(state.copyWith(
          currentLocation:
              LatLng(currentLocation.latitude!, currentLocation.longitude!),
        ));
        _cameraToPosition(
            LatLng(currentLocation.latitude!, currentLocation.longitude!));
        log.w('${currentLocation.latitude}  ${currentLocation.longitude}');
      }
    });
  }
}

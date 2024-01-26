// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_rider/app/helper/local_state_helper.dart';
import 'package:go_rider/app/resouces/app_logger.dart';
import 'package:go_rider/app/services/firebase_repository.dart';
import 'package:go_rider/ui/features/dashboard/data/user_model.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_event.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

var log = getLogger('Home_bloc');

class HomePageBloc extends Bloc<HomePageBlocEvent, HomePageState> {
  final Location _locationctr = Location();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseRepository _firebaseRepository = FirebaseRepository();

  HomePageBloc()
      : super(HomePageState(
            mapController: Completer<GoogleMapController>(),
            activeIndex: 0,
            loadingState: LoadingState.loaded,
            markers: {},
            circles: {},
            plineCoordinate: [],
            polyLine: {})) {
    on<RequestLocation>((event, emit) async {
      await getLocationUpdate();
    });

    on<UpdateRideIndex>((event, emit) {
      updateRideIndex(event.activeIndex);
    });

    on<GetUserDetails>((event, emit) async {
      //  await getUserDetail();
    });
  }

  @override
  Future<void> close() {
    state.mapController = Completer();
    return super.close();
  }

  _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await state.mapController.future;
    CameraPosition position = CameraPosition(target: pos, zoom: 14);

    await controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    } else {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          return false;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return false;
      }

      return true;
    }
  }

  updateRideIndex(int index) {
    emit(state.copyWith(activeIndex: index));
  }

  getUserDetail() async {
    try {
      User currentUser = _auth.currentUser!;
      DocumentSnapshot<Map<String, dynamic>> snap =
          await _firestore.collection("users").doc(currentUser.uid).get();

      UserModel userModel = UserModel.fromJson(snap.data()!);

      log.w(userModel);

      emit(state.copyWith(
          loadingState: LoadingState.loaded, userModel: userModel));
    } catch (e) {
      log.d(e);

      emit(state.copyWith(
          loadingState: LoadingState.error, userModel: UserModel()));
    }
  }

  getLocationUpdate() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationctr.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await _locationctr.requestService();
    } else {
      return;
    }
    permissionGranted = await _locationctr.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationctr.requestPermission();

      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationctr.onLocationChanged.listen((LocationData currentLocation) async {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        emit(state.copyWith(
            currentLocation:
                LatLng(currentLocation.latitude!, currentLocation.longitude!)));

        await _firebaseRepository.addUserLocation(userType: 'user', payload: {
          'latitude': currentLocation.latitude,
          'longitude': currentLocation.longitude
        });

        _cameraToPosition(
            LatLng(currentLocation.latitude!, currentLocation.longitude!));

        _updateMarker(
            LatLng(currentLocation.latitude!, currentLocation.longitude!));

        log.w('${currentLocation.latitude}  ${currentLocation.longitude}');
      } else {
        emit(state.copyWith(
          currentLocation: null,
        ));
      }
    });
  }

  _updateMarker(LatLng position) {
    Marker currentLocationMarker = Marker(
        markerId: const MarkerId('current_location'),
        position: LatLng(position.latitude, position.longitude));
    Set<Marker> markers = state.markers;
    markers.add(currentLocationMarker);

    emit(state.copyWith(markers: markers));
  }
}

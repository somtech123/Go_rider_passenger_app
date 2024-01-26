// ignore_for_file: invalid_use_of_visible_for_testing_member, use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:location/location.dart';
import 'package:go_rider/app/helper/local_state_helper.dart';
import 'package:go_rider/app/resouces/app_logger.dart';
import 'package:go_rider/app/services/firebase_repository.dart';
import 'package:go_rider/ui/features/dashboard/data/user_model.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_event.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as mapServices;

var log = getLogger('Home_bloc');

class HomePageBloc extends Bloc<HomePageBlocEvent, HomePageState> {
  final Location _locationctr = Location();

  final places =
      mapServices.GoogleMapsPlaces(apiKey: dotenv.env['GOOGLE_MAP_API_KEY']);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseRepository _firebaseRepository = FirebaseRepository();

  HomePageBloc()
      : super(HomePageState(
          mapController: Completer<GoogleMapController>(),
          activeIndex: 0,
          loadingState: LoadingState.initial,
          markers: {},
          circles: {},
          plineCoordinate: [],
          polyline: {},
          pickUpAddress: TextEditingController(),
          destinationAddress: TextEditingController(),
        )) {
    on<RequestLocation>((event, emit) async {
      await getLocationUpdate();
    });

    on<UpdateRideIndex>((event, emit) {
      updateRideIndex(event.activeIndex);
    });

    on<GetUserDetails>((event, emit) async {
      await getUserDetail();
    });

    on<SelectPickUpLocation>((event, emit) async {
      selectPickUpLocation(event.context);
    });
  }

  @override
  Future<void> close() {
    state.mapController = Completer();
    return super.close();
  }

  Future<void> selectPickUpLocation(BuildContext context) async {
    await autoComplete(context)
        .then((_) => getPolyPoint(LatLng(state.destinationLocation!.latitude,
            state.destinationLocation!.longitude)))
        .then((value) => generatePolyLine(value));
  }

  Future<void> autoComplete(BuildContext context) async {
    mapServices.Prediction? prediction = await PlacesAutocomplete.show(
        context: context,
        apiKey: dotenv.env['GOOGLE_MAP_API_KEY'],
        mode: Mode.overlay,
        strictbounds: false,
        types: [],
        language: "en",
        components: [
          mapServices.Component(mapServices.Component.country, "NG")
        ]);

    if (prediction != null) {
      emit(state.copyWith(
          destinationAddress:
              TextEditingController(text: prediction.description!)));

      Navigator.of(context).pop();

      log.w(state.destinationAddress.text);

      mapServices.PlacesDetailsResponse detail =
          await places.getDetailsByPlaceId(prediction.placeId!);
      if (detail.status == 'OK') {
        double latitude = detail.result.geometry!.location.lat;
        double longitude = detail.result.geometry!.location.lng;

        Marker currentLocationMarker = Marker(
            markerId: const MarkerId('destination'),
            position: LatLng(latitude, longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue));

        Set<Marker> markers = state.markers;

        markers.add(currentLocationMarker);

        emit(state.copyWith(
            markers: markers,
            destinationLocation: LatLng(latitude, longitude)));
      }
    }
  }

  _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await state.mapController.future;
    CameraPosition position = CameraPosition(target: pos, zoom: 14);

    await controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  updateRideIndex(int index) {
    emit(state.copyWith(activeIndex: index));
  }

  getUserDetail() async {
    emit(state.copyWith(
        loadingState: LoadingState.loading, userModel: UserModel()));

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

        await _getAddressFromCordinate(
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

  _getAddressFromCordinate(LatLng position) async {
    if (position != null) {
      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
          position.latitude, position.longitude);

      String address =
          '${placemarks[0].street} ${placemarks[0].subAdministrativeArea}, ${placemarks[0].administrativeArea}';

      log.w(address);

      emit(state.copyWith(pickUpAddress: TextEditingController(text: address)));
    } else {
      emit(state.copyWith(pickUpAddress: TextEditingController(text: '')));
    }
  }

  // selectPickUpLocation(String pickUp) async {
  //   if (pickUp.isNotEmpty) {
  //     List<geo.Location> locations = await geo.locationFromAddress(pickUp);
  //     log.w(locations[0].toString());
  //   }
  // }

  Future<List<LatLng>> getPolyPoint(LatLng destination) async {
    emit(state.copyWith(plineCoordinate: []));

    List<LatLng> plineCoordinate = state.plineCoordinate;

    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      '${dotenv.env['GOOGLE_MAP_API_KEY']}',
      PointLatLng(
          state.currentLocation!.latitude, state.currentLocation!.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.driving,
    );
    log.w(result);
    if (result.points.isNotEmpty) {
      result.points.forEach((point) {
        plineCoordinate.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      log.w(result.errorMessage);
    }
    emit(state.copyWith(plineCoordinate: plineCoordinate));
    return plineCoordinate;
  }

  generatePolyLine(List<LatLng> plineCoordinate) async {
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
        polylineId: id,
        color: AppColor.primaryColor,
        points: plineCoordinate,
        width: 8);

    Map<PolylineId, Polyline> pol = state.polyline;
    pol.addAll({id: polyline});
    emit(state.copyWith(polyline: pol));
  }
}

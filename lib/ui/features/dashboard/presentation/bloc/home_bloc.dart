// ignore_for_file: invalid_use_of_visible_for_testing_member, use_build_context_synchronously, unnecessary_null_comparison, depend_on_referenced_packages, library_prefixes, prefer_collection_literals

import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart'
    as mapServices;
import 'package:geocoding/geocoding.dart' as geo;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_rider/app/helper/booking_state_helper.dart';
import 'package:go_rider/ui/features/dashboard/data/location_model.dart';
import 'package:go_rider/ui/features/dashboard/data/rider_model.dart';
import 'package:go_rider/ui/features/dashboard/presentation/view/widget/rating_screen.dart';
import 'package:go_rider/ui/shared/shared_widget/custom_snackbar.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:go_rider/utils/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:go_rider/app/helper/local_state_helper.dart';
import 'package:go_rider/app/resouces/app_logger.dart';
import 'package:go_rider/app/services/firebase_services/firebase_repository.dart';
import 'package:go_rider/ui/features/dashboard/data/user_model.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_event.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

var log = getLogger('Home_bloc');

class HomePageBloc extends Bloc<HomePageBlocEvent, HomePageState> {
  final Location _locationctr = Location();

  final places =
      mapServices.GoogleMapsPlaces(apiKey: dotenv.env['GOOGLE_MAP_API_KEY']);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseRepository _firebaseRepository = FirebaseRepository();

  StreamSubscription<LocationData>? locationStream;

  HomePageBloc()
      : super(HomePageState(
          mapController: Completer<GoogleMapController>(),
          loadingState: LoadingState.initial,
          markers: {},
          plineCoordinate: [],
          polyline: {},
          rider: [],
          pickUpAddress: TextEditingController(),
          destinationAddress: TextEditingController(),
          onCameraMove: false,
          currentRider: null,
          // bookingRideState: BookingState.initial,
        )) {
    on<RequestLocation>((event, emit) async {
      await getLocationUpdate();
    });

    on<GetUserDetails>((event, emit) async {
      await getUserDetail();
    });

    on<SelectDestinationLocation>((event, emit) async {
      selectDestinationLocation(event.context);
    });

    on<MoveCameraPosition>((event, emit) {
      onCameraMove();
    });

    on<ResetCameraPosition>((event, emit) {
      resetCameraPosition();
    });

    on<GetRiderLocation>((event, emit) async {
      await getRiderLocation(event.riderId);
    });

    on<BookRider>((event, emit) async {
      await bookRide(rider: event.rider);
    });

    on<CancelRide>((event, emit) async {
      cancelRide(event.context, riderModel: event.riderModel);
    });

    on<ViewActiveRide>((event, emit) => viewCurrentRide(event.context));

    on<StoreFcmToken>((event, emit) async {
      await storeFcmToken();
    });

    on<Logout>((event, emit) => reset(event.context));

    on<RateRider>((event, emit) async {
      await rateRide(event.context,
          rideFeedback: event.rideFeedback,
          id: event.riderId,
          rating: event.rating);
    });
  }

  @override
  Future<void> close() {
    state.mapController = Completer();

    state.destinationAddress.dispose();
    state.pickUpAddress.dispose();
    return super.close();
  }

  onCameraMove() {
    emit(state.copyWith(onCameraMove: true));
  }

  resetCameraPosition() {
    emit(state.copyWith(onCameraMove: false));

    _cameraToPosition(LatLng(
        state.currentLocation!.latitude, state.currentLocation!.longitude));
  }

  //Get user detail from firebase

  getUserDetail() async {
    emit(state.copyWith(
        loadingState: LoadingState.loading, userModel: UserModel()));

    try {
      DocumentSnapshot<Map<String, dynamic>> snap = await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .get();

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

  //Get live location of user

  getLocationUpdate() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await Geolocator.requestPermission();
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }

    locationStream = _locationctr.onLocationChanged
        .listen((LocationData currentLocation) async {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        emit(state.copyWith(
          currentLocation:
              LatLng(currentLocation.latitude!, currentLocation.longitude!),
        ));

        await _firebaseRepository.addUserLocation(userType: 'user', payload: {
          'latitude': currentLocation.latitude,
          'longitude': currentLocation.longitude
        });

        _updateMarker(
            LatLng(currentLocation.latitude!, currentLocation.longitude!));

        await _getAddressFromCordinate(
            LatLng(currentLocation.latitude!, currentLocation.longitude!));

        log.w('${currentLocation.latitude}  ${currentLocation.longitude}');
      } else {
        emit(state.copyWith(currentLocation: null));
      }
    });
  }

  _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await state.mapController.future;

    CameraPosition position = CameraPosition(target: pos, zoom: 14);

    await controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  _getAddressFromCordinate(LatLng position) async {
    if (position != null) {
      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
          position.latitude, position.longitude);

      String address =
          '${placemarks[0].street} ${placemarks[0].subAdministrativeArea}, ${placemarks[0].administrativeArea}';

      emit(state.copyWith(pickUpAddress: TextEditingController(text: address)));
    } else {
      emit(state.copyWith(pickUpAddress: TextEditingController(text: '')));
    }
  }

  _updateMarker(LatLng position) {
    Marker currentpositionMarker = Marker(
        markerId: const MarkerId('current_location'),
        position: LatLng(position.latitude, position.longitude));

    Set<Marker> markers = state.markers;

    markers.add(currentpositionMarker);

    emit(state.copyWith(markers: markers));
  }

  Future<List<LatLng>> _getPolyPointCordinate(LatLng destination) async {
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
      for (var point in result.points) {
        plineCoordinate.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      log.e(result.errorMessage);
    }
    emit(state.copyWith(plineCoordinate: plineCoordinate));

    return plineCoordinate;
  }

  _generatePolyLine(List<LatLng> plineCoordinate) async {
    PolylineId id = const PolylineId('direction_point');

    Polyline polyline = Polyline(
        polylineId: id,
        color: AppColor.primaryColor,
        points: plineCoordinate,
        width: 8);

    Map<PolylineId, Polyline> pol = state.polyline;

    pol.addAll({id: polyline});

    emit(state.copyWith(polyline: pol));
  }

  getRider() async {
    List<RiderModel> rider = await _firebaseRepository.getRider();

    emit(state.copyWith(rider: rider));
  }

  getRiderLocation(String id) async {
    emit(state.copyWith(
        riderLoadingState: LoadingState.loading, riderRating: 0.0));

    double riderRating = await _firebaseRepository.getRating(id);

    LocationModel riderLocation = await _firebaseRepository.getLocation(id);

    log.w(riderLocation);

    if (riderLocation.lattitude != null) {
      await _getETA(LatLng(riderLocation.lattitude!, riderLocation.longitude!),
          state.currentLocation!);

      _getPolyPointCordinate(LatLng(state.destinationLocation!.latitude,
              state.destinationLocation!.longitude))
          .then((value) => _generatePolyLine(value));

      emit(state.copyWith(
        riderLocation: riderLocation,
        riderLoadingState: LoadingState.loaded,
        riderRating: riderRating,
      ));
    } else {
      emit(state.copyWith(
          riderLocation: null, riderLoadingState: LoadingState.error));
    }
  }

  //Select destination address

  Future<void> selectDestinationLocation(BuildContext context) async {
    await autoComplete(context).then((value) => getRider());
  }

  Future<void> autoComplete(BuildContext context) async {
    emit(state.copyWith(
        rider: [], destinationAddress: TextEditingController(text: '')));

    mapServices.Prediction? prediction = await PlacesAutocomplete.show(
        context: context,
        apiKey: dotenv.env['GOOGLE_MAP_API_KEY'],
        mode: Mode.overlay,
        strictbounds: false,
        types: [],
        language: "en",
        components: [
          const mapServices.Component(mapServices.Component.country, "NG")
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
        markers = Set.of([currentLocationMarker]);
        //     markers.add(currentLocationMarker);

        emit(state.copyWith(
          markers: markers,
          destinationLocation: LatLng(latitude, longitude),
          bookingRideState: BookingState.initial,
        ));

        log.w(markers.length);
      }
    } else {}
  }

  //return the duration in min between two LatLng coordinates

  Future<int> _getETA(LatLng start, LatLng end) async {
    emit(state.copyWith(
        arrivingTimeState: LoadingState.loading, arivalDuration: 0));

    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&key=${dotenv.env['GOOGLE_MAP_API_KEY']}'));

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);

      final routes = decodedResponse['routes'] as List<dynamic>;

      final durationInSeconds =
          routes[0]['legs'][0]['duration']['value'] as int;

      final durationInMinutes = (durationInSeconds / 60).ceil();

      emit(state.copyWith(
          arrivingTimeState: LoadingState.loaded,
          arivalDuration: durationInMinutes));

      return durationInMinutes;
    } else {
      throw Exception('Failed to retrieve ETA');
    }
  }

  bookRide({required RiderModel rider}) async {
    var uuid = const Uuid();

    String uid = uuid.v4();

    emit(state.copyWith(
        rider: [],
        bookingRideState: BookingState.inProgess,
        uid: uid,
        currentRider: rider));

    List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        state.currentLocation!.latitude, state.currentLocation!.longitude);

    String address =
        '${placemarks[0].street} ${placemarks[0].subAdministrativeArea}, ${placemarks[0].administrativeArea}';

    Map<String, dynamic> payload() => {
          'rideId': Utils.generateRideRefrence(),
          'rider_details': {
            'riderName': rider.username,
            'riderPlate': rider.ridePlate,
            'riderModel': rider.rideModel,
          },
          'destination': state.destinationAddress.text,
          'pickupLocation': address,
          'amount': '300',
          'rideStatus': 'inProgess',
          'dateCreated': DateTime.now().toIso8601String(),
        };

    await _firebaseRepository.bookRide(
        payload: payload(),
        uid: uid,
        rider: rider.username!,
        fcm: state.userModel!.fcmToken!);

    emit(state.copyWith(bookingRideState: BookingState.inProgess));
  }

  viewCurrentRide(BuildContext context) {
    BlocProvider.of<HomePageBloc>(context)
        .add(GetRiderLocation(riderId: state.currentRider!.id!));

    context.push('/rideDetail', extra: state.currentRider);
  }

  cancelRide(BuildContext context, {required RiderModel riderModel}) async {
    await _firebaseRepository.cancelRide(
        uid: state.uid!,
        payload: {'rideStatus': 'cancel'},
        rider: riderModel.username!,
        fcm: state.userModel!.fcmToken!);

    showCustomSnackBar(message: 'you have cancelled this ride');

    Set<Marker> markers = state.markers;
    markers.removeWhere((element) => element.markerId.value == 'destination');

    emit(state.copyWith(
        uid: '',
        bookingRideState: BookingState.cancelled,
        destinationAddress: TextEditingController(text: ''),
        destinationLocation: null,
        markers: markers,
        currentRider: null));
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => RatingSceen(riderModel: riderModel),
    ));
  }

  storeFcmToken() async {
    String? token = await FirebaseMessaging.instance.getToken();

    log.w(token);

    if (token != null) {
      await _firebaseRepository.storeFcmToken(payload: {'fcmToken': token});
    } else {}
  }

  rateRide(BuildContext context,
      {required String rideFeedback,
      required String id,
      required double rating}) async {
    if (rating != null) {
      Map<String, dynamic> payload() => {
            'rating': rating,
            'feedback': rideFeedback,
            "dateCreated": DateTime.now().toIso8601String(),
          };

      await _firebaseRepository.rateRider(payload: payload(), riderId: id);

      context.replace('/homePage');
    } else {
      showCustomSnackBar(message: 'rider rating is empty');
    }
  }

  reset(BuildContext context) {
    locationStream!.cancel();
    FirebaseAuth.instance.signOut();
    context.replace('/login');
  }
}

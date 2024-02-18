import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationHelper {
  //haversin(x) = sin²(x / 2)

  static double distanceBetweenCoordinate(
      {required LatLng pickUp, required LatLng destination}) {
    const raduis = 6372.8; //Earth raduis in kilometers

    final dLat = _toRadians(pickUp.latitude - destination.latitude);

    final dLon = _toRadians(pickUp.longitude - destination.longitude);

    final lat1Radian = _toRadians(pickUp.latitude);
    final lat2Radians = _toRadians(destination.latitude);

    final haversin =
        _haversin(dLat) + cos(lat1Radian) * cos(lat2Radians) * _haversin(dLon);

    final val = 2 * asin(sqrt(haversin));

    return raduis * val;
  }

  static double _toRadians(double degree) => degree * pi / 100;

  static double _haversin(double radians) =>
      pow(sin(radians / 2), 2).toDouble();
}

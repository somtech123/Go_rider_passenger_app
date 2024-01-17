import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_rider/ui/features/dashboard/presentation/view/widget/home_screen_drawer.dart';
import 'package:go_rider/utils/app_constant/app_string.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  double mapBottomPadding = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          AppStrings.home,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      drawer: HomeScreenDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.terrain,
              padding: EdgeInsets.only(
                  bottom: mapBottomPadding, top: 0, right: 0, left: 0),
              initialCameraPosition: HomeScreen._kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                setState(() {
                  mapBottomPadding = 250;
                });
              },
            ),
            // floatingActionButton: FloatingActionButton.extended(
            //   onPressed: _goToTheLake,
            //   label: const Text('To the lake!'),
            //   icon: const Icon(Icons.directions_boat),
            // ),
          ],
        ),
      ),
    );
  }
}

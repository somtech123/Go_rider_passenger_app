import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideDetailScreen extends StatefulWidget {
  const RideDetailScreen({super.key});

  @override
  State<RideDetailScreen> createState() => _RideDetailScreenState();
}

class _RideDetailScreenState extends State<RideDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final HomePageBloc homeloc = BlocProvider.of<HomePageBloc>(context);

    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text(
            'Detail',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        body: BlocListener<HomePageBloc, HomePageState>(
          listener: (context, state) {},
          bloc: homeloc,
          child: BlocBuilder<HomePageBloc, HomePageState>(
            builder: (context, state) {
              return state.currentLocation == null
                  ? const Center(
                      child: Text('Loading..'),
                    )
                  : SafeArea(
                      child: Stack(
                        children: [
                          SizedBox(
                            height: height,
                            width: double.infinity,
                            child: GoogleMap(
                              mapType: MapType.terrain,
                              initialCameraPosition: CameraPosition(
                                  zoom: 14,
                                  target: LatLng(
                                      state.currentLocation!.latitude,
                                      state.currentLocation!.longitude)),
                              onMapCreated: (GoogleMapController controller) =>
                                  state.mapController.complete(controller),
                              markers: {
                                Marker(
                                    markerId: MarkerId('currentLocation'),
                                    position: state.currentLocation!,
                                    icon: BitmapDescriptor.defaultMarker)
                              },
                            ),
                          ),
                        ],
                      ),
                    );
            },
          ),
        ));
  }
}

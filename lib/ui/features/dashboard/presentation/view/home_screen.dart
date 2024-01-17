import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_event.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_state.dart';
import 'package:go_rider/ui/features/dashboard/presentation/view/widget/available_ride_widget.dart';
import 'package:go_rider/ui/features/dashboard/presentation/view/widget/home_screen_drawer.dart';
import 'package:go_rider/ui/shared/shared_widget/primary_button.dart';
import 'package:go_rider/utils/app_constant/app_string.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<HomePageBloc>(context).add(RequestLocation());
  }

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
            AppStrings.home,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        drawer: const HomeScreenDrawer(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.all(20.h),
          child: PrimaryButton(
            onPressed: () {
              context.push('/rideDetail');
            },
            label: AppStrings.bookRide,
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
                          Positioned(
                            top: 10.h,
                            left: 50.w,
                            child: SizedBox(
                              width: 300,
                              child: Column(
                                children: [
                                  CupertinoFormSection.insetGrouped(
                                    margin: EdgeInsets.zero,
                                    clipBehavior: Clip.antiAlias,
                                    // decoration: BoxDecoration(
                                    //   borderRadius: BorderRadius.circular(22.r),
                                    // ),
                                    children: [
                                      CupertinoTextFormFieldRow(
                                          placeholder: 'PPP'),
                                      CupertinoTextFormFieldRow(
                                          placeholder: 'PPP'),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  CupertinoFormSection.insetGrouped(
                                    margin: EdgeInsets.zero,
                                    clipBehavior: Clip.antiAlias,
                                    // decoration: BoxDecoration(
                                    //   borderRadius: BorderRadius.circular(22.r),
                                    // ),
                                    children: [
                                      CupertinoTextFormFieldRow(
                                          placeholder: 'PPP'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 100.0.h,
                            child: AvailableRideWideget(),
                          )
                        ],
                      ),
                    );
            },
          ),
        ));
  }
}

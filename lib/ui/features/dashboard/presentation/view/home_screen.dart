import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_event.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_state.dart';
import 'package:go_rider/ui/features/dashboard/presentation/view/widget/available_ride_widget.dart';
import 'package:go_rider/ui/features/dashboard/presentation/view/widget/home_screen_drawer.dart';
import 'package:go_rider/ui/shared/shared_widget/primary_button.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
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

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final HomePageBloc homeloc = BlocProvider.of<HomePageBloc>(context);

    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.primaryColor,
          title: Text(
            AppStrings.home,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 15.h),
              child: SvgPicture.asset(
                'assets/svgs/notification.svg',
                height: 20.h,
                width: 20.w,
              ),
            ),
          ],
          leadingWidth: 23.w,
          leading: SizedBox(
            width: 30.w,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.h),
                    child: GestureDetector(
                      onTap: () {
                        scaffoldKey.currentState!.openDrawer();
                      },
                      child: SvgPicture.asset(
                        'assets/svgs/handburger_svg.svg',
                        height: 25.h,
                        width: 25.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
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

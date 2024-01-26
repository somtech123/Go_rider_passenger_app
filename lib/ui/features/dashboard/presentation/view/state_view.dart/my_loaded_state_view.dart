import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_state.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class MyHomeScreenLoadedStateView extends StatelessWidget {
  MyHomeScreenLoadedStateView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    final HomePageBloc homeloc = BlocProvider.of<HomePageBloc>(context);

    return BlocBuilder<HomePageBloc, HomePageState>(
      bloc: homeloc,
      builder: (context, state) {
        if (state.currentLocation == null) {
          return const Center(
            child: Text('Getting device location'),
          );
        } else {
          return SafeArea(
            child: Stack(
              children: [
                SizedBox(
                  height: height,
                  width: double.infinity,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: true,
                    zoomGesturesEnabled: true,
                    initialCameraPosition: CameraPosition(
                        zoom: 14,
                        target: LatLng(state.currentLocation!.latitude,
                            state.currentLocation!.longitude)),
                    onMapCreated: (GoogleMapController controller) {
                      state.mapController.complete(controller);
                    },
                    circles: state.circles,
                    markers: state.markers,
                    polylines: Set<Polyline>.of(state.polyline.values),
                    onCameraMove: (position) {},
                  ),
                ),
                Positioned(
                  top: 10.h,
                  left: 50.w,
                  child: SizedBox(
                    width: 300,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => context.push('/route'),
                          child: CupertinoFormSection.insetGrouped(
                            margin: EdgeInsets.zero,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                            ),
                            children: [
                              AbsorbPointer(
                                absorbing: true,
                                child: CupertinoTextFormFieldRow(
                                  textAlign: TextAlign.center,
                                  prefix: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset('assets/svgs/from.svg'),
                                      SizedBox(width: 5.w),
                                      Text(
                                        'From:',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.darkColor),
                                      )
                                    ],
                                  ),
                                  placeholder: 'Your Location',
                                  controller: state.pickUpAddress,
                                  onEditingComplete: () {
                                    log.w('comple');
                                  },
                                ),
                              ),
                              AbsorbPointer(
                                absorbing: true,
                                child: CupertinoTextFormFieldRow(
                                  placeholder: 'Your Destination',
                                  textAlign: TextAlign.center,
                                  controller: state.destinationAddress,
                                  onEditingComplete: () {
                                    log.w('comple');
                                  },
                                  prefix: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset('assets/svgs/to.svg'),
                                      SizedBox(width: 5.w),
                                      Text(
                                        'To:',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.darkColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ),
                // Positioned(
                //   bottom: 30.0.h,
                //   child: const AvailableRideWideget(),
                // )
              ],
            ),
          );
        }
      },
    );
  }
}

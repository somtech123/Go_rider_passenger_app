import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_event.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_state.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class MyHomeScreenLoadedStateView extends StatelessWidget {
  MyHomeScreenLoadedStateView({super.key, r //equired this.state
      });

  // HomePageState state;
  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        return state.currentLocation == null
            ? const Center(
                child: Text('Getting device location'),
              )
            : SafeArea(
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
                            CupertinoFormSection.insetGrouped(
                              margin: EdgeInsets.zero,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                              ),
                              children: [
                                CupertinoTextFormFieldRow(
                                    textAlign: TextAlign.center,
                                    prefix: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/svgs/from.svg'),
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
                                    placeholder: 'Your Location'),
                                CupertinoTextFormFieldRow(
                                  placeholder: 'Your Destination',
                                  textAlign: TextAlign.center,
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
                              ],
                            ),
                            SizedBox(height: 10.h),
                            // CupertinoFormSection.insetGrouped(
                            //   margin: EdgeInsets.zero,
                            //   clipBehavior: Clip.antiAlias,
                            //   children: [
                            //     CupertinoFormRow(
                            //       child: SvgPicture.asset('assets/svgs/to.svg'),
                            //       prefix: Text(
                            //         'When',
                            //         style: Theme.of(context)
                            //             .textTheme
                            //             .bodySmall!
                            //             .copyWith(
                            //                 fontSize: 16,
                            //                 fontWeight: FontWeight.w400,
                            //                 color: AppColor.darkColor),
                            //       ),
                            //     ),
                            //   ],
                            // ),
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
      },
    );
  }
}

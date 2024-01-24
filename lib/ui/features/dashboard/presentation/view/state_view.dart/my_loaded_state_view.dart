import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_state.dart';
import 'package:go_rider/ui/features/dashboard/presentation/view/widget/available_ride_widget.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class MyHomeScreenLoadedStateView extends StatelessWidget {
  MyHomeScreenLoadedStateView({super.key, required this.state});

  HomePageState state;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return state.currentLocation == null
        ? Center(
            child: Text(
              'Getting Device Location......',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
            ),
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
                        target: LatLng(state.currentLocation!.latitude,
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
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          children: [
                            CupertinoTextFormFieldRow(
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
                Positioned(
                  bottom: 30.0.h,
                  child: const AvailableRideWideget(),
                )
              ],
            ),
          );
  }
}

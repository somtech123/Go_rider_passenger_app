import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_rider/app/helper/booking_state_helper.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_event.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_state.dart';
import 'package:go_rider/ui/features/dashboard/presentation/view/widget/available_ride_widget.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHomeScreenLoadedStateView extends StatelessWidget {
  const MyHomeScreenLoadedStateView({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    final HomePageBloc homeloc = BlocProvider.of<HomePageBloc>(context);

    return BlocBuilder<HomePageBloc, HomePageState>(
      bloc: homeloc,
      builder: (context, state) {
        if (state.currentLocation == null) {
          return const Center(
            child: Text('Getting device location....'),
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
                    trafficEnabled: true,
                    initialCameraPosition: CameraPosition(
                        zoom: 14,
                        target: LatLng(state.currentLocation!.latitude,
                            state.currentLocation!.longitude)),
                    onMapCreated: (GoogleMapController controller) {
                      state.mapController.complete(controller);
                    },
                    markers: state.markers,
                    //  polylines: Set<Polyline>.of(state.polyline.values),
                    onCameraMove: (position) {
                      homeloc.add(MoveCameraPosition());
                    },
                  ),
                ),
                Positioned(
                  top: 10.h,
                  left: 50.w,
                  child: state.bookingRideState == BookingState.inProgess
                      ? Container(
                          width: 300.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(
                              top: 10.h, left: 10.h, right: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'You are EnRoute',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.darkColor),
                              ),
                              TextButton(
                                  onPressed: () {
                                    homeloc
                                        .add(ViewActiveRide(context: context));
                                  },
                                  child: Text(
                                    'View ride',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                            fontSize: 14,
                                            color: AppColor.primaryColor),
                                  ))
                            ],
                          ))
                      : SizedBox(
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
                                            SvgPicture.asset(
                                                'assets/svgs/from.svg'),
                                            SizedBox(width: 5.w),
                                            Text(
                                              'From:',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          AppColor.greyColor),
                                            )
                                          ],
                                        ),
                                        placeholder: 'Your Location',
                                        expands: true,
                                        minLines: null,
                                        maxLines: null,
                                        controller: state.pickUpAddress,
                                        onEditingComplete: () {},
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                                fontSize: 14,
                                                color: AppColor.darkColor),
                                      ),
                                    ),
                                    AbsorbPointer(
                                      absorbing: true,
                                      child: CupertinoTextFormFieldRow(
                                        placeholder: 'Your Destination',
                                        textAlign: TextAlign.center,
                                        controller: state.destinationAddress,
                                        expands: true,
                                        minLines: null,
                                        maxLines: null,
                                        onEditingComplete: () {},
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                                fontSize: 14,
                                                color: AppColor.darkColor),
                                        prefix: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SvgPicture.asset(
                                                'assets/svgs/to.svg'),
                                            SizedBox(width: 5.w),
                                            Text(
                                              'To:',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          AppColor.greyColor),
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
                Visibility(
                  visible: state.onCameraMove == true,
                  child: Positioned(
                    bottom: height / 2,
                    right: 20.h,
                    child: CircleAvatar(
                        radius: 25.r,
                        backgroundColor: AppColor.whiteColor,
                        child: Align(
                          alignment: Alignment.center,
                          child: IconButton(
                              onPressed: () {
                                homeloc.add(ResetCameraPosition());
                              },
                              icon: const Icon(Icons.near_me)),
                        )),
                  ),
                ),
                Visibility(
                  visible: state.rider!.isNotEmpty,
                  // destinationAddress.text.isNotEmpty,
                  child: Positioned(
                    bottom: 30.0.h,
                    child: AvailableRideWideget(rider: state.rider!),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}

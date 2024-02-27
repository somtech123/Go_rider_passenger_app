import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_rider/app/helper/booking_state_helper.dart';
import 'package:go_rider/app/helper/local_state_helper.dart';
import 'package:go_rider/ui/features/chat/presentation/view/view_layout.dart';
import 'package:go_rider/ui/features/dashboard/data/rider_model.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_event.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_state.dart';
import 'package:go_rider/ui/features/dashboard/presentation/view/state_view.dart/my_error_state_view.dart';
import 'package:go_rider/ui/shared/shared_widget/primary_button.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class RideDetailScreen extends StatefulWidget {
  RideDetailScreen({super.key, required this.riderModel});

  RiderModel riderModel;

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
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          iconTheme: const IconThemeData(color: AppColor.whiteColor),
          backgroundColor: AppColor.primaryColor,
          // title: Text(
          //  // 'Detail',
          //   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          //       fontSize: 16,
          //       fontWeight: FontWeight.w600,
          //       color: AppColor.whiteColor),
          // ),
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
                  : state.riderLoadingState == LoadingState.loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : state.riderLoadingState == LoadingState.error
                          ? const MyHomeScreenErrorView()
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
                                      trafficEnabled: true,
                                      onCameraMove: (position) {
                                        //  homeloc.add(MoveCameraPosition());
                                      },
                                      initialCameraPosition: CameraPosition(
                                          zoom: 14,
                                          target: LatLng(
                                              state.currentLocation!.latitude,
                                              state
                                                  .currentLocation!.longitude)),
                                      onMapCreated:
                                          (GoogleMapController controller) =>
                                              state.mapController
                                                  .complete(controller),
                                      markers: state.markers,
                                      polylines: Set<Polyline>.of(
                                          state.polyline.values),
                                    ),
                                  ),
                                  Positioned(
                                      top: 10.h,
                                      left: 50.w,
                                      child: Visibility(
                                        visible: state.bookingRideState ==
                                            BookingState.inProgess,
                                        child: Container(
                                            width: 300.w,
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
                                            ),
                                            alignment: Alignment.topCenter,
                                            padding: EdgeInsets.only(
                                                top: 10.h,
                                                left: 10.h,
                                                right: 10.h),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'You are EnRoute',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall!
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColor
                                                              .darkColor),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewLayout(
                                                        sender:
                                                            state.userModel!,
                                                        receiver:
                                                            widget.riderModel,
                                                      ),
                                                    ));
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        AppColor.primaryColor,
                                                    radius: 20.r,
                                                    child: SvgPicture.asset(
                                                        'assets/svgs/chat.svg'),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      )),
                                  Visibility(
                                    visible: state.bookingRideState !=
                                        BookingState.cancelled,
                                    //      &&
                                    // state.bookingRideState ==
                                    //     BookingState.inProgess,
                                    child: Positioned(
                                      bottom: 0,
                                      child: _detailContainer(context,
                                          riderModel: widget.riderModel),
                                    ),
                                  )
                                ],
                              ),
                            );
            },
          ),
        ));
  }
}

Widget _detailContainer(BuildContext context,
    {required RiderModel riderModel}) {
  return BlocBuilder<HomePageBloc, HomePageState>(
    builder: (context, state) {
      return Container(
        height: 300.h,
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.h),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Driver Information',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColor.darkColor),
            ),
            SizedBox(height: 15.h),
            SizedBox(
              height: 70.h,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(radius: 30.r),
                trailing: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ViewLayout(
                        sender: state.userModel!,
                        receiver: riderModel,
                      ),
                    ));
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColor.primaryColor,
                    radius: 20.r,
                    child: SvgPicture.asset('assets/svgs/chat.svg'),
                  ),
                ),
                title: Text(
                  riderModel.username!,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColor.primaryColor),
                ),
                subtitle: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 15.h,
                      itemPadding: EdgeInsets.symmetric(horizontal: 2.h),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25.h),
            SizedBox(
              height: 30.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(riderModel.rideModel!,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColor.darkColor)),
                  Text('Arriving in',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColor.darkColor)),
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(riderModel.phoneNumber!,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: AppColor.darkColor)),
                  Text('Arriving in',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: AppColor.darkColor)),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            PrimaryButton(
              onPressed: state.bookingRideState == BookingState.initial
                  ? () {
                      BlocProvider.of<HomePageBloc>(context)
                          .add(BookRider(rider: riderModel));
                    }
                  : () {
                      BlocProvider.of<HomePageBloc>(context).add(
                          CancelRide(context: context, riderModel: riderModel));
                    },
              label: state.bookingRideState == BookingState.initial
                  ? 'Start Ride'
                  : 'Cancel Ride',
            ),
          ],
        ),
      );
    },
  );
}

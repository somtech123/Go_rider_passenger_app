import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_state.dart';
import 'package:go_rider/ui/shared/shared_widget/primary_button.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:go_router/go_router.dart';
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
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          iconTheme: const IconThemeData(color: AppColor.whiteColor),
          backgroundColor: AppColor.primaryColor,
          title: Text(
            'Detail',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColor.whiteColor),
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
                                    markerId: const MarkerId('currentLocation'),
                                    position: state.currentLocation!,
                                    icon: BitmapDescriptor.defaultMarker)
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: _detailContainer(context),
                          )
                        ],
                      ),
                    );
            },
          ),
        ));
  }
}

Widget _detailContainer(BuildContext context) {
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
                context.push('/chatPage');
              },
              child: CircleAvatar(
                backgroundColor: AppColor.primaryColor,
                radius: 20.r,
                child: SvgPicture.asset('assets/svgs/chat.svg'),
              ),
            ),
            title: Text(
              'Shabbir Aly Khan',
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
                Text(
                  '(234)',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                )
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
              Text('Mercedes-Benz',
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
              Text('DL-2473854',
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
          onPressed: () {},
          label: 'Cancel Ride',
        ),
      ],
    ),
  );
}

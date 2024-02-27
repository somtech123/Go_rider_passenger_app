import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_rider/ui/features/dashboard/data/rider_model.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_event.dart';
import 'package:go_rider/ui/shared/shared_widget/primary_button.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:go_rider/utils/app_constant/app_string.dart';

// ignore: must_be_immutable
class RatingSceen extends StatefulWidget {
  RatingSceen({super.key, required this.riderModel});

  RiderModel riderModel;

  @override
  State<RatingSceen> createState() => _RatingSceenState();
}

class _RatingSceenState extends State<RatingSceen> {
  double _rating = 0.0;

  TextEditingController rideFeedbackCtr = TextEditingController();

  @override
  void dispose() {
    rideFeedbackCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Review Ride',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColor.whiteColor),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.h),
        child: PrimaryButton(
            onPressed: () {
              BlocProvider.of<HomePageBloc>(context).add(RateRider(
                  rating: _rating,
                  context: context,
                  rideFeedback: rideFeedbackCtr.text,
                  riderId: widget.riderModel.id!));
            },
            label: 'Confirm'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 18.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColor.primaryColor.withOpacity(0.25),
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: 30.r,
                      backgroundImage: NetworkImage(
                          widget.riderModel.profileImage ??
                              AppStrings.dummyProfilePicture),
                    ),
                    title: Text(
                      widget.riderModel.username!,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColor.darkColor),
                    ),
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                  Text(
                    'How was your ride with ${widget.riderModel.username!}?',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: RatingBar.builder(
                        minRating: 1,
                        itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: AppColor.primaryColor,
                            ),
                        updateOnDrag: true,
                        onRatingUpdate: (rating) {
                          setState(() {
                            _rating = rating;
                          });
                        }),
                  ),
                  SizedBox(height: 20.h),
                  RichText(
                    text: const TextSpan(
                      text: 'Tell us more',
                      children: [
                        TextSpan(
                          text: ' (Optional)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff828282),
                          ),
                        ),
                      ],
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    maxLines: 4,
                    controller: rideFeedbackCtr,
                    decoration: InputDecoration(
                      hintText: 'Note',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: const Color(0xffE0E0E0)),
                      isDense: false,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.r),
                          borderSide: BorderSide(
                              color: const Color(0xffF5F5F5), width: 2.w)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.r),
                          borderSide: BorderSide(
                              color: const Color(0xffF5F5F5), width: 2.w)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

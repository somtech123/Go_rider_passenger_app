import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';

class AvailableRideWideget extends StatelessWidget {
  const AvailableRideWideget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.w,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 15,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(left: 5.h, right: 5.h),
              child: const AvailableRideContainer(),
            );
          }),
    );
  }
}

class AvailableRideContainer extends StatelessWidget {
  const AvailableRideContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        width: 150.w,
        padding: EdgeInsets.only(top: 10.h),
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mercedes-Benz',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 16, color: AppColor.whiteColor),
            ),
            SizedBox(height: 10.h),
            Text(
              'Mercedes-Benz',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14, color: AppColor.whiteColor),
            ),
            SizedBox(height: 10.h),
            Text(
              'Mercedes-Benz',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14, color: AppColor.whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}

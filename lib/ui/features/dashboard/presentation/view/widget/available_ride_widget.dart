import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:go_rider/utils/utils/currency_formater.dart';

class AvailableRideWideget extends StatelessWidget {
  const AvailableRideWideget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 15,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(left: 5.h, right: 5.h),
              child: AvailableRideContainer(
                vehicleName: 'Mercedes-Benz',
                vehiclePlate: 'DL-2473854',
                type: '3 Person Can Ride',
                price: CurrencyUtils.formatCurrency.format(double.parse('340')),
              ),
            );
          }),
    );
  }
}

class AvailableRideContainer extends StatelessWidget {
  const AvailableRideContainer(
      {super.key,
      required this.vehicleName,
      required this.vehiclePlate,
      required this.price,
      required this.type});
  final String vehicleName;
  final String vehiclePlate;
  final String type;
  final String price;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        width: 230.w,
        padding: EdgeInsets.only(top: 10.h),
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              vehicleName,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 18,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 5.h),
            Text(
              vehiclePlate,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 14,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5.h),
            Text(
              type,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 14,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w500),
            ),
            SvgPicture.asset(
              'assets/svgs/car.svg',
              height: 95.h,
            ),
            Text(
              price,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 14,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

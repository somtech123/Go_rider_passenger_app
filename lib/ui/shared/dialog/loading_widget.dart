import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';

showloader(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: AppColor.transparent,
              child: Container(
                padding: EdgeInsets.all(20.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.r),
                    ),
                    color: AppColor.whiteColor),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            );
          },
        );
      },
      barrierDismissible: false);
}

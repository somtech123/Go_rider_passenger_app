import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_rider/ui/shared/shared_widget/primary_button.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

showSuccessDialog(BuildContext context, {required String message}) {
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
                      Radius.circular(36.r),
                    ),
                    color: AppColor.whiteColor),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset('assets/gifs/success_animation.json'),
                    SizedBox(height: 10.h),
                    Text('Success',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18)),
                    SizedBox(height: 10.h),
                    Text(message,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            )),
                    SizedBox(height: 10.h),
                    PrimaryButton(
                        onPressed: () {
                          context.pop();
                        },
                        label: 'Ok')
                  ],
                ),
              ),
            );
          },
        );
      },
      barrierDismissible: false);
}

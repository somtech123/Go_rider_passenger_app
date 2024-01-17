import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_rider/ui/shared/shared_widget/app_text_field.dart';
import 'package:go_rider/ui/shared/shared_widget/primary_button.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:go_rider/utils/app_constant/app_string.dart';

class LoginBodyView extends StatelessWidget {
  const LoginBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 25.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50.h),
          Text(
            AppStrings.enterEmail,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.darkColor),
          ),
          SizedBox(height: 10.h),
          const AppTextField(
            hintText: 'User Name',
            prefixIcon: Icon(Icons.mail),
          ),
          SizedBox(height: 20.h),
          Text(
            AppStrings.enterPassword,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.darkColor),
          ),
          SizedBox(height: 10.h),
          const AppTextField(
            hintText: 'Password',
            prefixIcon: Icon(Icons.lock),
          ),
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              child: Text(
                AppStrings.forgetPassword,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: AppColor.greyColor),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          PrimaryButton(
            onPressed: () {},
            label: AppStrings.siginIN,
            bottomLeftRadius: 30.r,
            bottomRightRadius: 30.r,
            topLeftRadius: 30.r,
            topRightRadius: 30.r,
          )
        ],
      ),
    ));
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_rider/app/resouces/app_logger.dart';
import 'package:go_rider/ui/features/authentication/login/presentation/view/widget/social_button_widget.dart';
import 'package:go_rider/ui/shared/shared_widget/app_text_field.dart';
import 'package:go_rider/ui/shared/shared_widget/primary_button.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:go_rider/utils/app_constant/app_string.dart';
import 'package:go_router/go_router.dart';

var log = getLogger('login');

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
          SizedBox(height: 30.h),
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
            onPressed: () {
              context.replace('/homePage');
            },
            label: AppStrings.siginIN,
          ),
          SizedBox(height: 25.h),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              child: Text(
                AppStrings.connect,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: AppColor.greyColor),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          socilaButton(
            context,
            ontap: () {
              log.w('google clicked');
            },
            text: AppStrings.googleConnect,
            leading: Image.asset(
              'assets/images/google_icon.png',
              height: 20.h,
            ),
          ),
          SizedBox(height: 10.h),
          socilaButton(context, ontap: () {
            log.w('facebook clicked');
          },
              text: AppStrings.facebookConnect,
              leading: SvgPicture.asset(
                'assets/svgs/facebook.svg',
              )),
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                  text: "Don't have an account?",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColor.greyColor),
                  children: [
                    TextSpan(
                        text: ' Sign up',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            log.w('navigate to sign up screen');
                            context.push('/signUp');
                          },
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: AppColor.primaryColor,
                            ))
                  ]),
            ),
          )
        ],
      ),
    ));
  }
}

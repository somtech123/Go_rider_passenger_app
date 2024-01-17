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

var log = getLogger('SignUPScreen');

class SignUpBodyWidget extends StatelessWidget {
  const SignUpBodyWidget({super.key});

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
            AppStrings.fullName,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.darkColor),
          ),
          SizedBox(height: 10.h),
          const AppTextField(
            hintText: 'User Name',
            prefixIcon: Icon(Icons.person),
          ),
          SizedBox(height: 20.h),
          Text(
            AppStrings.enterPassword,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.darkColor),
          ),
          SizedBox(height: 20.h),
          const AppTextField(
            hintText: 'Email Address',
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
          SizedBox(height: 30.h),
          PrimaryButton(
            onPressed: () {},
            label: AppStrings.siginup,
            bottomLeftRadius: 30.r,
            bottomRightRadius: 30.r,
            topLeftRadius: 30.r,
            topRightRadius: 30.r,
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
          SizedBox(height: 20.h),
          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                  text: "Already have an account?",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColor.greyColor),
                  children: [
                    TextSpan(
                        text: ' Sign in',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            log.w('navigate to login screen');
                            context.replace('/login');
                          },
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: AppColor.primaryColor,
                            ))
                  ]),
            ),
          ),
          SizedBox(height: 50.h),
        ],
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_rider/ui/features/authentication/reset_password/presntation/view/widget/reset_password_view.dart';
import 'package:go_rider/ui/shared/shared_widget/circular_container.dart';
import 'package:go_rider/ui/shared/top_widget/full_top_widget.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';

class ForgottenPasswordScreen extends StatelessWidget {
  const ForgottenPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
          child: SizedBox(
            height: height,
            width: width,
            // flex: 1,
            child: Column(
              children: [
                Flexible(
                  child: SizedBox(
                    height: height,
                    width: width,
                    child: Stack(
                      children: [
                        CircularContainerWidget(
                          height: 100.h,
                          width: width,
                          borderRaduis: 0,
                          color: AppColor.primaryColor,
                          child: FullTopBarWidget(
                            automaticallyImplyLeading: false,
                            title: RichText(
                              text: TextSpan(
                                  text: 'Reset Password\n',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.whiteColor,
                                      ),
                                  children: [
                                    TextSpan(
                                        text: '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: AppColor.whiteColor,
                                            ))
                                  ]),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 80.h,
                          child: SizedBox(
                            height: height - 75.h,
                            width: width,
                            child: CircularContainerWidget(
                              color: AppColor.secondaryColor,
                              height: height - 75.h,
                              width: width,
                              borderRaduis: 30.r,
                              child: const ResetPasswordView(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

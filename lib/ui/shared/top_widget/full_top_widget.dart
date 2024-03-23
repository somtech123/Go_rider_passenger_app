import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:go_rider/utils/utils/device_utils.dart';
import 'package:go_router/go_router.dart';
  
// ignore: must_be_immutable
class FullTopBarWidget extends StatelessWidget implements PreferredSizeWidget {
  FullTopBarWidget(
      {super.key,
      this.title,
      this.action,
      this.automaticallyImplyLeading = true});

  final Widget? title;
  final List<Widget>? action;
  bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
      ),
      child: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: automaticallyImplyLeading == true
            ? title
            : Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColor.whiteColor,
                    ),
                  ),
                  SizedBox(width: 10.h),
                  Padding(
                    padding: EdgeInsets.only(top: 30.h),
                    child: title!,
                  )
                ],
              ),

        automaticallyImplyLeading: false,
        // leading: Icon(Icons.arrow_back_ios),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight());
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:go_rider/utils/utils/device_utils.dart';

class FullTopBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const FullTopBarWidget({super.key, this.title, this.action});

  final Widget? title;
  final List<Widget>? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
      ),
      child: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: title,
        automaticallyImplyLeading: false,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight());
}

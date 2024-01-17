import 'package:flutter/material.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';

Widget socilaButton(
  BuildContext context, {
  required Widget leading,
  required String text,
  required VoidCallback ontap,
}) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: AppColor.fillColor),
      child: ListTile(
        leading: leading,
        title: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.greyColor),
        ),
      ),
    ),
  );
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';

class ViewLayout extends StatelessWidget {
  const ViewLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        iconTheme: const IconThemeData(color: AppColor.whiteColor),
        backgroundColor: AppColor.primaryColor,
        title: Text(
          'Inbox',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColor.whiteColor),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.h),
            child: SvgPicture.asset(
              'assets/svgs/notification.svg',
              height: 20.h,
              width: 20.w,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(20.h),
        child: ClipPath(
          clipper: ArcPainter(),
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColor.darkColor,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: const [
                BoxShadow(
                  color: AppColor.fillColor,
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }
}

class ArcPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0); // Move to top right corner
    path.quadraticBezierTo(
      size.width,
      size.height / 2,
      size.width / 2,
      size.height,
    ); // Draw a curve to bottom right corner
    path.lineTo(0, size.height); // Move to bottom left corner
    path.lineTo(0, 0); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

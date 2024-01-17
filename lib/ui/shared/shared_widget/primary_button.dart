import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:go_rider/utils/app_constant/app_constant.dart';
import 'package:go_rider/utils/utils/responsive_ui.dart';

// ignore: must_be_immutable
class PrimaryButton extends StatelessWidget {
  final String label;
  final Color? labelColor;
  final Function? onPressed;
  final Color? backgroundColor;
  final Color? accentColor;
  final Color? borderColor;
  bool hideBorder;
  final double? topLeftRadius;
  final double? topRightRadius;
  final double? bottomRightRadius;
  final double? bottomLeftRadius;

  PrimaryButton(
      {Key? key,
      required this.label,
      this.labelColor,
      required this.onPressed,
      this.backgroundColor,
      this.accentColor,
      this.hideBorder = false,
      this.borderColor,
      this.topLeftRadius,
      this.bottomLeftRadius,
      this.bottomRightRadius,
      this.topRightRadius})
      : super(key: key);

  MaterialStateProperty<T> changeButtonStyle<T>(style) =>
      MaterialStateProperty.all<T>(style);

  @override
  Widget build(BuildContext context) {
    final fs = fullScreen(context);
    final h = sHeight(context);

    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: changeButtonStyle<Size>(Size(
          fs('width'),
          h(58.0),
        )),
        animationDuration: const Duration(
            microseconds: AppConstant.buttonSplashAnimationDuration),
        backgroundColor:
            changeButtonStyle<Color>(backgroundColor ?? AppColor.primaryColor),
        overlayColor: changeButtonStyle<Color>(
          accentColor ?? AppColor.buttonOverlay,
        ),
        shape: changeButtonStyle<OutlinedBorder>(
          hideBorder
              ? RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(topLeftRadius ?? 30.r),
                      bottomLeft: Radius.circular(bottomLeftRadius ?? 30.r),
                      bottomRight: Radius.circular(bottomRightRadius ?? 30.r),
                      topRight: Radius.circular(topRightRadius ?? 30.r)))
              : RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1.0, color: borderColor ?? Colors.transparent),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(topLeftRadius ?? 30.r),
                      bottomLeft: Radius.circular(bottomLeftRadius ?? 30.r),
                      bottomRight: Radius.circular(bottomRightRadius ?? 30.r),
                      topRight: Radius.circular(topRightRadius ?? 30.r))),
        ),
        elevation: changeButtonStyle<double>(0.0),
      ),
      onPressed: onPressed == null ? null : () => onPressed!(),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 15,
              color: labelColor ?? Colors.white,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

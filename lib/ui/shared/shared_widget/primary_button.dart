import 'package:flutter/material.dart';
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
                      topLeft: Radius.circular(topLeftRadius ?? 15.0),
                      bottomLeft: Radius.circular(bottomLeftRadius ?? 115.0),
                      bottomRight: Radius.circular(bottomRightRadius ?? 15.0),
                      topRight: Radius.circular(topRightRadius ?? 15.0)))
              : RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1.0, color: borderColor ?? Colors.transparent),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(topLeftRadius ?? 15.0),
                      bottomLeft: Radius.circular(bottomLeftRadius ?? 15.0),
                      bottomRight: Radius.circular(bottomRightRadius ?? 15.0),
                      topRight: Radius.circular(topRightRadius ?? 15.0))),
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

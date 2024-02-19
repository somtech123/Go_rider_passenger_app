import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';

class AppTextField extends StatelessWidget {
  final String? hintText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final InputDecoration? inputDecoration;
  final void Function(String)? onChanged;

  final TextInputType? keyboardType;

  final bool obscureText;

  final String? errorMessage;

  final FocusNode? focusNode;

  final TextEditingController? controller;

  final bool enabled;

  final List<TextInputFormatter>? inputFormatters;

  final bool enableInteractiveSelection;

  final double borderRadius;

  final Widget? suffixIcon;

  final Widget? prefixIcon;

  final String? helperText;

  final bool isTransparentBorder;

  final Color? textColor;

  final int? maxLines;

  final TextCapitalization textCapitalization;

  final Color borderColor;

  final int maxLength;

  final String? Function(String?)? validator;

  final VoidCallback? ontap;
  final VoidCallback? onEdittingComplete;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contentPadding;

  const AppTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.keyboardType,
    this.errorMessage,
    this.textInputAction,
    this.controller,
    this.focusNode,
    this.borderRadius = 10.0,
    this.enabled = true,
    this.inputFormatters,
    this.maxLines,
    this.hintStyle,
    this.helperText,
    this.enableInteractiveSelection = true,
    this.obscureText = false,
    this.isTransparentBorder = false,
    this.textCapitalization = TextCapitalization.none,
    this.borderColor = Colors.transparent,
    this.validator,
    this.textColor,
    this.maxLength = TextField.noMaxLength,
    this.textStyle,
    this.inputDecoration,
    this.onFieldSubmitted,
    this.ontap,
    this.onEdittingComplete,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      enableInteractiveSelection: enableInteractiveSelection,
      enabled: enabled,
      cursorColor: AppColor.primaryColor,
      textCapitalization: textCapitalization,
      controller: controller,
      validator: validator,
      focusNode: focusNode,
      obscureText: obscureText,
      maxLines: maxLines ?? 1,
      keyboardType: keyboardType,
      maxLength: maxLength,
      style: textStyle ??
          Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 13),
      decoration: inputDecoration ??
          InputDecoration(
            helperText: helperText,
            errorText: errorMessage == "" || errorMessage == null
                ? null
                : errorMessage,
            counterText: "",
            errorStyle: const TextStyle(fontSize: 12),
            contentPadding:
                contentPadding ?? EdgeInsets.fromLTRB(12.h, 20.h, 12.h, 20.h),
            hintStyle: hintStyle ??
                Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColor.greyColor),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color:
                        isTransparentBorder ? Colors.transparent : borderColor,
                    width: 1),
                borderRadius: BorderRadius.circular(borderRadius)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                    color:
                        isTransparentBorder ? Colors.transparent : borderColor,
                    width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                    color: isTransparentBorder
                        ? Colors.transparent
                        : AppColor.primaryColor,
                    width: 2)),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color:
                        isTransparentBorder ? Colors.transparent : borderColor,
                    width: 1),
                borderRadius: BorderRadius.circular(borderRadius)),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color:
                        isTransparentBorder ? Colors.transparent : Colors.red,
                    width: 1)),
            filled: true,
            fillColor: AppColor.fillColor,
            hintText: hintText,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
          ),
      onChanged: onChanged,
      textInputAction: textInputAction,
      onTap: ontap,
      onEditingComplete: onEdittingComplete,
      onFieldSubmitted: onFieldSubmitted ??
          (value) {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
    );
  }
}

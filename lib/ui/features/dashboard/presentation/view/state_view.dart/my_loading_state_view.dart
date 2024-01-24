import 'package:flutter/material.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';

class MyHomeScreenLoadingView extends StatelessWidget {
  const MyHomeScreenLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColor.primaryColor),
    );
  }
}

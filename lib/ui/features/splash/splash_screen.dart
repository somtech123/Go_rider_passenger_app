import 'package:flutter/material.dart';
import 'package:go_rider/main.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  moveToNext() async {
    log.w('splash screen active');
    context.replace('/login');
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      moveToNext();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: Column(),
      ),
    );
  }
}

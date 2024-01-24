import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_rider/main.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  checkIfUserIsLoggedIn() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      log.w('going to home screen');
      context.replace('/homePage');
    } else {
      log.w('going to login screen');
      context.replace('/login');
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      checkIfUserIsLoggedIn();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100.h),
              Container(
                height: 140.h,
                width: 160.w,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/svgs/logo.svg',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

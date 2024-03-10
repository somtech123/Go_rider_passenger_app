import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AnimationController? _controller;
  Animation<Offset>? _animation;

  Future<void> initiAnimation() async {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _animation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeInCubic));
    _controller!.forward();
  }

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
    super.initState();
    initiAnimation()
        .then((value) => Future.delayed(const Duration(milliseconds: 3000), () {
              checkIfUserIsLoggedIn();
            }));
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColor.primaryColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColor.primaryColor,
      ),
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: SafeArea(
          child: Center(
            child: SlideTransition(
              position: _animation!,
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
        ),
      ),
    );
  }
}

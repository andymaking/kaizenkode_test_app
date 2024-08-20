import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kaizenkode_test_app/data/cache/app_image.dart';
import 'package:kaizenkode_test_app/data/routes/app_routers.dart';
import 'package:kaizenkode_test_app/widgets/apptexts.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  bool? isLogIn = false;
  bool? isUserSetPin = false;
  bool? onBoardingCompleted = false;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // HANDLE NAVIGATION AFTER SPLASH SCREEN
          appRelaunch();
        }
      });
  }
   appRelaunch() async {
    context.replace(AppRoute.homeScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (_, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * math.pi,
                  child: child,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText("Logo ", weight: FontWeight.w700, size: 18.sp,),
                  SvgPicture.asset(AppImages.verificationBadge, height: 20.h, width: 20.w,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

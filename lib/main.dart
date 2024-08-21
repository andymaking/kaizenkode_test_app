import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kaizenkode_test_app/data/cache/palette.dart';

import 'data/routes/app_routers.dart';
import 'data/services/navigation.service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Make app always in portrait
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  // Change status bar theme based on theme of app
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Test App',
          theme: ThemeData(
            primaryColor: AppColors.primaryColor,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryColor,
              secondary: AppColors.secondaryColor
            ),
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r)
                ),
                elevation: 0.2
              )
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.transparent,
              scrolledUnderElevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              titleTextStyle: GoogleFonts.manrope(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textColor
              )
            )
          ),
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
        );
      }
    );
  }
}


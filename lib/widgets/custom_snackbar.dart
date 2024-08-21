import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaizenkode_test_app/data/cache/palette.dart';

void showSnackBar(String message, BuildContext context, {bool success = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: success? AppColors.primaryColor: Colors.red,
            content: Text(message),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 30.h, left: 30.w, right: 30.w),
      ));
}

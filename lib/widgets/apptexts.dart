import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaizenkode_test_app/data/cache/palette.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final TextOverflow? overflow;
  final double? size;
  final double? height;
  final int? maxLine;
  final String? family;
  final bool? isBold;
  final FontStyle fontStyle;
  final bool? isHeader;
  final bool? isSubHeader;
  final TextStyle? style;
  final Locale? locale;
  final FontWeight? weight;
  final TextDecoration? decoration;
  final TextAlign? align;

  const AppText(
      this.text,
      {Key? key,
      this.color,
      this.overflow,
      this.size,
      this.weight,
      this.align,
      this.maxLine,
      this.locale,
      this.height,
      this.family,
      this.style,
      this.isBold,
      this.isHeader,
      this.isSubHeader,
      this.decoration, this.fontStyle = FontStyle.normal
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Text(
      text,
      style: style ?? GoogleFonts.manrope(
        color: isHeader==true? AppColors.textColor: isSubHeader==true? AppColors.secondaryTextColor : color,
        fontSize: size ?? 14.sp,
        height: height,
        decoration: decoration,
        fontStyle: fontStyle,
        fontWeight: weight ?? (isBold == true ? FontWeight.w700 : isSubHeader==true? FontWeight.w500: FontWeight.w400)
      ),
      textAlign: align ?? TextAlign.start,
      selectionColor: AppColors.primaryColor.withOpacity(0.2),
      maxLines: maxLine,
    );
  }
}

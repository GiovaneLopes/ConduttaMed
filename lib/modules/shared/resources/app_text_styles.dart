import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static const TextStyle _style = TextStyle(
    fontFamily: 'Instrument Sans',
  );

  static TextStyle headNormal = TextStyle(
    fontFamily: _style.fontFamily,
    fontSize: 28.sp,
  );

  static TextStyle headBold = TextStyle(
    fontFamily: _style.fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 28.sp,
  );

  static TextStyle titleNormal = TextStyle(
    fontFamily: _style.fontFamily,
    fontSize: 20.sp,
  );

  static TextStyle titleBold = TextStyle(
    fontFamily: _style.fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 20.sp,
  );

  static TextStyle bodyNormal = TextStyle(
    fontFamily: _style.fontFamily,
    fontSize: 16.sp,
  );

  static TextStyle bodyBold = TextStyle(
    fontFamily: _style.fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 16.sp,
  );

  static TextStyle bodyNormalSmall = TextStyle(
    fontFamily: _style.fontFamily,
    fontSize: 14.sp,
  );

  static TextStyle subtitleNormal = TextStyle(
    fontFamily: _style.fontFamily,
    fontSize: 12.sp,
  );

  static TextStyle subtitleBold = TextStyle(
    fontFamily: _style.fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 12.sp,
  );

  static TextStyle subtitleNormalSmall = TextStyle(
    fontFamily: _style.fontFamily,
    fontSize: 10.sp,
  );
}

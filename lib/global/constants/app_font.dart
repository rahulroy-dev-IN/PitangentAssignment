import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pitangent_assignment/global/constants/app_color.dart';

class AppFont {
  AppFont._();

  static final _extraLarge = 160.w;
  static final _large = 38.w;
  static final _header1 = 22.sp;
  static final _medium = 18.sp;
  static final _mediumMinus = 16.sp;
  static final _small = 14.sp;
  static final _tiny = 12.sp;

  static TextStyle extraLargeTS({Color? color}) {
    return TextStyle(
      fontSize: _extraLarge,
      height: 1,
      fontWeight: FontWeight.w900,
      color: color ?? AppColor.white,
    );
  }

  static TextStyle largeTS({Color? color, String? fontFamily}) {
    return TextStyle(
      fontSize: _large,
      fontWeight: FontWeight.w600,
      height: 1,
      color: color ?? AppColor.primary,
      fontFamily: fontFamily,
    );
  }

  static TextStyle header1TS({Color? color, String? fontFamily}) {
    return TextStyle(
      fontSize: _header1,
      height: 1,
      fontWeight: FontWeight.bold,
      color: color ?? AppColor.primary,
      fontFamily: fontFamily,
    );
  }

  static TextStyle mediumTS({Color? color, String? fontFamily}) {
    return TextStyle(
      fontSize: _medium,
      fontWeight: FontWeight.w500,
      height: 1,
      color: color ?? AppColor.primary,
      fontFamily: fontFamily,
    );
  }

  static TextStyle mediumMinusTS({Color? color, String? fontFamily}) {
    return TextStyle(
      fontSize: _mediumMinus,
      fontWeight: FontWeight.w500,
      height: 1,
      color: color ?? AppColor.primary,
      fontFamily: fontFamily,
    );
  }

  static TextStyle smallTS({Color? color, String? fontFamily}) {
    return TextStyle(
      fontSize: _small,
      fontWeight: FontWeight.w400,
      height: 1,
      color: color ?? AppColor.primary,
      fontFamily: fontFamily,
    );
  }

  static TextStyle tinyTS({Color? color, String? fontFamily}) {
    return TextStyle(
      fontSize: _tiny,
      fontWeight: FontWeight.w400,
      color: color ?? AppColor.primary,
      height: 1,
      fontFamily: fontFamily,
    );
  }
}

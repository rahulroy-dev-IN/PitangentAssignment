import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pitangent_assignment/global/constants/app_color.dart';

class AppFont {
  AppFont._();

  static final _extraLarge = 160.w;

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
      fontSize: 38.w,
      fontWeight: FontWeight.w600,
      height: 1,
      color: color ?? AppColor.white,
      fontFamily: fontFamily,
    );
  }

  static TextStyle mediumTS({Color? color, String? fontFamily}) {
    return TextStyle(
      fontSize: 18.w,
      fontWeight: FontWeight.w500,
      height: 1,
      color: color ?? AppColor.white,
      fontFamily: fontFamily,
    );
  }

  static TextStyle smallTS({Color? color, String? fontFamily}) {
    return TextStyle(
      fontSize: 14.w,
      fontWeight: FontWeight.w400,
      height: 1,
      color: color ?? AppColor.white,
      fontFamily: fontFamily,
    );
  }

  static TextStyle tinyTS({Color? color, String? fontFamily}) {
    return TextStyle(
      fontSize: 12.w,
      fontWeight: FontWeight.w400,
      color: color ?? AppColor.white,
      height: 1,
      fontFamily: fontFamily,
    );
  }
}

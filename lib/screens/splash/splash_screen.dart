import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pitangent_assignment/global/constants/app_color.dart';
import 'package:pitangent_assignment/global/constants/app_font.dart';
import 'package:pitangent_assignment/global/constants/app_icons.dart';
import 'package:pitangent_assignment/global/presentation/router/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoute.onboarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Colors.black;
    return Scaffold(
      backgroundColor: themeColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo or Icon Placeholder
            Container(
              height: 100.w,
              width: 100.w,
              decoration: BoxDecoration(
                color: AppColor.primary.shade400,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppIcons.logo,
                  width: 80.w,
                  height: 80.w,
                ),
              ),
            ),
            const SizedBox(height: 24),

            AnimatedTextKit(
              totalRepeatCount: 1,
              animatedTexts: [
                TypewriterAnimatedText(
                  'RUNOVA',
                  textStyle: AppFont.largeTS(color: Colors.white),
                  speed: const Duration(milliseconds: 100),
                ),
                FadeAnimatedText(
                  'Define your own style',
                  textStyle: AppFont.mediumTS(
                    color: Colors.white,
                    fontFamily: GoogleFonts.playfairDisplay().fontFamily,
                  ).copyWith(fontStyle: FontStyle.italic),
                  duration: const Duration(seconds: 2),
                ),
              ],
              isRepeatingAnimation: false,
            ),
          ],
        ),
      ),
    );
  }
}

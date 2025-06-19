import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pitangent_assignment/global/constants/app_color.dart';
import 'package:pitangent_assignment/global/constants/app_font.dart';
import 'package:pitangent_assignment/global/constants/app_icons.dart';
import 'package:pitangent_assignment/global/constants/app_images.dart';
import 'package:pitangent_assignment/global/constants/app_strings.dart';
import 'package:pitangent_assignment/global/presentation/router/app_router.dart';
import 'package:pitangent_assignment/screens/onboarding/widget/overlappting_text.dart';
import 'package:slider_button/slider_button.dart';

class OnboradingScreen extends StatefulWidget {
  const OnboradingScreen({super.key});

  @override
  State<OnboradingScreen> createState() => _OnboradingScreenState();
}

class _OnboradingScreenState extends State<OnboradingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _verticalOffset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _verticalOffset = Tween(
      begin: 0.0,
      end: 15.h,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.5, 0.7],
            colors: [AppColor.primary.shade200, AppColor.primary.shade100],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final imageHeight = constraints.maxHeight * 0.72;
              final centerPos =
                  imageHeight / 2 - (AppFont.extraLargeTS().fontSize ?? 0);
              return Stack(
                children: [
                  AnimatedBuilder(
                    animation: _verticalOffset,
                    builder: (context, child) {
                      return Positioned(
                        left: 0,
                        right: 0,
                        top: _verticalOffset.value + centerPos,
                        bottom: constraints.maxHeight - imageHeight,
                        child: child!,
                      );
                    },
                    child: OverlappingText(),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 10.h,
                    bottom: constraints.maxHeight - imageHeight,
                    child: Image.asset(
                      AppImages.onboarding,
                      fit: BoxFit.contain,
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _verticalOffset,
                    builder: (context, child) {
                      return Positioned(
                        left: 0,
                        right: 0,
                        top: _verticalOffset.value + centerPos,
                        bottom: constraints.maxHeight - imageHeight,
                        child: child!,
                      );
                    },
                    child: OverlappingText(isTop: true),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: RichText(
                            text: TextSpan(
                              text: AppStrings.elevateYour,
                              style: AppFont.largeTS(
                                color: AppColor.white,
                                fontFamily: GoogleFonts.kanit().fontFamily,
                              ),
                              children: [
                                TextSpan(
                                  text: AppStrings.styleGame,
                                  style: AppFont.largeTS(
                                    color: AppColor.white,
                                    fontFamily: GoogleFonts.playfairDisplay()
                                        .fontFamily,
                                  ).copyWith(fontStyle: FontStyle.italic),
                                ),
                                TextSpan(text: AppStrings.withRunova),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            AppStrings.discoverTheLatest,
                            style: AppFont.tinyTS(
                              color: AppColor.white,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.w),
                          child: SliderButton(
                            action: () async {
                              Navigator.of(
                                context,
                              ).pushReplacementNamed(AppRoute.home);
                              return true;
                            },
                            vibrationFlag: false,

                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgPicture.asset(
                                  AppIcons.swipeArrow,
                                  height: 40.h,
                                ),
                                SizedBox(width: 20.w),
                              ],
                            ),
                            width: double.infinity,
                            height: 70.h,
                            radius: 70.h,
                            buttonColor: AppColor.white,
                            backgroundColor: AppColor.primary,
                            highlightedColor: AppColor.white,
                            baseColor: AppColor.primary.shade100,
                            dismissThresholds: 0.55,
                            child: Container(
                              margin: EdgeInsets.all(5.w),
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(70.h),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(width: 20.w),
                                  Text(
                                    AppStrings.getStarted,
                                    style: AppFont.smallTS(
                                      color: AppColor.primary,
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                    ).copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(width: 20.w),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

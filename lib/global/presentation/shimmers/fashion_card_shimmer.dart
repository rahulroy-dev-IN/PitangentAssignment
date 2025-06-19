import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pitangent_assignment/global/constants/app_color.dart';
import 'package:shimmer/shimmer.dart';

class FashionCardShimmer extends StatelessWidget {
  const FashionCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.primary.shade50,
      highlightColor: AppColor.white,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
      ),
    );
  }
}

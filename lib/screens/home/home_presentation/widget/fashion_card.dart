import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pitangent_assignment/global/constants/app_color.dart';
import 'package:pitangent_assignment/global/constants/app_font.dart';
import 'package:pitangent_assignment/screens/home/home_presentation/widget/curve_painter.dart';

class FashionCard extends StatelessWidget {
  final String image, title, price;
  final double rating;

  const FashionCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    color: Colors.red[100],
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomPaint(
                      size: Size(20.w, 30.h),
                      painter: CurvePainter(),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomPaint(
                          size: Size(20.w, 25.h),
                          painter: CurvePainter(),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.r),
                            ),
                          ),
                          child: Container(
                            height: 40.h,
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            constraints: BoxConstraints(minWidth: 80.w),
                            decoration: BoxDecoration(
                              color: AppColor.primary,

                              border: Border.all(
                                color: Colors.white,
                                width: 8.w,
                              ),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Center(
                              child: Text(
                                '\$$price',
                                style: AppFont.smallTS(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppFont.smallTS().copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          'Women\'s Top',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppFont.mediumMinusTS(color: AppColor.primary.shade200),
        ),
      ],
    );
  }
}

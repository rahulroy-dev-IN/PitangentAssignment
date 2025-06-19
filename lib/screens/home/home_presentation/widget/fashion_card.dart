import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pitangent_assignment/global/constants/app_color.dart';
import 'package:pitangent_assignment/global/constants/app_font.dart';
import 'package:pitangent_assignment/screens/home/home_logic/favorite_bloc.dart';
import 'package:pitangent_assignment/screens/home/home_logic/favorite_event.dart';
import 'package:pitangent_assignment/screens/home/home_logic/favorite_state.dart';
import 'package:pitangent_assignment/screens/home/home_presentation/widget/curve_painter.dart';

class FashionCard extends StatefulWidget {
  final String image, title, subtitle, price;
  final int id;
  final double rating;

  const FashionCard({
    super.key,
    required this.id,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.rating,
  });

  @override
  State<FashionCard> createState() => _FashionCardState();
}

class _FashionCardState extends State<FashionCard> {
  Color bgColor = AppColor.primary.shade50;

  @override
  void initState() {
    setState(() {
      bgColor = AppColor.getRandomLightColor();
    });
    super.initState();
  }

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
                    color: bgColor,
                    image: DecorationImage(
                      image: NetworkImage(widget.image),
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
                                '\$${widget.price}',
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
              Positioned(
                top: 10.h,
                right: 10.w,
                child: BlocBuilder<FavoriteBloc, FavoriteState>(
                  builder: (context, state) {
                    final favorites = state is FavoriteLoaded
                        ? state.favorites
                        : <int>[];
                    final isFavorite = favorites.contains(widget.id);
                    return GestureDetector(
                      onTap: () {
                        context.read<FavoriteBloc>().add(
                          isFavorite
                              ? RemoveFavorite(widget.id)
                              : AddFavorite(widget.id),
                        );
                      },
                      child: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: AppColor.primary.shade50,
                        child: Icon(
                          isFavorite
                              ? CupertinoIcons.heart_fill
                              : CupertinoIcons.heart,
                          color: isFavorite ? AppColor.red : AppColor.primary,
                          size: 24.sp,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Text(
                widget.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppFont.smallTS().copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Icon(Icons.star, color: Colors.amber, size: 16.sp),
            SizedBox(width: 5.w),
            Text(widget.rating.toString(), style: AppFont.smallTS()),
          ],
        ),

        Text(
          widget.subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppFont.mediumMinusTS(color: AppColor.primary.shade200),
        ),
      ],
    );
  }
}

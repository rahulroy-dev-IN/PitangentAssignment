import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pitangent_assignment/global/constants/app_color.dart';
import 'package:pitangent_assignment/global/constants/app_font.dart';
import 'package:pitangent_assignment/global/constants/app_strings.dart';
import 'package:pitangent_assignment/global/presentation/shimmers/fashion_card_shimmer.dart';
import 'package:pitangent_assignment/screens/home/home_presentation/widget/category_tab.dart';
import 'package:pitangent_assignment/screens/home/home_presentation/widget/fashion_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCat = 'All';
  @override
  Widget build(BuildContext context) {
    final List<String> tabs = [
      'All',
      'Women',
      'Man',
      'Shoes',
      'Sunglasses',
      'Mens Watches',
      'Womens Watches',
    ];
    log(MediaQuery.paddingOf(context).top.toString());
    return Scaffold(
      backgroundColor: AppColor.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: AppColor.white,
            expandedHeight: 130.h,
            pinned: true,
            toolbarHeight: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          backgroundImage: NetworkImage(
                            'https://i.pravatar.cc/150?img=5',
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.hello,
                              style: AppFont.smallTS(
                                color: AppColor.primary.shade200,
                              ),
                            ),
                            Text(AppStrings.alexa, style: AppFont.mediumTS()),
                          ],
                        ),
                        Spacer(),
                        CircleAvatar(
                          radius: 20.r,
                          backgroundColor: AppColor.primary.shade50,
                          child: Icon(
                            CupertinoIcons.bell,
                            color: Colors.black,
                            size: 18.r,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      AppStrings.tailoredTrends,
                      style: AppFont.header1TS(
                        fontFamily: GoogleFonts.kanit().fontFamily,
                      ),
                    ),
                    Text(
                      AppStrings.handpicked,
                      style: AppFont.mediumMinusTS(
                        fontFamily: GoogleFonts.playfairDisplay().fontFamily,
                      ).copyWith(fontStyle: FontStyle.italic, height: 1.5),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
          SliverAppBar(
            backgroundColor: AppColor.white,
            surfaceTintColor: AppColor.white,
            expandedHeight: 60 + 80.h - MediaQuery.paddingOf(context).top,
            toolbarHeight: 60 + 80.h - MediaQuery.paddingOf(context).top,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.all(20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 60,
                            child: TextField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  CupertinoIcons.search,
                                  color: AppColor.primary.shade100,
                                ),
                                hintText: AppStrings.search,
                                hintStyle: AppFont.smallTS(
                                  color: AppColor.primary.shade100,
                                ),

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: AppColor.primary.shade50,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),

                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColor.primary,

                          child: Icon(
                            CupertinoIcons.slider_horizontal_3,
                            color: Colors.white,
                            size: 24.r,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      height: 30.h,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: tabs
                              .map(
                                (tab) => CategoryTab(
                                  title: tab,
                                  selected: tab == selectedCat,
                                  onTap: () {
                                    setState(() {
                                      selectedCat = tab;
                                    });
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            sliver: SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.7,
              ),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                log('Building item $index');
                if (index > 17) {
                  return FashionCardShimmer();
                }
                return FashionCard(
                  image: 'https://i.pravatar.cc/150?img=$index',
                  title: 'Fashion Item $index',
                  price: '\$${(index + 1) * 20}',
                  rating: 4.5 + (index % 5) * 0.1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

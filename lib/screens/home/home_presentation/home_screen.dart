import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pitangent_assignment/global/constants/app_color.dart';
import 'package:pitangent_assignment/global/constants/app_font.dart';
import 'package:pitangent_assignment/global/constants/app_strings.dart';
import 'package:pitangent_assignment/global/network/modal/local/category.dart';
import 'package:pitangent_assignment/global/presentation/shimmers/fashion_card_shimmer.dart';
import 'package:pitangent_assignment/screens/home/home_logic/favorite_bloc.dart';
import 'package:pitangent_assignment/screens/home/home_logic/favorite_event.dart';
import 'package:pitangent_assignment/screens/home/home_logic/product_event.dart';
import 'package:pitangent_assignment/screens/home/home_logic/products_bloc.dart';
import 'package:pitangent_assignment/screens/home/home_logic/products_state.dart';
import 'package:pitangent_assignment/screens/home/home_presentation/widget/category_tab.dart';
import 'package:pitangent_assignment/screens/home/home_presentation/widget/fashion_card.dart';
import 'package:pitangent_assignment/screens/home/home_presentation/widget/isolate_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Category> tabs = [
    Category(name: 'All', tag: null),
    Category(name: 'Women Dressed', tag: 'womens-dresses'),
    Category(name: 'Men Shirts', tag: 'mens-shirts'),
    Category(tag: "mens-shoes", name: "Mens Shoes"),
    Category(tag: "womens-shoes", name: "Womens Shoes"),
    Category(tag: "womens-watches", name: "Womens Watches"),
    Category(tag: "sunglasses", name: "Sunglasses"),
  ];
  var sliverGridDelegateWithFixedCrossAxisCount =
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 0.7,
      );
  Category? selectedCat;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        selectedCat = tabs.first;
      });
      context.read<ProductsBloc>().add(LoadProduct());
      context.read<FavoriteBloc>().add(LoadFavorites());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  Dialog(child: IsolateDialog()),
                            );
                          },
                          child: CircleAvatar(
                            radius: 20.r,
                            backgroundImage: NetworkImage(
                              'https://i.pravatar.cc/150?img=5',
                            ),
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
                                  title: tab.name ?? '',
                                  selected: tab == selectedCat,
                                  onTap: () {
                                    setState(() {
                                      selectedCat = tab;
                                    });
                                    context.read<ProductsBloc>().add(
                                      LoadProduct(category: tab.tag),
                                    );
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
            sliver: BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state is ProductInitial || state is ProductInitialLoading) {
                  return SliverGrid.builder(
                    gridDelegate: sliverGridDelegateWithFixedCrossAxisCount,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return FashionCardShimmer();
                    },
                  );
                } else if (state is ProductLoaded) {
                  return SliverGrid.builder(
                    gridDelegate: sliverGridDelegateWithFixedCrossAxisCount,
                    itemCount: state.hasReachedMax
                        ? state.products.length
                        : state.products.length + 2,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == state.products.length) {
                        context.read<ProductsBloc>().add(
                          LoadMoreProduct(category: selectedCat?.tag),
                        );
                      }
                      if (index >= state.products.length) {
                        return FashionCardShimmer();
                      }
                      final product = state.products[index];
                      return FashionCard(
                        id: product.id ?? -2,
                        image: product.images?.firstOrNull ?? '',
                        title: product.title ?? '',
                        subtitle: product.brand ?? '',
                        price: '${product.price}',
                        rating: product.rating ?? 0.0,
                      );
                    },
                  );
                } else if (state is ProductError) {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: 100.h,
                      child: Center(
                        child: Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: AppFont.mediumTS(color: Colors.red),
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: SizedBox(height: 100.h),
          ),
        ],
      ),
    );
  }
}

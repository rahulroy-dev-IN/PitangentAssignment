import 'package:flutter/material.dart';
import 'package:pitangent_assignment/global/constants/app_color.dart';
import 'package:pitangent_assignment/screens/home/home_presentation/widget/fashion_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FashionCardShimmer extends StatelessWidget {
  const FashionCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      containersColor: AppColor.primary.shade50,
      child: FashionCard(
        subtitle: 'Subtitle',
        id: -1,
        image:
            'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
        title: 'Long Title Placeholder',
        price: '0.00',
        rating: 0.0,
      ),
    );
  }
}

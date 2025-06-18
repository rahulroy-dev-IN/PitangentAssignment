import 'package:flutter/material.dart';
import 'package:pitangent_assignment/global/constants/app_color.dart';
import 'package:pitangent_assignment/global/constants/app_font.dart';

class OverlappingText extends StatelessWidget {
  final bool isTop;
  const OverlappingText({super.key, this.isTop = false});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'R',
        style: AppFont.extraLargeTS(
          color: isTop ? Colors.transparent : AppColor.white,
        ),
        children: [
          TextSpan(
            text: 'U',
            style: AppFont.extraLargeTS(color: AppColor.white),
          ),
          TextSpan(
            text: 'N\n',
            // style: AppFont.extraLargeTS(
            //   color: isTop ? Colors.transparent : AppColor.white,
            // ),
          ),
          TextSpan(
            text: 'O',
            style: AppFont.extraLargeTS(
              color: isTop ? Colors.transparent : AppColor.white,
            ),
          ),
          TextSpan(
            text: 'V',
            style: AppFont.extraLargeTS(color: AppColor.white),
          ),
          TextSpan(
            text: 'A',
            style: AppFont.extraLargeTS(
              color: isTop ? Colors.transparent : AppColor.white,
            ),
          ),
        ],
      ),

      textAlign: TextAlign.center,
    );
  }
}

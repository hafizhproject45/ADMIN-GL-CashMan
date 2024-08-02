import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';

class AnalysisField extends StatelessWidget {
  final String title;
  final String value;
  final IconData iconz;
  final double padding;
  final String route;

  const AnalysisField({
    super.key,
    required this.title,
    required this.value,
    required this.iconz,
    this.padding = 0,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: GestureDetector(
        onTap: () => Get.toNamed(route),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  iconz,
                  color: AppColor.primary,
                  size: 20,
                ),
                const SizedBox(width: 5),
                Text(
                  value,
                  style: AppTextStyle.bodyBold,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: AppTextStyle.mediumThin,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

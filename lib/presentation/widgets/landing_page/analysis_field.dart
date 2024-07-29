import 'package:flutter/material.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';

class AnalysisField extends StatelessWidget {
  final String title;
  final String value;
  final IconData iconz;
  final double padding;

  const AnalysisField({
    super.key,
    required this.title,
    required this.value,
    required this.iconz,
    this.padding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
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
    );
  }
}

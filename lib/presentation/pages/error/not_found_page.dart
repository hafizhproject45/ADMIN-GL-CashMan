import 'package:flutter/material.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '404',
              style: TextStyle(fontSize: 32, color: AppColor.textHeading),
            ),
            Text('Page not found', style: AppTextStyle.heading),
          ],
        ),
      ),
    );
  }
}

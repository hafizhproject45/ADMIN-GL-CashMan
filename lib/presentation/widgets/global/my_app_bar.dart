import 'package:flutter/material.dart';

import '../../../core/utils/text_style.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? action;

  const MyAppBar({
    super.key,
    required this.title,
    this.leading,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppBar(
          title: Text(
            title,
            style: AppTextStyle.subHeadingPrimaryBold,
          ),
          backgroundColor: Colors.white,
          leading: leading,
          actions: action,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

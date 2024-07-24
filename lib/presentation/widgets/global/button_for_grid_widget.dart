import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../core/utils/colors.dart';

class ButtonForGridWidget extends StatelessWidget {
  const ButtonForGridWidget({
    required this.name,
    required this.route,
    required this.iconz,
    super.key,
  });

  final String name;
  final String route;
  final IconData iconz;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Get.toNamed(route);
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconz, size: 40, color: AppColor.primary),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(fontSize: 16, color: AppColor.primary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

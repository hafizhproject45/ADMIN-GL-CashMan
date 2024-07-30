import '../../../core/utils/text_style.dart';
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
    return InkWell(
      onTap: () => Get.toNamed(route),
      child: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all(color: AppColor.textSmall),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(
                iconz,
                color: AppColor.primary,
                size: 25,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 90,
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: AppTextStyle.medium,
            ),
          )
        ],
      ),
    );
  }
}

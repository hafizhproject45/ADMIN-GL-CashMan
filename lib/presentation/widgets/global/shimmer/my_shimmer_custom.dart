// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utils/colors.dart';

part 'my_shimmer_infinity.dart';

class ShimmerCustomWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;

  const ShimmerCustomWidget({
    Key? key,
    this.width = 0,
    this.height = 0,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 1000),
      baseColor: AppColor.shimmer,
      highlightColor: AppColor.shimmerHighlight,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 5),
          color: AppColor.shimmer,
        ),
      ),
    );
  }
}

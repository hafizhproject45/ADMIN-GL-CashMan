// ignore_for_file: use_super_parameters

part of 'my_shimmer_custom.dart';

class ShimmerInfinityWidget extends StatelessWidget {
  final double? width;
  final double? height;

  const ShimmerInfinityWidget({
    Key? key,
    this.width = double.infinity,
    this.height = 60,
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
          borderRadius: BorderRadius.circular(5),
          color: AppColor.shimmer,
        ),
      ),
    );
  }
}

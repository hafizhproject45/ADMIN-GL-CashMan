import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../core/utils/colors.dart';

class MyButtonWidget extends StatelessWidget {
  final String? label;
  final double width;
  final double height;
  final double borderRadius;
  final Color buttonColor;
  final Color textColor;
  final IconData? iconz;
  final VoidCallback onPressed;
  final bool? isLoading;
  final Widget? child;

  const MyButtonWidget({
    this.label,
    this.width = 300,
    this.height = 50,
    this.borderRadius = 5,
    this.buttonColor = AppColor.primary,
    this.textColor = AppColor.white,
    required this.onPressed,
    this.iconz,
    super.key,
    this.isLoading = false,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
      ),
      child: isLoading!
          ? const SpinKitThreeBounce(
              color: Colors.white,
              size: 20,
            )
          : child ??
              Text(
                label!,
                style: TextStyle(color: textColor),
              ),
    );
  }
}

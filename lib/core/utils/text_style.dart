import 'package:flutter/material.dart';

import 'colors.dart';

class AppTextStyle {
  //? HEADING
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800, // BOLD
    color: AppColor.textHeading,
  );
  static const TextStyle headingPrimary = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800, // BOLD
    color: AppColor.primary,
  );
  static const TextStyle headingAccent = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800, // BOLD
    color: AppColor.primary,
  );
  static const TextStyle headingWhite = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800, // BOLD
    color: AppColor.white,
  );

  //? SUB HEADING
  static const TextStyle subHeading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600, // MEDIUM
    color: AppColor.textHeading,
  );
  static const TextStyle subHeadingPrimary = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600, // MEDIUM
    color: AppColor.primary,
  );
  static const TextStyle subHeadingPrimaryBold = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800, // MEDIUM
    color: AppColor.primary,
  );
  static const TextStyle subHeadingAccent = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600, // MEDIUM
    color: AppColor.primary,
  );
  static const TextStyle subHeadingWhite = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600, // MEDIUM
    color: Colors.white,
  );

  //? BODY
  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600, // MEDIUM
  );
  static const TextStyle bodyBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w800, // BOLD
  );
  static const TextStyle bodyBoldPrimary = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w800, // BOLD
    color: AppColor.primary,
  );
  static const TextStyle bodyBoldAccent = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w800, // BOLD
    color: AppColor.primary,
  );
  static const TextStyle bodyRed = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600, // MEDIUM
      color: Colors.red);
  static const TextStyle bodyBoldWhite = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w800, // MEDIUM
    color: Colors.white,
  );
  static const TextStyle bodySosmed = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500, // MEDIUM
    color: Colors.white,
  );
  static const TextStyle bodyWhite = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600, // MEDIUM
    color: Colors.white,
  );
  static const TextStyle bodyThin = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500, // MEDIUM
    color: AppColor.textSmall,
  );
  static const TextStyle bodyThinWhite = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400, // MEDIUM
    color: AppColor.white,
  );

  //? MEDIUM
  static const TextStyle medium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400, // REGULAR
  );
  static const TextStyle mediumBold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700, // SEMI BOLD
  );
  static const TextStyle mediumBoldPrimary = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700, // SEMI BOLD
    color: AppColor.primary,
  );
  static const TextStyle mediumBoldAccent = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700, // SEMI BOLD
    color: AppColor.primary,
  );
  static const TextStyle mediumPrimary = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400, // REGULAR
    color: AppColor.primary,
  );
  static const TextStyle mediumAccent = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400, // REGULAR
    color: AppColor.primary,
  );
  static const TextStyle mediumWhite = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400, // REGULAR
    color: AppColor.white,
  );
  static const TextStyle mediumThin = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400, // REGULAR
    color: AppColor.textSmall,
  );

  //? SMALL
  static const TextStyle smallBold = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w800, // BOLD
  );
  static const TextStyle smallBoldPrimary = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w800, // BOLD
    color: AppColor.primary,
  );
  static const TextStyle small = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500, //REGULAR
    color: AppColor.textHeading,
  );
  static const TextStyle smallThin = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400, //REGULAR
    color: AppColor.textSmall,
  );
  static const TextStyle smallPrimary = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400, //REGULAR
    color: AppColor.primary,
  );
}

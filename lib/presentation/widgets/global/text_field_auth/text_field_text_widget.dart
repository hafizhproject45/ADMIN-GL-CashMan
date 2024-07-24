// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/text_style.dart';

class MyTextFieldText extends StatefulWidget {
  final String name;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? type;
  final TextStyle? nameStyle;

  final double? width;
  final IconData? iconz;
  final Color? iconColor;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;

  const MyTextFieldText({
    super.key,
    required this.name,
    this.focusNode,
    this.textInputAction,
    this.nameStyle,
    this.iconz,
    this.iconColor,
    this.controller,
    this.validator,
    this.width = 300,
    this.type = TextInputType.text,
  });

  @override
  _MyTextFieldTextState createState() => _MyTextFieldTextState();
}

class _MyTextFieldTextState extends State<MyTextFieldText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      width: widget.width,
      child: TextFormField(
        validator: widget.validator,
        cursorColor: AppColor.white,
        controller: widget.controller,
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction,
        keyboardType: widget.type,
        style: widget.nameStyle ?? AppTextStyle.bodyThinWhite,
        decoration: InputDecoration(
          errorStyle: const TextStyle(color: Colors.red),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          prefixIcon: Icon(
            widget.iconz,
            color: widget.iconColor ?? AppColor.white,
          ),
          label: Text(
            widget.name,
            style: widget.nameStyle ?? AppTextStyle.bodyThinWhite,
          ),
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }
}

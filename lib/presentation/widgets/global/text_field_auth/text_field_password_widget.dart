// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/text_style.dart';

class MyTextFieldPassword extends StatefulWidget {
  final String? name;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final IconData? iconz;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final void Function(String? value)? onFieldSubmitted;

  const MyTextFieldPassword({
    super.key,
    this.name,
    this.focusNode,
    this.textInputAction,
    this.iconz = Icons.lock,
    this.controller,
    this.validator,
    this.onFieldSubmitted,
  });

  @override
  State<MyTextFieldPassword> createState() => _TextFieldPasswordState();
}

class _TextFieldPasswordState extends State<MyTextFieldPassword> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      width: 300,
      child: TextFormField(
        onFieldSubmitted: widget.onFieldSubmitted,
        cursorColor: AppColor.white,
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction,
        validator: widget.validator,
        controller: widget.controller,
        enableInteractiveSelection: true,
        keyboardType: TextInputType.visiblePassword,
        obscureText: _obscureText,
        style: AppTextStyle.bodyThinWhite,
        decoration: InputDecoration(
          errorStyle: const TextStyle(color: Colors.red),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          prefixIcon: Icon(
            widget.iconz,
            color: AppColor.white,
          ),
          label: Text(
            widget.name ?? 'Kata sandi',
            style: AppTextStyle.bodyThinWhite,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: AppColor.white,
            ),
          ),
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          // fillColor: AppColor.textfield,
          // filled: true,
        ),
      ),
    );
  }
}

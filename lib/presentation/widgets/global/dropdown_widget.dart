import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';

class DropDownWidget extends StatefulWidget {
  final String name;
  final List<String> items;
  final Function(String? value)? onSaved;
  final Function(String? value)? onChange;

  const DropDownWidget({
    super.key,
    required this.name,
    required this.items,
    this.onSaved,
    this.onChange,
  });

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

String? selectedValue;

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: DropdownButtonFormField2<String>(
        isExpanded: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: AppColor.primary)),
        ),
        hint: Text(
          widget.name,
          style: AppTextStyle.mediumThin,
        ),
        items: widget.items
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: widget.onChange,
        onSaved: widget.onSaved,
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.only(right: 8),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down,
            color: AppColor.primary,
          ),
          iconSize: 24,
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}

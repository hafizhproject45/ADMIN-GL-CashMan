import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/text_style.dart';

class TextFieldNormalWidget extends StatefulWidget {
  final String name;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final bool? isDate;
  final TextInputType? type;
  final TextInputAction? textInputAction;
  final double? width;
  final FocusNode? focusNode;
  final TextStyle? nameStyle;
  final IconData? iconz;
  final Color? iconColor;

  const TextFieldNormalWidget({
    super.key,
    required this.name,
    this.controller,
    this.validator,
    this.isDate = false,
    this.type = TextInputType.text,
    this.textInputAction,
    this.width = 300,
    this.focusNode,
    this.nameStyle,
    this.iconz,
    this.iconColor,
  });

  @override
  State<TextFieldNormalWidget> createState() => _TextFieldNormalWidgetState();
}

class _TextFieldNormalWidgetState extends State<TextFieldNormalWidget> {
  DateTime? _selectedDate;

  Future<void> _selectMonthYear(BuildContext context) async {
    final now = DateTime.now();
    DateTime initialDate = _selectedDate ?? DateTime(now.year, now.month);

    int selectedYear = initialDate.year;
    int selectedMonth = initialDate.month;
    List<String> months = [
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember"
    ];

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              titlePadding: const EdgeInsets.only(bottom: 30, top: 20),
              title: const Text(
                'Select Month and Year',
                style: AppTextStyle.subHeading,
                textAlign: TextAlign.center,
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Month',
                        style: AppTextStyle.subHeadingPrimary,
                      ),
                      const SizedBox(height: 10),
                      DropdownButton<int>(
                        dropdownColor: Colors.white,
                        value: selectedMonth,
                        items: List.generate(12, (index) {
                          return DropdownMenuItem(
                            value: index + 1,
                            child: Text(months[index]),
                          );
                        }),
                        onChanged: (value) {
                          setState(() {
                            selectedMonth = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Year',
                        style: AppTextStyle.subHeadingPrimary,
                      ),
                      const SizedBox(height: 10),
                      DropdownButton<int>(
                        dropdownColor: Colors.white,
                        value: selectedYear,
                        items: List.generate(7, (index) {
                          int year = now.year -
                              1 +
                              index; // Adjust this to control the range
                          return DropdownMenuItem(
                            value: year,
                            child: Text(year.toString()),
                          );
                        }),
                        onChanged: (value) {
                          setState(() {
                            selectedYear = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedDate = DateTime(selectedYear, selectedMonth);
                      if (widget.controller != null) {
                        widget.controller!.text =
                            "${months[_selectedDate!.month - 1]}-${_selectedDate!.year}";
                      }
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
              backgroundColor: Colors.white,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        enableInteractiveSelection: !widget.isDate!,
        textInputAction: widget.isDate! ? null : widget.textInputAction,
        keyboardType: widget.isDate! ? null : widget.type,
        readOnly: widget.isDate!,
        focusNode: widget.focusNode,
        onTap: widget.isDate!
            ? () {
                _selectMonthYear(context);
              }
            : null,
        decoration: InputDecoration(
          errorStyle: const TextStyle(color: Colors.red),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          prefixIcon: Icon(
            widget.iconz,
            color: widget.iconColor ?? AppColor.white,
          ),
          hintText: widget.name,
          hintStyle: widget.nameStyle ?? AppTextStyle.bodyThinWhite,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }
}

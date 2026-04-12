import 'package:currency_convertor_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

import '../presentation.dart';

class CurrencyConvertorWidget extends StatelessWidget {
  const CurrencyConvertorWidget({
    super.key,
    required this.imageUrl,
    required this.baseItems,
    required this.qoutesItem,
    this.baseValue,
    this.qoutesValue,
    this.hint,
    this.onQoutesChanged,
  });

  final String imageUrl;
  final List<DropdownMenuItem<dynamic>> baseItems;
  final List<DropdownMenuItem<dynamic>> qoutesItem;
  final dynamic baseValue;
  final dynamic qoutesValue;
  final Widget? hint;
  final void Function(dynamic)? onQoutesChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      spacing: 16,
      children: [
        Text(
          "Amount",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.grey98,
          ),
        ),
        CountryCodeWithImageWidget(
          imageUrl: imageUrl,
          items: baseItems,
          controller: TextEditingController(),
          value: baseValue,
        ),
        Divider(),
        CountryCodeWithImageWidget(
          imageUrl: imageUrl,
          items: qoutesItem,
          controller: TextEditingController(),
          value: qoutesValue,
          hint: hint,
          onChanged: onQoutesChanged,
        ),
      ],
    );
  }
}

import 'package:currency_convertor_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

import '../presentation.dart';

class CurrencyConvertorWidget extends StatelessWidget {
  const CurrencyConvertorWidget({
    super.key,
    required this.imageUrl,
    required this.items,
    this.baseValue,
    this.qoutesValue,
    this.hint,
    this.onQoutesChanged,
    this.onBaseChanged,
  });

  final String imageUrl;
  final List<DropdownMenuItem<dynamic>> items;
  final dynamic baseValue;
  final dynamic qoutesValue;
  final Widget? hint;
  final void Function(dynamic)? onQoutesChanged;
  final void Function(dynamic)? onBaseChanged;

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
          items: items,
          controller: TextEditingController(),
          value: baseValue,
          onChanged: onBaseChanged,
        ),
        Divider(),
        CountryCodeWithImageWidget(
          imageUrl: imageUrl,
          items: items,
          controller: TextEditingController(),
          value: qoutesValue,
          onChanged: onQoutesChanged,
        ),
      ],
    );
  }
}

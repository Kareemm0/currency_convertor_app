import 'package:currency_convertor_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

import '../presentation.dart';

class CurrencyConvertorWidget extends StatelessWidget {
  const CurrencyConvertorWidget({
    super.key,
    required this.items,
    this.baseValue,
    this.qoutesValue,
    this.hint,
    this.onQoutesChanged,
    this.onBaseChanged,
    required this.baseImageUrl,
    required this.qoutesImageUrl,
    required this.qoutesController,
    this.onAmountChanged,
  });

  final String baseImageUrl;
  final String qoutesImageUrl;
  final List<DropdownMenuItem<dynamic>> items;
  final dynamic baseValue;
  final dynamic qoutesValue;
  final Widget? hint;
  final void Function(dynamic)? onQoutesChanged;
  final void Function(dynamic)? onBaseChanged;
  final TextEditingController qoutesController;
  final void Function(String)? onAmountChanged;

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
          imageUrl: baseImageUrl,
          items: items,
          controller: qoutesController,
          value: baseValue,
          onChanged: onBaseChanged,
          onAmountChanged: onAmountChanged,
          isShown: true,
        ),
        Divider(),
        CountryCodeWithImageWidget(
          imageUrl: qoutesImageUrl,
          items: items,
          value: qoutesValue,
          onChanged: onQoutesChanged,
        ),
      ],
    );
  }
}

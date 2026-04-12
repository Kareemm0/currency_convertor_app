import 'package:currency_convertor_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

import '../presentation.dart';

class CurrencyConvertorWidget extends StatelessWidget {
  const CurrencyConvertorWidget({
    super.key,
    required this.imageUrl,
    required this.baseItems,
    required this.qoutesItem,
  });

  final String imageUrl;
  final List<DropdownMenuItem<dynamic>> baseItems;
  final List<DropdownMenuItem<dynamic>> qoutesItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
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
        ),
        Divider(),
        CountryCodeWithImageWidget(
          imageUrl: imageUrl,
          items: qoutesItem,
          controller: TextEditingController(),
        ),
      ],
    );
  }
}

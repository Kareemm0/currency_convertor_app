import 'package:currency_convertor_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

class HistoricalListViewItem extends StatelessWidget {
  const HistoricalListViewItem({
    super.key,
    required this.base,
    required this.qoutes,
    required this.rates,
  });
  final String base;
  final String qoutes;
  final double rates;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        base,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: AppColors.grey98,
        ),
      ),
      trailing: Text(
        qoutes,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
      ),
      subtitle: Text(
        "Amount is $rates",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: AppColors.grey98,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../presentation.dart';

class HistoricalScreen extends StatelessWidget {
  const HistoricalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            "Historical Countries",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: AppColors.textColor,
            ),
          ),
          BlocBuilder<CurrencyCodeCubit, CurrencyCodeState>(
            buildWhen: (previous, current) =>
                current is GetHistoricalDataSuccessState,
            builder: (_, state) {
              return switch (state) {
                GetHistoricalDataSuccessState(
                  currencyConvertorModel: final currencyConvertorModel,
                  histroicalData: final histroicalData,
                ) =>
                  ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (ct, index) {
                      return HistoricalListViewItem(
                        base: currencyConvertorModel[index].base ?? "",
                        qoutes: currencyConvertorModel[index].quote ?? "",
                        rates: currencyConvertorModel[index].rate ?? 0.0,
                      );
                    },
                    separatorBuilder: (_, index) {
                      return Divider();
                    },
                    itemCount: histroicalData.length,
                  ),
                _ => SizedBox.shrink(),
              };
            },
          ),
        ],
      ),
    );
  }
}

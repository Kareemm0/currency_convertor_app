import 'package:currency_convertor_app/injection_container.dart';
import 'package:currency_convertor_app/presentation/cubit/currency_code_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../presentation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CurrencyCodeCubit(repo: getIt())..getRates(),
        child: BlocBuilder<CurrencyCodeCubit, CurrencyCodeState>(
          builder: (ctx, state) {
            return switch (state) {
              CurrencyCodeLoadingState() => Center(
                child: CircularProgressIndicator(),
              ),
              CurrencyCodeFailurState(msg: final msg) => Center(
                child: Text(msg),
              ),
              CurrencyCodeSuccsseState(
                currencyConvertorModel: final currencyConvertorModel,
              ) =>
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 40,
                  ),
                  child: Column(
                    spacing: 16,
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        currencyConvertorModel.first.base ??
                            "Currency Convertor ",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.containerColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: CurrencyConvertorWidget(
                          imageUrl: '',
                          baseItems: [],
                          qoutesItem: [],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.textColor,
                          minimumSize: Size(double.maxFinite, 50),
                        ),
                        child: Text(
                          "Convert".toUpperCase(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              _ => SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}

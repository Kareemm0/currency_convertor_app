import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/core.dart';
import '../presentation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? qoutesValue;
  String? baseValue;
  bool isShwoen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CurrencyCodeCubit, CurrencyCodeState>(
        listener: (context, state) {
          if (state is ConvertResultSuccessState) {
            isShwoen = true;
          }
        },
        builder: (ctx, state) {
          return switch (state) {
            CurrencyCodeLoadingState() => Center(
              child: CircularProgressIndicator(),
            ),
            CurrencyCodeFailurState(msg: final msg) => Center(child: Text(msg)),
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
                        items: currencyConvertorModel
                            .map(
                              (e) => DropdownMenuItem(
                                value: e.quote,
                                child: Text(e.quote ?? ""),
                              ),
                            )
                            .toList(),
                        onQoutesChanged: (val) {
                          setState(() {
                            qoutesValue = val;
                          });
                        },
                        onBaseChanged: (val) {
                          setState(() {
                            baseValue = val;
                          });
                        },
                        baseValue:
                            baseValue ?? currencyConvertorModel.first.quote,
                        qoutesValue:
                            qoutesValue ?? currencyConvertorModel.first.quote,
                      ),
                    ),

                    if (state is ConvertResultSuccessState)
                      Text(
                        "1 $baseValue = ${state.rateValue} $qoutesValue",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textColor,
                        ),
                      ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CurrencyCodeCubit>().getConvertResult(
                          inputs: RatesInputs(
                            base: baseValue ?? "",
                            qoutes: qoutesValue ?? "",
                          ),
                        );
                      },
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
    );
  }
}

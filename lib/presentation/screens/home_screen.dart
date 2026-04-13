import 'package:currency_convertor_app/presentation/cubit/flags/flags_state.dart';
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
  String? baseFlag;
  String? qoutesFlag;
  double amount = 1;
  TextEditingController amountController = TextEditingController();

  void _updateFlags(BuildContext context) {
    final base = (baseFlag ?? baseValue)?.substring(0, 2).toLowerCase() ?? "";
    final quote =
        (qoutesFlag ?? qoutesFlag)?.substring(0, 2).toLowerCase() ?? "";

    context.read<FlagsCubit>().getFlags(baseFlags: base, qoutesFlag: quote);
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CurrencyCodeCubit, CurrencyCodeState>(
        listener: (context, state) {
          if (state is CurrencyCodeSuccsseState && baseValue == null) {
            baseValue = state.currencyConvertorModel.first.quote;
            qoutesValue = state.currencyConvertorModel.first.quote;

            baseFlag = baseValue;
            qoutesFlag = qoutesValue;

            _updateFlags(context);
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
                      child: BlocBuilder<FlagsCubit, FlagsState>(
                        builder: (context, state) {
                          return switch (state) {
                            GetFlagsSuccessState() => CurrencyConvertorWidget(
                              baseImageUrl: state.baseCode,
                              onAmountChanged: (val) {
                                setState(() {
                                  amount = double.tryParse(val) ?? 1;
                                });
                              },
                              qoutesController: amountController,
                              qoutesImageUrl: state.qoutesCode,
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
                                  qoutesFlag = val;
                                });
                                _updateFlags(context);
                              },
                              onBaseChanged: (val) {
                                setState(() {
                                  baseValue = val;
                                  baseFlag = val;
                                });
                                _updateFlags(context);
                              },
                              baseValue: baseValue,
                              qoutesValue: qoutesValue,
                            ),
                            _ => SizedBox.shrink(),
                          };
                        },
                      ),
                    ),

                    if (state is ConvertResultSuccessState)
                      Text(
                        "$amount $baseValue = ${amount * state.rateValue} $qoutesValue",
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

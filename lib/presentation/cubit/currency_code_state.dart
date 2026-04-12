part of "currency_code_cubit.dart";

abstract class CurrencyCodeState {}

final class CurrencyCodeInitialState extends CurrencyCodeState {}

final class CurrencyCodeLoadingState extends CurrencyCodeState {}

final class CurrencyCodeSuccsseState extends CurrencyCodeState {
  final List<CurrencyConvertorModel> currencyConvertorModel;

  CurrencyCodeSuccsseState({required this.currencyConvertorModel});
}

final class CurrencyCodeFailurState extends CurrencyCodeState {
  final String msg;

  CurrencyCodeFailurState({required this.msg});
}

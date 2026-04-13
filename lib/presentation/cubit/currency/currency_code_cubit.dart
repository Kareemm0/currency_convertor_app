import 'package:currency_convertor_app/domian/domian.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';

part 'currency_code_state.dart';

class CurrencyCodeCubit extends Cubit<CurrencyCodeState> {
  CurrencyCodeCubit({required CurrencyCodeRepo repo})
    : _repo = repo,
      super(CurrencyCodeInitialState());

  final CurrencyCodeRepo _repo;

  Future<void> getRates() async {
    emit(CurrencyCodeLoadingState());
    final result = await _repo.getCurrency();
    final localData = await _repo.getLocalRates();

    if (localData.isNotEmpty) {
      emit(CurrencyCodeSuccsseState(currencyConvertorModel: localData));
      return;
    }

    result.fold(
      (failure) {
        emit(CurrencyCodeFailurState(msg: failure.msg));
      },
      (success) async {
        emit(CurrencyCodeSuccsseState(currencyConvertorModel: success));
      },
    );
  }

  Future<void> getConvertResult({RatesInputs? inputs}) async {
    switch (state) {
      case CurrencyCodeSuccsseState(:final currencyConvertorModel):
        final result = await _repo.getCurrency(inputs: inputs);
        result.fold(
          (failure) {
            emit(
              ConvertResultFailureState(
                currencyConvertorModel: currencyConvertorModel,
              ),
            );
          },
          (success) async {
            emit(
              ConvertResultSuccessState(
                currencyConvertorModel: currencyConvertorModel,
                rateValue: success.first.rate ?? 0,
              ),
            );
          },
        );
    }
  }

  Future<void> historicalData({
    required String base,
    required String qutes,
  }) async {
    switch (state) {
      case (CurrencyCodeSuccsseState(:final currencyConvertorModel)):
        final to = DateTime.now();
        final from = to.subtract(const Duration(days: 7));

        final result = await _repo.getCurrency(
          inputs: RatesInputs(
            to: to.toIso8601String().split("T").first,
            from: from.toIso8601String().split("T").first,
            base: base,
            qoutes: qutes,
          ),
        );

        result.fold(
          (failure) {
            emit(
              GetHistoricalDataFailureState(
                currencyConvertorModel: currencyConvertorModel,
              ),
            );
          },
          (success) {
            emit(
              GetHistoricalDataSuccessState(
                currencyConvertorModel: currencyConvertorModel,
                histroicalData: success,
              ),
            );
          },
        );
    }
  }
}

import 'package:currency_convertor_app/domian/domian.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';

part 'currency_code_state.dart';

class CurrencyCodeCubit extends Cubit<CurrencyCodeState> {
  CurrencyCodeCubit({required CurrencyCodeRepo repo})
    : _repo = repo,
      super(CurrencyCodeInitialState());

  final CurrencyCodeRepo _repo;

  Future<void> getRates({RatesInputs? inputs}) async {
    emit(CurrencyCodeLoadingState());
    final result = await _repo.getCurrency(inputs: inputs);

    result.fold(
      (failure) {
        emit(CurrencyCodeFailurState(msg: failure.msg));
      },
      (success) {
        emit(CurrencyCodeSuccsseState(currencyConvertorModel: success));
      },
    );
  }
}

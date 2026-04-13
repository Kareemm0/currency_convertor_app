import 'package:currency_convertor_app/domian/domian.dart';
import 'package:currency_convertor_app/presentation/cubit/flags/flags_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlagsCubit extends Cubit<FlagsState> {
  final FlagsRepo _repo;
  FlagsCubit({required FlagsRepo repo}) : _repo = repo, super(FlagsInitState());

  Future<void> getFlags({required String code}) async {
    final result = await _repo.getFlags(code: code);

    result.fold(
      (failure) {
        emit(GetFlagsFailureState());
      },
      (success) {
        emit(GetFlagsSuccessState());
      },
    );
  }
}

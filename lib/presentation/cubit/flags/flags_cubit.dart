import 'package:currency_convertor_app/domian/domian.dart';
import 'package:currency_convertor_app/presentation/cubit/flags/flags_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlagsCubit extends Cubit<FlagsState> {
  final FlagsRepo _repo;
  FlagsCubit({required FlagsRepo repo}) : _repo = repo, super(FlagsInitState());

  Future<void> getFlags({
    required String qoutesFlag,
    required String baseFlags,
  }) async {
    final qoutesResult = await _repo.getFlags(code: qoutesFlag);
    final baseResult = await _repo.getFlags(code: baseFlags);

    qoutesResult.fold(
      (failure) {
        emit(GetFlagsFailureState());
      },
      (qoutesSuccess) {
        baseResult.fold(
          (failure) {
            emit(GetFlagsFailureState());
          },
          (baseSuccess) {
            emit(
              GetFlagsSuccessState(
                qoutesCode: qoutesSuccess,
                baseCode: baseSuccess,
              ),
            );
          },
        );
      },
    );
  }
}

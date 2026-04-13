import 'package:currency_convertor_app/core/core.dart';
import 'package:currency_convertor_app/domian/domian.dart';
import 'package:currency_convertor_app/presentation/cubit/flags/flags_cubit.dart';
import 'package:currency_convertor_app/presentation/cubit/flags/flags_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> pumpEventQueue() => Future<void>.delayed(Duration.zero);

class FakeFlagsRepo implements FlagsRepo {
  FakeFlagsRepo({required this.responsesByCode});

  final Map<String, Either<Failure, String>> responsesByCode;

  @override
  Future<Either<Failure, String>> getFlags({required String code}) async {
    return responsesByCode[code] ??
        const Left(ServerFailure(msg: 'missing fake response'));
  }
}

void main() {
  group('FlagsCubit', () {
    test('emits success when both flag requests succeed', () async {
      final repo = FakeFlagsRepo(
        responsesByCode: const {
          'eg': Right('egypt.svg'),
          'us': Right('united_states.svg'),
        },
      );
      final cubit = FlagsCubit(repo: repo);
      final emittedStates = <FlagsState>[];
      final subscription = cubit.stream.listen(emittedStates.add);

      await cubit.getFlags(qoutesFlag: 'eg', baseFlags: 'us');
      await pumpEventQueue();

      expect(emittedStates, hasLength(1));
      expect(emittedStates.first, isA<GetFlagsSuccessState>());
      final state = emittedStates.first as GetFlagsSuccessState;
      expect(state.qoutesCode, 'egypt.svg');
      expect(state.baseCode, 'united_states.svg');

      await subscription.cancel();
      await cubit.close();
    });

    test('emits failure when the quote flag request fails', () async {
      final repo = FakeFlagsRepo(
        responsesByCode: const {
          'eg': Left(ServerFailure(msg: 'failed')),
          'us': Right('united_states.svg'),
        },
      );
      final cubit = FlagsCubit(repo: repo);
      final emittedStates = <FlagsState>[];
      final subscription = cubit.stream.listen(emittedStates.add);

      await cubit.getFlags(qoutesFlag: 'eg', baseFlags: 'us');
      await pumpEventQueue();

      expect(emittedStates, hasLength(1));
      expect(emittedStates.first, isA<GetFlagsFailureState>());

      await subscription.cancel();
      await cubit.close();
    });

    test('emits failure when the base flag request fails', () async {
      final repo = FakeFlagsRepo(
        responsesByCode: const {
          'eg': Right('egypt.svg'),
          'us': Left(ServerFailure(msg: 'failed')),
        },
      );
      final cubit = FlagsCubit(repo: repo);
      final emittedStates = <FlagsState>[];
      final subscription = cubit.stream.listen(emittedStates.add);

      await cubit.getFlags(qoutesFlag: 'eg', baseFlags: 'us');
      await pumpEventQueue();

      expect(emittedStates, hasLength(1));
      expect(emittedStates.first, isA<GetFlagsFailureState>());

      await subscription.cancel();
      await cubit.close();
    });
  });
}

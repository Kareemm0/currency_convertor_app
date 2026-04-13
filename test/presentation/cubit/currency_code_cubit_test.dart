import 'package:currency_convertor_app/core/core.dart';
import 'package:currency_convertor_app/domian/domian.dart';
import 'package:currency_convertor_app/presentation/cubit/currency/currency_code_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> pumpEventQueue() => Future<void>.delayed(Duration.zero);

class FakeCurrencyCodeRepo implements CurrencyCodeRepo {
  Either<Failure, List<CurrencyConvertorModel>> getCurrencyResult;
  List<CurrencyConvertorModel> localRates;
  RatesInputs? lastInputs;

  FakeCurrencyCodeRepo({
    this.getCurrencyResult = const Right([]),
    this.localRates = const [],
  });

  @override
  Future<Either<Failure, List<CurrencyConvertorModel>>> getCurrency({
    RatesInputs? inputs,
  }) async {
    lastInputs = inputs;
    return getCurrencyResult;
  }

  @override
  Future<List<CurrencyConvertorModel>> getLocalRates() async => localRates;
}

void main() {
  group('CurrencyCodeCubit', () {
    test('emits loading then success with local rates when cache is available', () async {
      final cachedRates = [
        const CurrencyConvertorModel(
          date: '2026-04-13',
          base: 'USD',
          quote: 'EGP',
          rate: 50.75,
        ),
      ];
      final repo = FakeCurrencyCodeRepo(
        getCurrencyResult: Right([
          const CurrencyConvertorModel(
            date: '2026-04-13',
            base: 'USD',
            quote: 'EUR',
            rate: 0.88,
          ),
        ]),
        localRates: cachedRates,
      );
      final cubit = CurrencyCodeCubit(repo: repo);
      final emittedStates = <CurrencyCodeState>[];
      final subscription = cubit.stream.listen(emittedStates.add);

      await cubit.getRates();
      await pumpEventQueue();

      expect(emittedStates, hasLength(2));
      expect(emittedStates[0], isA<CurrencyCodeLoadingState>());
      expect(emittedStates[1], isA<CurrencyCodeSuccsseState>());
      expect(
        (emittedStates[1] as CurrencyCodeSuccsseState).currencyConvertorModel,
        equals(cachedRates),
      );

      await subscription.cancel();
      await cubit.close();
    });

    test('emits loading then failure when remote request fails and cache is empty', () async {
      final repo = FakeCurrencyCodeRepo(
        getCurrencyResult: const Left(ServerFailure(msg: 'server error')),
      );
      final cubit = CurrencyCodeCubit(repo: repo);
      final emittedStates = <CurrencyCodeState>[];
      final subscription = cubit.stream.listen(emittedStates.add);

      await cubit.getRates();
      await pumpEventQueue();

      expect(emittedStates, hasLength(2));
      expect(emittedStates[0], isA<CurrencyCodeLoadingState>());
      expect(emittedStates[1], isA<CurrencyCodeFailurState>());
      expect((emittedStates[1] as CurrencyCodeFailurState).msg, 'server error');

      await subscription.cancel();
      await cubit.close();
    });

    test('emits convert result success with the fetched rate', () async {
      final currentRates = [
        const CurrencyConvertorModel(
          date: '2026-04-13',
          base: 'USD',
          quote: 'EGP',
          rate: 50.75,
        ),
      ];
      final repo = FakeCurrencyCodeRepo(
        getCurrencyResult: Right([
          const CurrencyConvertorModel(
            date: '2026-04-13',
            base: 'USD',
            quote: 'EUR',
            rate: 0.88,
          ),
        ]),
      );
      final cubit = CurrencyCodeCubit(repo: repo);
      final emittedStates = <CurrencyCodeState>[];
      final subscription = cubit.stream.listen(emittedStates.add);
      cubit.emit(CurrencyCodeSuccsseState(currencyConvertorModel: currentRates));
      await pumpEventQueue();
      final inputs = RatesInputs(base: 'USD', qoutes: 'EUR');

      await cubit.getConvertResult(inputs: inputs);
      await pumpEventQueue();

      expect(repo.lastInputs, equals(inputs));
      expect(emittedStates.last, isA<ConvertResultSuccessState>());
      expect(
        (emittedStates.last as ConvertResultSuccessState).currencyConvertorModel,
        equals(currentRates),
      );
      expect((emittedStates.last as ConvertResultSuccessState).rateValue, 0.88);

      await subscription.cancel();
      await cubit.close();
    });

    test('emits convert result failure when fetching converted rate fails', () async {
      final currentRates = [
        const CurrencyConvertorModel(
          date: '2026-04-13',
          base: 'USD',
          quote: 'EGP',
          rate: 50.75,
        ),
      ];
      final repo = FakeCurrencyCodeRepo(
        getCurrencyResult: const Left(ServerFailure(msg: 'conversion failed')),
      );
      final cubit = CurrencyCodeCubit(repo: repo);
      final emittedStates = <CurrencyCodeState>[];
      final subscription = cubit.stream.listen(emittedStates.add);
      cubit.emit(CurrencyCodeSuccsseState(currencyConvertorModel: currentRates));
      await pumpEventQueue();

      await cubit.getConvertResult(
        inputs: RatesInputs(base: 'USD', qoutes: 'EUR'),
      );
      await pumpEventQueue();

      expect(emittedStates.last, isA<ConvertResultFailureState>());
      expect(
        (emittedStates.last as ConvertResultFailureState).currencyConvertorModel,
        equals(currentRates),
      );

      await subscription.cancel();
      await cubit.close();
    });
  });
}

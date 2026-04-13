import 'package:currency_convertor_app/core/network/errors/failure.dart';
import 'package:currency_convertor_app/data/data.dart';
import 'package:currency_convertor_app/data/repo/currency_code_repo_impl.dart';
import 'package:currency_convertor_app/domian/entities/currency_convertor_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeCurrencyCodeDataSource implements CurrencyCodeDataSource {
  FakeCurrencyCodeDataSource({
    this.response = const Right([]),
    this.throwOnGetRates = false,
  });

  Either<Failure, List<dynamic>> response;
  bool throwOnGetRates;

  @override
  Future<Either<Failure, List<dynamic>>> getRates({inputs}) async {
    if (throwOnGetRates) {
      throw Exception('mapping failed');
    }

    return response;
  }
}

class FakeCurrencyLocalDataSource implements CurrencyLocalDataSource {
  List<dynamic>? savedList;
  List<CurrencyConvertorModel> localData = const [];

  @override
  Future<List<CurrencyConvertorModel>> getLocalDataSource() async => localData;

  @override
  Future<void> saveToLocalData({required List<dynamic> list}) async {
    savedList = list;
  }
}

void main() {
  group('CurrencyCodeRepoImpl', () {
    test('returns mapped currency models and saves raw response locally', () async {
      final remoteData = [
        {
          'date': '2026-04-13',
          'base': 'USD',
          'quote': 'EGP',
          'rate': 50.75,
        },
      ];

      final dataSource = FakeCurrencyCodeDataSource(response: Right(remoteData));
      final localDataSource = FakeCurrencyLocalDataSource();
      final repo = CurrencyCodeRepoImpl(
        data: dataSource,
        localDataSource: localDataSource,
      );

      final result = await repo.getCurrency();

      expect(result.isRight(), isTrue);
      expect(localDataSource.savedList, equals(remoteData));

      result.fold(
        (_) => fail('Expected a successful result'),
        (currencies) {
          expect(currencies, hasLength(1));
          expect(
            currencies.first,
            const CurrencyConvertorModel(
              date: '2026-04-13',
              base: 'USD',
              quote: 'EGP',
              rate: 50.75,
            ),
          );
        },
      );
    });

    test('returns a data mapping failure when the data source throws', () async {
      final dataSource = FakeCurrencyCodeDataSource(throwOnGetRates: true);
      final localDataSource = FakeCurrencyLocalDataSource();
      final repo = CurrencyCodeRepoImpl(
        data: dataSource,
        localDataSource: localDataSource,
      );

      final result = await repo.getCurrency();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<DataMappingFailure>()),
        (_) => fail('Expected a failure result'),
      );
    });

    test('delegates local rates loading to the local data source', () async {
      final expectedLocalRates = [
        const CurrencyConvertorModel(
          date: '2026-04-13',
          base: 'EUR',
          quote: 'USD',
          rate: 1.13,
        ),
      ];
      final dataSource = FakeCurrencyCodeDataSource();
      final localDataSource =
          FakeCurrencyLocalDataSource()..localData = expectedLocalRates;
      final repo = CurrencyCodeRepoImpl(
        data: dataSource,
        localDataSource: localDataSource,
      );

      final result = await repo.getLocalRates();

      expect(result, equals(expectedLocalRates));
    });
  });
}

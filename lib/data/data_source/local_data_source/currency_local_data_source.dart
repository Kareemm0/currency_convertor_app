import 'package:currency_convertor_app/domian/entities/currency_convertor_model.dart';

abstract class CurrencyLocalDataSource {
  Future<void> saveToLocalData({required List<dynamic> list});

  Future<List<CurrencyConvertorModel>> getLocalDataSource();
}

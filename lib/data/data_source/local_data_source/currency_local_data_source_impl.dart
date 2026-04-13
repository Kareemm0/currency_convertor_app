import 'package:currency_convertor_app/domian/entities/currency_convertor_model.dart';

import 'package:hive/hive.dart';

import '../../data.dart' show CurrencyLocalDataSource;

class CurrencyLocalDataSourceImpl implements CurrencyLocalDataSource {
  static const String boxName = "currency_box";

  Future<Box> _box() async {
    return await Hive.openBox(boxName);
  }

  @override
  Future<List<CurrencyConvertorModel>> getLocalDataSource() async {
    final box = await _box();

    final data = box.get('rates');

    if (data == null) return [];

    return (data as List)
        .map(
          (e) => CurrencyConvertorModel.fromJson(Map<String, dynamic>.from(e)),
        )
        .toList();
  }

  @override
  Future<void> saveToLocalData({required List<dynamic> list}) async {
    final box = await _box();

    await box.put('rates', list.map((e) => e).toList());
  }
}

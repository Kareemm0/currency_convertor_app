import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';

part 'currency_convertor_model.freezed.dart';
part 'currency_convertor_model.g.dart';

@HiveType(typeId: 1)
@freezed
abstract class CurrencyConvertorModel with _$CurrencyConvertorModel {
  const factory CurrencyConvertorModel({
    @HiveField(1) String? date,
    @HiveField(1) String? base,
    @HiveField(1) String? quote,
    @HiveField(1) double? rate,
  }) = _CurrencyConvertorModel;

  factory CurrencyConvertorModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyConvertorModelFromJson(json);
}

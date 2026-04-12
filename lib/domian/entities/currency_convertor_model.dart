import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_convertor_model.freezed.dart';
part 'currency_convertor_model.g.dart';

@freezed
abstract class CurrencyConvertorModel with _$CurrencyConvertorModel {
  const factory CurrencyConvertorModel({
    String? date,
    String? base,
    String? quote,
    double? rate,
  }) = _CurrencyConvertorModel;

  factory CurrencyConvertorModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyConvertorModelFromJson(json);
}

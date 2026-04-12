// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_convertor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CurrencyConvertorModel _$CurrencyConvertorModelFromJson(
  Map<String, dynamic> json,
) => _CurrencyConvertorModel(
  date: json['date'] as String?,
  base: json['base'] as String?,
  quote: json['quote'] as String?,
  rate: (json['rate'] as num?)?.toDouble(),
);

Map<String, dynamic> _$CurrencyConvertorModelToJson(
  _CurrencyConvertorModel instance,
) => <String, dynamic>{
  'date': instance.date,
  'base': instance.base,
  'quote': instance.quote,
  'rate': instance.rate,
};

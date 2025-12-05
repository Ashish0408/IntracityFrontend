// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stoppage_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StoppageModel _$StoppageModelFromJson(Map<String, dynamic> json) =>
    _StoppageModel(
      cityName: json['cityName'] as String?,
      arrivalTime: json['arrivalTime'] as String?,
      departureTime: json['departureTime'] as String?,
      cumulativePrice: (json['cumulativePrice'] as num?)?.toDouble() ?? 0.0,
      isConfirmed: json['isConfirmed'] as bool? ?? false,
    );

Map<String, dynamic> _$StoppageModelToJson(_StoppageModel instance) =>
    <String, dynamic>{
      'cityName': instance.cityName,
      'arrivalTime': instance.arrivalTime,
      'departureTime': instance.departureTime,
      'cumulativePrice': instance.cumulativePrice,
      'isConfirmed': instance.isConfirmed,
    };

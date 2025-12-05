// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DataStateModel _$DataStateModelFromJson(Map<String, dynamic> json) =>
    _DataStateModel(
      allBus:
          (json['allBus'] as List<dynamic>?)
              ?.map((e) => BusModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      filteredBus:
          (json['filteredBus'] as List<dynamic>?)
              ?.map((e) => BusModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$DataStateModelToJson(_DataStateModel instance) =>
    <String, dynamic>{
      'allBus': instance.allBus,
      'filteredBus': instance.filteredBus,
    };

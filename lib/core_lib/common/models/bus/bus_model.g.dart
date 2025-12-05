// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BusModel _$BusModelFromJson(Map<String, dynamic> json) => _BusModel(
  busId: (json['id'] as num?)?.toInt(),
  busName: json['name'] as String?,
  busOperator: json['operator'] as String?,
  busFromCity: json['fromCity'] as String?,
  busToCity: json['toCity'] as String?,
  busDepartureTime: json['departureTime'] as String?,
  busArrivalTime: json['arrivalTime'] as String?,
  busPrice: (json['price'] as num?)?.toDouble(),
  busTotalSeats: (json['totalSeats'] as num?)?.toInt(),
  busAvailableSeats: (json['availableSeats'] as num?)?.toInt(),
  busStoppages: (json['stoppages'] as List<dynamic>?)
      ?.map((e) => StoppageModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  busLayoutId: json['layoutId'] as String?,
  busSeatConfigurations: (json['seatConfigurations'] as List<dynamic>?)
      ?.map((e) => SeatConfigurationModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BusModelToJson(_BusModel instance) => <String, dynamic>{
  'id': instance.busId,
  'name': instance.busName,
  'operator': instance.busOperator,
  'fromCity': instance.busFromCity,
  'toCity': instance.busToCity,
  'departureTime': instance.busDepartureTime,
  'arrivalTime': instance.busArrivalTime,
  'price': instance.busPrice,
  'totalSeats': instance.busTotalSeats,
  'availableSeats': instance.busAvailableSeats,
  'stoppages': instance.busStoppages,
  if (instance.busLayoutId case final value?) 'layoutId': value,
  if (instance.busSeatConfigurations case final value?)
    'seatConfigurations': value,
};

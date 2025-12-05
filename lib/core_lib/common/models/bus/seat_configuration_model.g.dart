// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_configuration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SeatConfigurationModel _$SeatConfigurationModelFromJson(
  Map<String, dynamic> json,
) => _SeatConfigurationModel(
  seatType: json['seatType'] as String,
  noOfSeats: (json['noOfSeats'] as num).toInt(),
  pricePerSeat: (json['pricePerSeat'] as num).toDouble(),
);

Map<String, dynamic> _$SeatConfigurationModelToJson(
  _SeatConfigurationModel instance,
) => <String, dynamic>{
  'seatType': instance.seatType,
  'noOfSeats': instance.noOfSeats,
  'pricePerSeat': instance.pricePerSeat,
};

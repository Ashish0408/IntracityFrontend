import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'stoppage_model.dart';
import 'seat_configuration_model.dart';

part 'bus_model.freezed.dart';
part 'bus_model.g.dart';

@freezed
abstract class BusModel with _$BusModel {
  const factory BusModel({
    @JsonKey(name: 'id') int? busId,
    @JsonKey(name: 'name') String? busName,
    @JsonKey(name: 'operator') String? busOperator,
    @JsonKey(name: 'fromCity') String? busFromCity,
    @JsonKey(name: 'toCity') String? busToCity,
    @JsonKey(name: 'departureTime') String? busDepartureTime,
    @JsonKey(name: 'arrivalTime') String? busArrivalTime,
    @JsonKey(name: 'price') double? busPrice,
    @JsonKey(name: 'totalSeats') int? busTotalSeats,
    @JsonKey(name: 'availableSeats') int? busAvailableSeats,
    @JsonKey(name: 'stoppages') List<StoppageModel>? busStoppages,
    @JsonKey(name: 'layoutId', includeIfNull: false) String? busLayoutId,
    @JsonKey(name: 'seatConfigurations', includeIfNull: false)
    List<SeatConfigurationModel>? busSeatConfigurations,
  }) = _BusModel;

  factory BusModel.fromJson(Map<String, dynamic> json) =>
      _$BusModelFromJson(json);
}

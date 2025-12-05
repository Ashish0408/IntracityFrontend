import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'seat_configuration_model.freezed.dart';
part 'seat_configuration_model.g.dart';

@freezed
abstract class SeatConfigurationModel with _$SeatConfigurationModel {
  const factory SeatConfigurationModel({
    @JsonKey(name: 'seatType') required String seatType,
    @JsonKey(name: 'noOfSeats') required int noOfSeats,
    @JsonKey(name: 'pricePerSeat') required double pricePerSeat,
  }) = _SeatConfigurationModel;

  factory SeatConfigurationModel.fromJson(Map<String, dynamic> json) =>
      _$SeatConfigurationModelFromJson(json);
}

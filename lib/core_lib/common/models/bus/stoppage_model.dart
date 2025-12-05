import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'stoppage_model.freezed.dart';
part 'stoppage_model.g.dart';

@freezed
abstract class StoppageModel with _$StoppageModel {
  const factory StoppageModel({
    @JsonKey(name: 'cityName') String? cityName,
    @JsonKey(name: 'arrivalTime') String? arrivalTime,
    @JsonKey(name: 'departureTime') String? departureTime,
    @JsonKey(name: 'cumulativePrice', defaultValue: 0.0)
    double? cumulativePrice,
    @Default(false) bool isConfirmed,
  }) = _StoppageModel;

  factory StoppageModel.fromJson(Map<String, dynamic> json) =>
      _$StoppageModelFromJson(json);
}

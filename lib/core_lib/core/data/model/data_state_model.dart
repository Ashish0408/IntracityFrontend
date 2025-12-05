import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/models/bus/bus_model.dart';

part 'data_state_model.freezed.dart';
part 'data_state_model.g.dart';

@freezed
abstract class DataStateModel with _$DataStateModel {
  const factory DataStateModel({
    @Default([]) List<BusModel> allBus,
    @Default([]) List<BusModel> filteredBus,
  }) = _DataStateModel;

  factory DataStateModel.initial() => const DataStateModel();

  factory DataStateModel.fromJson(Map<String, dynamic> json) =>
      _$DataStateModelFromJson(json);
}

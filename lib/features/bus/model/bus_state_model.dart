import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core_lib/core.dart';

part 'bus_state_model.freezed.dart';

@freezed
abstract class BusStateModel with _$BusStateModel {
  const factory BusStateModel({
    // required PlatformFile? selectedImage,
    required BusModel? busForUpdate,
  }) = _BusStateModel;

  factory BusStateModel.initial() => const BusStateModel(
    // selectedImage: null,
    busForUpdate: null,
  );
}

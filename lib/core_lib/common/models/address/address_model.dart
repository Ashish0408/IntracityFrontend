// Address model using freezed + json_serializable
// Run to generate files:
// flutter pub run build_runner build --delete-conflicting-outputs

import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_model.freezed.dart';
part 'address_model.g.dart';

/// A reusable address model for user addresses, delivery, etc.
@freezed
abstract class AddressModel with _$AddressModel {
  const factory AddressModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'label') String? label,
    @JsonKey(name: 'recipientName') String? recipientName,
    @JsonKey(name: 'phone') String? phone,
    @JsonKey(name: 'street') String? street,
    @JsonKey(name: 'line2') String? line2,
    @JsonKey(name: 'city') String? city,
    @JsonKey(name: 'state') String? state,
    @JsonKey(name: 'country') String? country,
    @JsonKey(name: 'postal_code') String? postalCode,
    @JsonKey(name: 'latitude') double? latitude,
    @JsonKey(name: 'longitude') double? longitude,
    @JsonKey(name: 'isDefault') @Default(false) bool isDefault,
    @JsonKey(name: 'createdAt') DateTime? createdAt,
    @JsonKey(name: 'updatedAt') DateTime? updatedAt,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

import '../address/address_model.dart';

part 'vendor_model.freezed.dart';
part 'vendor_model.g.dart';

@freezed
abstract class VendorModel with _$VendorModel {
  const factory VendorModel({
    @JsonKey(name: 'vendor_id') String? vendorId,
    @JsonKey(name: 'vendor_name') String? vendorName,
    @JsonKey(name: 'shop_name') String? shopName,
    @JsonKey(name: 'vendor_email') String? vendorEmail,
    @JsonKey(name: 'vendor_phone') String? vendorPhone,
    @JsonKey(name: 'vendor_address') AddressModel? vendorAddress,
    @JsonKey(name: 'vendor_license') String? vendorLicenseNumber,
    @JsonKey(name: 'vendor_createdAt') String? createdAt,
    @JsonKey(name: 'vendor_updatedAt') String? updatedAt,
    @JsonKey(name: 'is_approved') @Default(false) bool isApproved,
    @JsonKey(name: 'is_blocked') @Default(false) bool isBlocked,
    @JsonKey(name: 'token') String? token,
    @JsonKey(name: '__v') int? v,
  }) = _VendorModel;

  factory VendorModel.fromJson(Map<String, dynamic> json) =>
      _$VendorModelFromJson(json);
}

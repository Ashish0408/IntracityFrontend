// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VendorModel _$VendorModelFromJson(Map<String, dynamic> json) => _VendorModel(
  vendorId: json['vendor_id'] as String?,
  vendorName: json['vendor_name'] as String?,
  shopName: json['shop_name'] as String?,
  vendorEmail: json['vendor_email'] as String?,
  vendorPhone: json['vendor_phone'] as String?,
  vendorAddress: json['vendor_address'] == null
      ? null
      : AddressModel.fromJson(json['vendor_address'] as Map<String, dynamic>),
  vendorLicenseNumber: json['vendor_license'] as String?,
  createdAt: json['vendor_createdAt'] as String?,
  updatedAt: json['vendor_updatedAt'] as String?,
  isApproved: json['is_approved'] as bool? ?? false,
  isBlocked: json['is_blocked'] as bool? ?? false,
  token: json['token'] as String?,
  v: (json['__v'] as num?)?.toInt(),
);

Map<String, dynamic> _$VendorModelToJson(_VendorModel instance) =>
    <String, dynamic>{
      'vendor_id': instance.vendorId,
      'vendor_name': instance.vendorName,
      'shop_name': instance.shopName,
      'vendor_email': instance.vendorEmail,
      'vendor_phone': instance.vendorPhone,
      'vendor_address': instance.vendorAddress,
      'vendor_license': instance.vendorLicenseNumber,
      'vendor_createdAt': instance.createdAt,
      'vendor_updatedAt': instance.updatedAt,
      'is_approved': instance.isApproved,
      'is_blocked': instance.isBlocked,
      'token': instance.token,
      '__v': instance.v,
    };

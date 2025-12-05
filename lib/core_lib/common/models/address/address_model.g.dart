// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AddressModel _$AddressModelFromJson(Map<String, dynamic> json) =>
    _AddressModel(
      id: json['_id'] as String?,
      label: json['label'] as String?,
      recipientName: json['recipientName'] as String?,
      phone: json['phone'] as String?,
      street: json['street'] as String?,
      line2: json['line2'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      postalCode: json['postal_code'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      isDefault: json['isDefault'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$AddressModelToJson(_AddressModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'label': instance.label,
      'recipientName': instance.recipientName,
      'phone': instance.phone,
      'street': instance.street,
      'line2': instance.line2,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'postal_code': instance.postalCode,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'isDefault': instance.isDefault,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vendor_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VendorModel {

@JsonKey(name: 'vendor_id') String? get vendorId;@JsonKey(name: 'vendor_name') String? get vendorName;@JsonKey(name: 'shop_name') String? get shopName;@JsonKey(name: 'vendor_email') String? get vendorEmail;@JsonKey(name: 'vendor_phone') String? get vendorPhone;@JsonKey(name: 'vendor_address') AddressModel? get vendorAddress;@JsonKey(name: 'vendor_license') String? get vendorLicenseNumber;@JsonKey(name: 'vendor_createdAt') String? get createdAt;@JsonKey(name: 'vendor_updatedAt') String? get updatedAt;@JsonKey(name: 'is_approved') bool get isApproved;@JsonKey(name: 'is_blocked') bool get isBlocked;@JsonKey(name: 'token') String? get token;@JsonKey(name: '__v') int? get v;
/// Create a copy of VendorModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorModelCopyWith<VendorModel> get copyWith => _$VendorModelCopyWithImpl<VendorModel>(this as VendorModel, _$identity);

  /// Serializes this VendorModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorModel&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.vendorEmail, vendorEmail) || other.vendorEmail == vendorEmail)&&(identical(other.vendorPhone, vendorPhone) || other.vendorPhone == vendorPhone)&&(identical(other.vendorAddress, vendorAddress) || other.vendorAddress == vendorAddress)&&(identical(other.vendorLicenseNumber, vendorLicenseNumber) || other.vendorLicenseNumber == vendorLicenseNumber)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.isBlocked, isBlocked) || other.isBlocked == isBlocked)&&(identical(other.token, token) || other.token == token)&&(identical(other.v, v) || other.v == v));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,vendorId,vendorName,shopName,vendorEmail,vendorPhone,vendorAddress,vendorLicenseNumber,createdAt,updatedAt,isApproved,isBlocked,token,v);

@override
String toString() {
  return 'VendorModel(vendorId: $vendorId, vendorName: $vendorName, shopName: $shopName, vendorEmail: $vendorEmail, vendorPhone: $vendorPhone, vendorAddress: $vendorAddress, vendorLicenseNumber: $vendorLicenseNumber, createdAt: $createdAt, updatedAt: $updatedAt, isApproved: $isApproved, isBlocked: $isBlocked, token: $token, v: $v)';
}


}

/// @nodoc
abstract mixin class $VendorModelCopyWith<$Res>  {
  factory $VendorModelCopyWith(VendorModel value, $Res Function(VendorModel) _then) = _$VendorModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'vendor_id') String? vendorId,@JsonKey(name: 'vendor_name') String? vendorName,@JsonKey(name: 'shop_name') String? shopName,@JsonKey(name: 'vendor_email') String? vendorEmail,@JsonKey(name: 'vendor_phone') String? vendorPhone,@JsonKey(name: 'vendor_address') AddressModel? vendorAddress,@JsonKey(name: 'vendor_license') String? vendorLicenseNumber,@JsonKey(name: 'vendor_createdAt') String? createdAt,@JsonKey(name: 'vendor_updatedAt') String? updatedAt,@JsonKey(name: 'is_approved') bool isApproved,@JsonKey(name: 'is_blocked') bool isBlocked,@JsonKey(name: 'token') String? token,@JsonKey(name: '__v') int? v
});


$AddressModelCopyWith<$Res>? get vendorAddress;

}
/// @nodoc
class _$VendorModelCopyWithImpl<$Res>
    implements $VendorModelCopyWith<$Res> {
  _$VendorModelCopyWithImpl(this._self, this._then);

  final VendorModel _self;
  final $Res Function(VendorModel) _then;

/// Create a copy of VendorModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vendorId = freezed,Object? vendorName = freezed,Object? shopName = freezed,Object? vendorEmail = freezed,Object? vendorPhone = freezed,Object? vendorAddress = freezed,Object? vendorLicenseNumber = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isApproved = null,Object? isBlocked = null,Object? token = freezed,Object? v = freezed,}) {
  return _then(_self.copyWith(
vendorId: freezed == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String?,vendorName: freezed == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String?,shopName: freezed == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String?,vendorEmail: freezed == vendorEmail ? _self.vendorEmail : vendorEmail // ignore: cast_nullable_to_non_nullable
as String?,vendorPhone: freezed == vendorPhone ? _self.vendorPhone : vendorPhone // ignore: cast_nullable_to_non_nullable
as String?,vendorAddress: freezed == vendorAddress ? _self.vendorAddress : vendorAddress // ignore: cast_nullable_to_non_nullable
as AddressModel?,vendorLicenseNumber: freezed == vendorLicenseNumber ? _self.vendorLicenseNumber : vendorLicenseNumber // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,isApproved: null == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool,isBlocked: null == isBlocked ? _self.isBlocked : isBlocked // ignore: cast_nullable_to_non_nullable
as bool,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,v: freezed == v ? _self.v : v // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of VendorModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressModelCopyWith<$Res>? get vendorAddress {
    if (_self.vendorAddress == null) {
    return null;
  }

  return $AddressModelCopyWith<$Res>(_self.vendorAddress!, (value) {
    return _then(_self.copyWith(vendorAddress: value));
  });
}
}


/// Adds pattern-matching-related methods to [VendorModel].
extension VendorModelPatterns on VendorModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorModel value)  $default,){
final _that = this;
switch (_that) {
case _VendorModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorModel value)?  $default,){
final _that = this;
switch (_that) {
case _VendorModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'vendor_id')  String? vendorId, @JsonKey(name: 'vendor_name')  String? vendorName, @JsonKey(name: 'shop_name')  String? shopName, @JsonKey(name: 'vendor_email')  String? vendorEmail, @JsonKey(name: 'vendor_phone')  String? vendorPhone, @JsonKey(name: 'vendor_address')  AddressModel? vendorAddress, @JsonKey(name: 'vendor_license')  String? vendorLicenseNumber, @JsonKey(name: 'vendor_createdAt')  String? createdAt, @JsonKey(name: 'vendor_updatedAt')  String? updatedAt, @JsonKey(name: 'is_approved')  bool isApproved, @JsonKey(name: 'is_blocked')  bool isBlocked, @JsonKey(name: 'token')  String? token, @JsonKey(name: '__v')  int? v)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorModel() when $default != null:
return $default(_that.vendorId,_that.vendorName,_that.shopName,_that.vendorEmail,_that.vendorPhone,_that.vendorAddress,_that.vendorLicenseNumber,_that.createdAt,_that.updatedAt,_that.isApproved,_that.isBlocked,_that.token,_that.v);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'vendor_id')  String? vendorId, @JsonKey(name: 'vendor_name')  String? vendorName, @JsonKey(name: 'shop_name')  String? shopName, @JsonKey(name: 'vendor_email')  String? vendorEmail, @JsonKey(name: 'vendor_phone')  String? vendorPhone, @JsonKey(name: 'vendor_address')  AddressModel? vendorAddress, @JsonKey(name: 'vendor_license')  String? vendorLicenseNumber, @JsonKey(name: 'vendor_createdAt')  String? createdAt, @JsonKey(name: 'vendor_updatedAt')  String? updatedAt, @JsonKey(name: 'is_approved')  bool isApproved, @JsonKey(name: 'is_blocked')  bool isBlocked, @JsonKey(name: 'token')  String? token, @JsonKey(name: '__v')  int? v)  $default,) {final _that = this;
switch (_that) {
case _VendorModel():
return $default(_that.vendorId,_that.vendorName,_that.shopName,_that.vendorEmail,_that.vendorPhone,_that.vendorAddress,_that.vendorLicenseNumber,_that.createdAt,_that.updatedAt,_that.isApproved,_that.isBlocked,_that.token,_that.v);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'vendor_id')  String? vendorId, @JsonKey(name: 'vendor_name')  String? vendorName, @JsonKey(name: 'shop_name')  String? shopName, @JsonKey(name: 'vendor_email')  String? vendorEmail, @JsonKey(name: 'vendor_phone')  String? vendorPhone, @JsonKey(name: 'vendor_address')  AddressModel? vendorAddress, @JsonKey(name: 'vendor_license')  String? vendorLicenseNumber, @JsonKey(name: 'vendor_createdAt')  String? createdAt, @JsonKey(name: 'vendor_updatedAt')  String? updatedAt, @JsonKey(name: 'is_approved')  bool isApproved, @JsonKey(name: 'is_blocked')  bool isBlocked, @JsonKey(name: 'token')  String? token, @JsonKey(name: '__v')  int? v)?  $default,) {final _that = this;
switch (_that) {
case _VendorModel() when $default != null:
return $default(_that.vendorId,_that.vendorName,_that.shopName,_that.vendorEmail,_that.vendorPhone,_that.vendorAddress,_that.vendorLicenseNumber,_that.createdAt,_that.updatedAt,_that.isApproved,_that.isBlocked,_that.token,_that.v);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VendorModel implements VendorModel {
  const _VendorModel({@JsonKey(name: 'vendor_id') this.vendorId, @JsonKey(name: 'vendor_name') this.vendorName, @JsonKey(name: 'shop_name') this.shopName, @JsonKey(name: 'vendor_email') this.vendorEmail, @JsonKey(name: 'vendor_phone') this.vendorPhone, @JsonKey(name: 'vendor_address') this.vendorAddress, @JsonKey(name: 'vendor_license') this.vendorLicenseNumber, @JsonKey(name: 'vendor_createdAt') this.createdAt, @JsonKey(name: 'vendor_updatedAt') this.updatedAt, @JsonKey(name: 'is_approved') this.isApproved = false, @JsonKey(name: 'is_blocked') this.isBlocked = false, @JsonKey(name: 'token') this.token, @JsonKey(name: '__v') this.v});
  factory _VendorModel.fromJson(Map<String, dynamic> json) => _$VendorModelFromJson(json);

@override@JsonKey(name: 'vendor_id') final  String? vendorId;
@override@JsonKey(name: 'vendor_name') final  String? vendorName;
@override@JsonKey(name: 'shop_name') final  String? shopName;
@override@JsonKey(name: 'vendor_email') final  String? vendorEmail;
@override@JsonKey(name: 'vendor_phone') final  String? vendorPhone;
@override@JsonKey(name: 'vendor_address') final  AddressModel? vendorAddress;
@override@JsonKey(name: 'vendor_license') final  String? vendorLicenseNumber;
@override@JsonKey(name: 'vendor_createdAt') final  String? createdAt;
@override@JsonKey(name: 'vendor_updatedAt') final  String? updatedAt;
@override@JsonKey(name: 'is_approved') final  bool isApproved;
@override@JsonKey(name: 'is_blocked') final  bool isBlocked;
@override@JsonKey(name: 'token') final  String? token;
@override@JsonKey(name: '__v') final  int? v;

/// Create a copy of VendorModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorModelCopyWith<_VendorModel> get copyWith => __$VendorModelCopyWithImpl<_VendorModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VendorModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorModel&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.vendorEmail, vendorEmail) || other.vendorEmail == vendorEmail)&&(identical(other.vendorPhone, vendorPhone) || other.vendorPhone == vendorPhone)&&(identical(other.vendorAddress, vendorAddress) || other.vendorAddress == vendorAddress)&&(identical(other.vendorLicenseNumber, vendorLicenseNumber) || other.vendorLicenseNumber == vendorLicenseNumber)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.isBlocked, isBlocked) || other.isBlocked == isBlocked)&&(identical(other.token, token) || other.token == token)&&(identical(other.v, v) || other.v == v));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,vendorId,vendorName,shopName,vendorEmail,vendorPhone,vendorAddress,vendorLicenseNumber,createdAt,updatedAt,isApproved,isBlocked,token,v);

@override
String toString() {
  return 'VendorModel(vendorId: $vendorId, vendorName: $vendorName, shopName: $shopName, vendorEmail: $vendorEmail, vendorPhone: $vendorPhone, vendorAddress: $vendorAddress, vendorLicenseNumber: $vendorLicenseNumber, createdAt: $createdAt, updatedAt: $updatedAt, isApproved: $isApproved, isBlocked: $isBlocked, token: $token, v: $v)';
}


}

/// @nodoc
abstract mixin class _$VendorModelCopyWith<$Res> implements $VendorModelCopyWith<$Res> {
  factory _$VendorModelCopyWith(_VendorModel value, $Res Function(_VendorModel) _then) = __$VendorModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'vendor_id') String? vendorId,@JsonKey(name: 'vendor_name') String? vendorName,@JsonKey(name: 'shop_name') String? shopName,@JsonKey(name: 'vendor_email') String? vendorEmail,@JsonKey(name: 'vendor_phone') String? vendorPhone,@JsonKey(name: 'vendor_address') AddressModel? vendorAddress,@JsonKey(name: 'vendor_license') String? vendorLicenseNumber,@JsonKey(name: 'vendor_createdAt') String? createdAt,@JsonKey(name: 'vendor_updatedAt') String? updatedAt,@JsonKey(name: 'is_approved') bool isApproved,@JsonKey(name: 'is_blocked') bool isBlocked,@JsonKey(name: 'token') String? token,@JsonKey(name: '__v') int? v
});


@override $AddressModelCopyWith<$Res>? get vendorAddress;

}
/// @nodoc
class __$VendorModelCopyWithImpl<$Res>
    implements _$VendorModelCopyWith<$Res> {
  __$VendorModelCopyWithImpl(this._self, this._then);

  final _VendorModel _self;
  final $Res Function(_VendorModel) _then;

/// Create a copy of VendorModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vendorId = freezed,Object? vendorName = freezed,Object? shopName = freezed,Object? vendorEmail = freezed,Object? vendorPhone = freezed,Object? vendorAddress = freezed,Object? vendorLicenseNumber = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isApproved = null,Object? isBlocked = null,Object? token = freezed,Object? v = freezed,}) {
  return _then(_VendorModel(
vendorId: freezed == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String?,vendorName: freezed == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String?,shopName: freezed == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String?,vendorEmail: freezed == vendorEmail ? _self.vendorEmail : vendorEmail // ignore: cast_nullable_to_non_nullable
as String?,vendorPhone: freezed == vendorPhone ? _self.vendorPhone : vendorPhone // ignore: cast_nullable_to_non_nullable
as String?,vendorAddress: freezed == vendorAddress ? _self.vendorAddress : vendorAddress // ignore: cast_nullable_to_non_nullable
as AddressModel?,vendorLicenseNumber: freezed == vendorLicenseNumber ? _self.vendorLicenseNumber : vendorLicenseNumber // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,isApproved: null == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool,isBlocked: null == isBlocked ? _self.isBlocked : isBlocked // ignore: cast_nullable_to_non_nullable
as bool,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,v: freezed == v ? _self.v : v // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of VendorModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressModelCopyWith<$Res>? get vendorAddress {
    if (_self.vendorAddress == null) {
    return null;
  }

  return $AddressModelCopyWith<$Res>(_self.vendorAddress!, (value) {
    return _then(_self.copyWith(vendorAddress: value));
  });
}
}

// dart format on

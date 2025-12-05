// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AddressModel {

@JsonKey(name: '_id') String? get id;@JsonKey(name: 'label') String? get label;@JsonKey(name: 'recipientName') String? get recipientName;@JsonKey(name: 'phone') String? get phone;@JsonKey(name: 'street') String? get street;@JsonKey(name: 'line2') String? get line2;@JsonKey(name: 'city') String? get city;@JsonKey(name: 'state') String? get state;@JsonKey(name: 'country') String? get country;@JsonKey(name: 'postal_code') String? get postalCode;@JsonKey(name: 'latitude') double? get latitude;@JsonKey(name: 'longitude') double? get longitude;@JsonKey(name: 'isDefault') bool get isDefault;@JsonKey(name: 'createdAt') DateTime? get createdAt;@JsonKey(name: 'updatedAt') DateTime? get updatedAt;
/// Create a copy of AddressModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressModelCopyWith<AddressModel> get copyWith => _$AddressModelCopyWithImpl<AddressModel>(this as AddressModel, _$identity);

  /// Serializes this AddressModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressModel&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.street, street) || other.street == street)&&(identical(other.line2, line2) || other.line2 == line2)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.country, country) || other.country == country)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,recipientName,phone,street,line2,city,state,country,postalCode,latitude,longitude,isDefault,createdAt,updatedAt);

@override
String toString() {
  return 'AddressModel(id: $id, label: $label, recipientName: $recipientName, phone: $phone, street: $street, line2: $line2, city: $city, state: $state, country: $country, postalCode: $postalCode, latitude: $latitude, longitude: $longitude, isDefault: $isDefault, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $AddressModelCopyWith<$Res>  {
  factory $AddressModelCopyWith(AddressModel value, $Res Function(AddressModel) _then) = _$AddressModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '_id') String? id,@JsonKey(name: 'label') String? label,@JsonKey(name: 'recipientName') String? recipientName,@JsonKey(name: 'phone') String? phone,@JsonKey(name: 'street') String? street,@JsonKey(name: 'line2') String? line2,@JsonKey(name: 'city') String? city,@JsonKey(name: 'state') String? state,@JsonKey(name: 'country') String? country,@JsonKey(name: 'postal_code') String? postalCode,@JsonKey(name: 'latitude') double? latitude,@JsonKey(name: 'longitude') double? longitude,@JsonKey(name: 'isDefault') bool isDefault,@JsonKey(name: 'createdAt') DateTime? createdAt,@JsonKey(name: 'updatedAt') DateTime? updatedAt
});




}
/// @nodoc
class _$AddressModelCopyWithImpl<$Res>
    implements $AddressModelCopyWith<$Res> {
  _$AddressModelCopyWithImpl(this._self, this._then);

  final AddressModel _self;
  final $Res Function(AddressModel) _then;

/// Create a copy of AddressModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? label = freezed,Object? recipientName = freezed,Object? phone = freezed,Object? street = freezed,Object? line2 = freezed,Object? city = freezed,Object? state = freezed,Object? country = freezed,Object? postalCode = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? isDefault = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,recipientName: freezed == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,street: freezed == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String?,line2: freezed == line2 ? _self.line2 : line2 // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AddressModel].
extension AddressModelPatterns on AddressModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddressModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddressModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddressModel value)  $default,){
final _that = this;
switch (_that) {
case _AddressModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddressModel value)?  $default,){
final _that = this;
switch (_that) {
case _AddressModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String? id, @JsonKey(name: 'label')  String? label, @JsonKey(name: 'recipientName')  String? recipientName, @JsonKey(name: 'phone')  String? phone, @JsonKey(name: 'street')  String? street, @JsonKey(name: 'line2')  String? line2, @JsonKey(name: 'city')  String? city, @JsonKey(name: 'state')  String? state, @JsonKey(name: 'country')  String? country, @JsonKey(name: 'postal_code')  String? postalCode, @JsonKey(name: 'latitude')  double? latitude, @JsonKey(name: 'longitude')  double? longitude, @JsonKey(name: 'isDefault')  bool isDefault, @JsonKey(name: 'createdAt')  DateTime? createdAt, @JsonKey(name: 'updatedAt')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddressModel() when $default != null:
return $default(_that.id,_that.label,_that.recipientName,_that.phone,_that.street,_that.line2,_that.city,_that.state,_that.country,_that.postalCode,_that.latitude,_that.longitude,_that.isDefault,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String? id, @JsonKey(name: 'label')  String? label, @JsonKey(name: 'recipientName')  String? recipientName, @JsonKey(name: 'phone')  String? phone, @JsonKey(name: 'street')  String? street, @JsonKey(name: 'line2')  String? line2, @JsonKey(name: 'city')  String? city, @JsonKey(name: 'state')  String? state, @JsonKey(name: 'country')  String? country, @JsonKey(name: 'postal_code')  String? postalCode, @JsonKey(name: 'latitude')  double? latitude, @JsonKey(name: 'longitude')  double? longitude, @JsonKey(name: 'isDefault')  bool isDefault, @JsonKey(name: 'createdAt')  DateTime? createdAt, @JsonKey(name: 'updatedAt')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _AddressModel():
return $default(_that.id,_that.label,_that.recipientName,_that.phone,_that.street,_that.line2,_that.city,_that.state,_that.country,_that.postalCode,_that.latitude,_that.longitude,_that.isDefault,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: '_id')  String? id, @JsonKey(name: 'label')  String? label, @JsonKey(name: 'recipientName')  String? recipientName, @JsonKey(name: 'phone')  String? phone, @JsonKey(name: 'street')  String? street, @JsonKey(name: 'line2')  String? line2, @JsonKey(name: 'city')  String? city, @JsonKey(name: 'state')  String? state, @JsonKey(name: 'country')  String? country, @JsonKey(name: 'postal_code')  String? postalCode, @JsonKey(name: 'latitude')  double? latitude, @JsonKey(name: 'longitude')  double? longitude, @JsonKey(name: 'isDefault')  bool isDefault, @JsonKey(name: 'createdAt')  DateTime? createdAt, @JsonKey(name: 'updatedAt')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _AddressModel() when $default != null:
return $default(_that.id,_that.label,_that.recipientName,_that.phone,_that.street,_that.line2,_that.city,_that.state,_that.country,_that.postalCode,_that.latitude,_that.longitude,_that.isDefault,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AddressModel implements AddressModel {
  const _AddressModel({@JsonKey(name: '_id') this.id, @JsonKey(name: 'label') this.label, @JsonKey(name: 'recipientName') this.recipientName, @JsonKey(name: 'phone') this.phone, @JsonKey(name: 'street') this.street, @JsonKey(name: 'line2') this.line2, @JsonKey(name: 'city') this.city, @JsonKey(name: 'state') this.state, @JsonKey(name: 'country') this.country, @JsonKey(name: 'postal_code') this.postalCode, @JsonKey(name: 'latitude') this.latitude, @JsonKey(name: 'longitude') this.longitude, @JsonKey(name: 'isDefault') this.isDefault = false, @JsonKey(name: 'createdAt') this.createdAt, @JsonKey(name: 'updatedAt') this.updatedAt});
  factory _AddressModel.fromJson(Map<String, dynamic> json) => _$AddressModelFromJson(json);

@override@JsonKey(name: '_id') final  String? id;
@override@JsonKey(name: 'label') final  String? label;
@override@JsonKey(name: 'recipientName') final  String? recipientName;
@override@JsonKey(name: 'phone') final  String? phone;
@override@JsonKey(name: 'street') final  String? street;
@override@JsonKey(name: 'line2') final  String? line2;
@override@JsonKey(name: 'city') final  String? city;
@override@JsonKey(name: 'state') final  String? state;
@override@JsonKey(name: 'country') final  String? country;
@override@JsonKey(name: 'postal_code') final  String? postalCode;
@override@JsonKey(name: 'latitude') final  double? latitude;
@override@JsonKey(name: 'longitude') final  double? longitude;
@override@JsonKey(name: 'isDefault') final  bool isDefault;
@override@JsonKey(name: 'createdAt') final  DateTime? createdAt;
@override@JsonKey(name: 'updatedAt') final  DateTime? updatedAt;

/// Create a copy of AddressModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddressModelCopyWith<_AddressModel> get copyWith => __$AddressModelCopyWithImpl<_AddressModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddressModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddressModel&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.street, street) || other.street == street)&&(identical(other.line2, line2) || other.line2 == line2)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.country, country) || other.country == country)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,recipientName,phone,street,line2,city,state,country,postalCode,latitude,longitude,isDefault,createdAt,updatedAt);

@override
String toString() {
  return 'AddressModel(id: $id, label: $label, recipientName: $recipientName, phone: $phone, street: $street, line2: $line2, city: $city, state: $state, country: $country, postalCode: $postalCode, latitude: $latitude, longitude: $longitude, isDefault: $isDefault, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$AddressModelCopyWith<$Res> implements $AddressModelCopyWith<$Res> {
  factory _$AddressModelCopyWith(_AddressModel value, $Res Function(_AddressModel) _then) = __$AddressModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '_id') String? id,@JsonKey(name: 'label') String? label,@JsonKey(name: 'recipientName') String? recipientName,@JsonKey(name: 'phone') String? phone,@JsonKey(name: 'street') String? street,@JsonKey(name: 'line2') String? line2,@JsonKey(name: 'city') String? city,@JsonKey(name: 'state') String? state,@JsonKey(name: 'country') String? country,@JsonKey(name: 'postal_code') String? postalCode,@JsonKey(name: 'latitude') double? latitude,@JsonKey(name: 'longitude') double? longitude,@JsonKey(name: 'isDefault') bool isDefault,@JsonKey(name: 'createdAt') DateTime? createdAt,@JsonKey(name: 'updatedAt') DateTime? updatedAt
});




}
/// @nodoc
class __$AddressModelCopyWithImpl<$Res>
    implements _$AddressModelCopyWith<$Res> {
  __$AddressModelCopyWithImpl(this._self, this._then);

  final _AddressModel _self;
  final $Res Function(_AddressModel) _then;

/// Create a copy of AddressModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? label = freezed,Object? recipientName = freezed,Object? phone = freezed,Object? street = freezed,Object? line2 = freezed,Object? city = freezed,Object? state = freezed,Object? country = freezed,Object? postalCode = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? isDefault = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_AddressModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,recipientName: freezed == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,street: freezed == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String?,line2: freezed == line2 ? _self.line2 : line2 // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stoppage_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StoppageModel implements DiagnosticableTreeMixin {

@JsonKey(name: 'cityName') String? get cityName;@JsonKey(name: 'arrivalTime') String? get arrivalTime;@JsonKey(name: 'departureTime') String? get departureTime;@JsonKey(name: 'cumulativePrice', defaultValue: 0.0) double? get cumulativePrice; bool get isConfirmed;
/// Create a copy of StoppageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoppageModelCopyWith<StoppageModel> get copyWith => _$StoppageModelCopyWithImpl<StoppageModel>(this as StoppageModel, _$identity);

  /// Serializes this StoppageModel to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'StoppageModel'))
    ..add(DiagnosticsProperty('cityName', cityName))..add(DiagnosticsProperty('arrivalTime', arrivalTime))..add(DiagnosticsProperty('departureTime', departureTime))..add(DiagnosticsProperty('cumulativePrice', cumulativePrice))..add(DiagnosticsProperty('isConfirmed', isConfirmed));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoppageModel&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.departureTime, departureTime) || other.departureTime == departureTime)&&(identical(other.cumulativePrice, cumulativePrice) || other.cumulativePrice == cumulativePrice)&&(identical(other.isConfirmed, isConfirmed) || other.isConfirmed == isConfirmed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cityName,arrivalTime,departureTime,cumulativePrice,isConfirmed);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'StoppageModel(cityName: $cityName, arrivalTime: $arrivalTime, departureTime: $departureTime, cumulativePrice: $cumulativePrice, isConfirmed: $isConfirmed)';
}


}

/// @nodoc
abstract mixin class $StoppageModelCopyWith<$Res>  {
  factory $StoppageModelCopyWith(StoppageModel value, $Res Function(StoppageModel) _then) = _$StoppageModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'cityName') String? cityName,@JsonKey(name: 'arrivalTime') String? arrivalTime,@JsonKey(name: 'departureTime') String? departureTime,@JsonKey(name: 'cumulativePrice', defaultValue: 0.0) double? cumulativePrice, bool isConfirmed
});




}
/// @nodoc
class _$StoppageModelCopyWithImpl<$Res>
    implements $StoppageModelCopyWith<$Res> {
  _$StoppageModelCopyWithImpl(this._self, this._then);

  final StoppageModel _self;
  final $Res Function(StoppageModel) _then;

/// Create a copy of StoppageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cityName = freezed,Object? arrivalTime = freezed,Object? departureTime = freezed,Object? cumulativePrice = freezed,Object? isConfirmed = null,}) {
  return _then(_self.copyWith(
cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as String?,departureTime: freezed == departureTime ? _self.departureTime : departureTime // ignore: cast_nullable_to_non_nullable
as String?,cumulativePrice: freezed == cumulativePrice ? _self.cumulativePrice : cumulativePrice // ignore: cast_nullable_to_non_nullable
as double?,isConfirmed: null == isConfirmed ? _self.isConfirmed : isConfirmed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [StoppageModel].
extension StoppageModelPatterns on StoppageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoppageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoppageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoppageModel value)  $default,){
final _that = this;
switch (_that) {
case _StoppageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoppageModel value)?  $default,){
final _that = this;
switch (_that) {
case _StoppageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'cityName')  String? cityName, @JsonKey(name: 'arrivalTime')  String? arrivalTime, @JsonKey(name: 'departureTime')  String? departureTime, @JsonKey(name: 'cumulativePrice', defaultValue: 0.0)  double? cumulativePrice,  bool isConfirmed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoppageModel() when $default != null:
return $default(_that.cityName,_that.arrivalTime,_that.departureTime,_that.cumulativePrice,_that.isConfirmed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'cityName')  String? cityName, @JsonKey(name: 'arrivalTime')  String? arrivalTime, @JsonKey(name: 'departureTime')  String? departureTime, @JsonKey(name: 'cumulativePrice', defaultValue: 0.0)  double? cumulativePrice,  bool isConfirmed)  $default,) {final _that = this;
switch (_that) {
case _StoppageModel():
return $default(_that.cityName,_that.arrivalTime,_that.departureTime,_that.cumulativePrice,_that.isConfirmed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'cityName')  String? cityName, @JsonKey(name: 'arrivalTime')  String? arrivalTime, @JsonKey(name: 'departureTime')  String? departureTime, @JsonKey(name: 'cumulativePrice', defaultValue: 0.0)  double? cumulativePrice,  bool isConfirmed)?  $default,) {final _that = this;
switch (_that) {
case _StoppageModel() when $default != null:
return $default(_that.cityName,_that.arrivalTime,_that.departureTime,_that.cumulativePrice,_that.isConfirmed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StoppageModel with DiagnosticableTreeMixin implements StoppageModel {
  const _StoppageModel({@JsonKey(name: 'cityName') this.cityName, @JsonKey(name: 'arrivalTime') this.arrivalTime, @JsonKey(name: 'departureTime') this.departureTime, @JsonKey(name: 'cumulativePrice', defaultValue: 0.0) this.cumulativePrice, this.isConfirmed = false});
  factory _StoppageModel.fromJson(Map<String, dynamic> json) => _$StoppageModelFromJson(json);

@override@JsonKey(name: 'cityName') final  String? cityName;
@override@JsonKey(name: 'arrivalTime') final  String? arrivalTime;
@override@JsonKey(name: 'departureTime') final  String? departureTime;
@override@JsonKey(name: 'cumulativePrice', defaultValue: 0.0) final  double? cumulativePrice;
@override@JsonKey() final  bool isConfirmed;

/// Create a copy of StoppageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoppageModelCopyWith<_StoppageModel> get copyWith => __$StoppageModelCopyWithImpl<_StoppageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoppageModelToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'StoppageModel'))
    ..add(DiagnosticsProperty('cityName', cityName))..add(DiagnosticsProperty('arrivalTime', arrivalTime))..add(DiagnosticsProperty('departureTime', departureTime))..add(DiagnosticsProperty('cumulativePrice', cumulativePrice))..add(DiagnosticsProperty('isConfirmed', isConfirmed));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoppageModel&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.departureTime, departureTime) || other.departureTime == departureTime)&&(identical(other.cumulativePrice, cumulativePrice) || other.cumulativePrice == cumulativePrice)&&(identical(other.isConfirmed, isConfirmed) || other.isConfirmed == isConfirmed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cityName,arrivalTime,departureTime,cumulativePrice,isConfirmed);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'StoppageModel(cityName: $cityName, arrivalTime: $arrivalTime, departureTime: $departureTime, cumulativePrice: $cumulativePrice, isConfirmed: $isConfirmed)';
}


}

/// @nodoc
abstract mixin class _$StoppageModelCopyWith<$Res> implements $StoppageModelCopyWith<$Res> {
  factory _$StoppageModelCopyWith(_StoppageModel value, $Res Function(_StoppageModel) _then) = __$StoppageModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'cityName') String? cityName,@JsonKey(name: 'arrivalTime') String? arrivalTime,@JsonKey(name: 'departureTime') String? departureTime,@JsonKey(name: 'cumulativePrice', defaultValue: 0.0) double? cumulativePrice, bool isConfirmed
});




}
/// @nodoc
class __$StoppageModelCopyWithImpl<$Res>
    implements _$StoppageModelCopyWith<$Res> {
  __$StoppageModelCopyWithImpl(this._self, this._then);

  final _StoppageModel _self;
  final $Res Function(_StoppageModel) _then;

/// Create a copy of StoppageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cityName = freezed,Object? arrivalTime = freezed,Object? departureTime = freezed,Object? cumulativePrice = freezed,Object? isConfirmed = null,}) {
  return _then(_StoppageModel(
cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as String?,departureTime: freezed == departureTime ? _self.departureTime : departureTime // ignore: cast_nullable_to_non_nullable
as String?,cumulativePrice: freezed == cumulativePrice ? _self.cumulativePrice : cumulativePrice // ignore: cast_nullable_to_non_nullable
as double?,isConfirmed: null == isConfirmed ? _self.isConfirmed : isConfirmed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

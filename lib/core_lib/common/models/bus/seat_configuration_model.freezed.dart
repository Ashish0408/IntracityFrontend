// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seat_configuration_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SeatConfigurationModel implements DiagnosticableTreeMixin {

@JsonKey(name: 'seatType') String get seatType;@JsonKey(name: 'noOfSeats') int get noOfSeats;@JsonKey(name: 'pricePerSeat') double get pricePerSeat;
/// Create a copy of SeatConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeatConfigurationModelCopyWith<SeatConfigurationModel> get copyWith => _$SeatConfigurationModelCopyWithImpl<SeatConfigurationModel>(this as SeatConfigurationModel, _$identity);

  /// Serializes this SeatConfigurationModel to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SeatConfigurationModel'))
    ..add(DiagnosticsProperty('seatType', seatType))..add(DiagnosticsProperty('noOfSeats', noOfSeats))..add(DiagnosticsProperty('pricePerSeat', pricePerSeat));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeatConfigurationModel&&(identical(other.seatType, seatType) || other.seatType == seatType)&&(identical(other.noOfSeats, noOfSeats) || other.noOfSeats == noOfSeats)&&(identical(other.pricePerSeat, pricePerSeat) || other.pricePerSeat == pricePerSeat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seatType,noOfSeats,pricePerSeat);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SeatConfigurationModel(seatType: $seatType, noOfSeats: $noOfSeats, pricePerSeat: $pricePerSeat)';
}


}

/// @nodoc
abstract mixin class $SeatConfigurationModelCopyWith<$Res>  {
  factory $SeatConfigurationModelCopyWith(SeatConfigurationModel value, $Res Function(SeatConfigurationModel) _then) = _$SeatConfigurationModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'seatType') String seatType,@JsonKey(name: 'noOfSeats') int noOfSeats,@JsonKey(name: 'pricePerSeat') double pricePerSeat
});




}
/// @nodoc
class _$SeatConfigurationModelCopyWithImpl<$Res>
    implements $SeatConfigurationModelCopyWith<$Res> {
  _$SeatConfigurationModelCopyWithImpl(this._self, this._then);

  final SeatConfigurationModel _self;
  final $Res Function(SeatConfigurationModel) _then;

/// Create a copy of SeatConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? seatType = null,Object? noOfSeats = null,Object? pricePerSeat = null,}) {
  return _then(_self.copyWith(
seatType: null == seatType ? _self.seatType : seatType // ignore: cast_nullable_to_non_nullable
as String,noOfSeats: null == noOfSeats ? _self.noOfSeats : noOfSeats // ignore: cast_nullable_to_non_nullable
as int,pricePerSeat: null == pricePerSeat ? _self.pricePerSeat : pricePerSeat // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SeatConfigurationModel].
extension SeatConfigurationModelPatterns on SeatConfigurationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeatConfigurationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeatConfigurationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeatConfigurationModel value)  $default,){
final _that = this;
switch (_that) {
case _SeatConfigurationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeatConfigurationModel value)?  $default,){
final _that = this;
switch (_that) {
case _SeatConfigurationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'seatType')  String seatType, @JsonKey(name: 'noOfSeats')  int noOfSeats, @JsonKey(name: 'pricePerSeat')  double pricePerSeat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeatConfigurationModel() when $default != null:
return $default(_that.seatType,_that.noOfSeats,_that.pricePerSeat);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'seatType')  String seatType, @JsonKey(name: 'noOfSeats')  int noOfSeats, @JsonKey(name: 'pricePerSeat')  double pricePerSeat)  $default,) {final _that = this;
switch (_that) {
case _SeatConfigurationModel():
return $default(_that.seatType,_that.noOfSeats,_that.pricePerSeat);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'seatType')  String seatType, @JsonKey(name: 'noOfSeats')  int noOfSeats, @JsonKey(name: 'pricePerSeat')  double pricePerSeat)?  $default,) {final _that = this;
switch (_that) {
case _SeatConfigurationModel() when $default != null:
return $default(_that.seatType,_that.noOfSeats,_that.pricePerSeat);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeatConfigurationModel with DiagnosticableTreeMixin implements SeatConfigurationModel {
  const _SeatConfigurationModel({@JsonKey(name: 'seatType') required this.seatType, @JsonKey(name: 'noOfSeats') required this.noOfSeats, @JsonKey(name: 'pricePerSeat') required this.pricePerSeat});
  factory _SeatConfigurationModel.fromJson(Map<String, dynamic> json) => _$SeatConfigurationModelFromJson(json);

@override@JsonKey(name: 'seatType') final  String seatType;
@override@JsonKey(name: 'noOfSeats') final  int noOfSeats;
@override@JsonKey(name: 'pricePerSeat') final  double pricePerSeat;

/// Create a copy of SeatConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeatConfigurationModelCopyWith<_SeatConfigurationModel> get copyWith => __$SeatConfigurationModelCopyWithImpl<_SeatConfigurationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeatConfigurationModelToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SeatConfigurationModel'))
    ..add(DiagnosticsProperty('seatType', seatType))..add(DiagnosticsProperty('noOfSeats', noOfSeats))..add(DiagnosticsProperty('pricePerSeat', pricePerSeat));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeatConfigurationModel&&(identical(other.seatType, seatType) || other.seatType == seatType)&&(identical(other.noOfSeats, noOfSeats) || other.noOfSeats == noOfSeats)&&(identical(other.pricePerSeat, pricePerSeat) || other.pricePerSeat == pricePerSeat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seatType,noOfSeats,pricePerSeat);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SeatConfigurationModel(seatType: $seatType, noOfSeats: $noOfSeats, pricePerSeat: $pricePerSeat)';
}


}

/// @nodoc
abstract mixin class _$SeatConfigurationModelCopyWith<$Res> implements $SeatConfigurationModelCopyWith<$Res> {
  factory _$SeatConfigurationModelCopyWith(_SeatConfigurationModel value, $Res Function(_SeatConfigurationModel) _then) = __$SeatConfigurationModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'seatType') String seatType,@JsonKey(name: 'noOfSeats') int noOfSeats,@JsonKey(name: 'pricePerSeat') double pricePerSeat
});




}
/// @nodoc
class __$SeatConfigurationModelCopyWithImpl<$Res>
    implements _$SeatConfigurationModelCopyWith<$Res> {
  __$SeatConfigurationModelCopyWithImpl(this._self, this._then);

  final _SeatConfigurationModel _self;
  final $Res Function(_SeatConfigurationModel) _then;

/// Create a copy of SeatConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? seatType = null,Object? noOfSeats = null,Object? pricePerSeat = null,}) {
  return _then(_SeatConfigurationModel(
seatType: null == seatType ? _self.seatType : seatType // ignore: cast_nullable_to_non_nullable
as String,noOfSeats: null == noOfSeats ? _self.noOfSeats : noOfSeats // ignore: cast_nullable_to_non_nullable
as int,pricePerSeat: null == pricePerSeat ? _self.pricePerSeat : pricePerSeat // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on

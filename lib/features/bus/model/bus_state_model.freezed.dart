// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bus_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BusStateModel {

// required PlatformFile? selectedImage,
 BusModel? get busForUpdate;
/// Create a copy of BusStateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusStateModelCopyWith<BusStateModel> get copyWith => _$BusStateModelCopyWithImpl<BusStateModel>(this as BusStateModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusStateModel&&(identical(other.busForUpdate, busForUpdate) || other.busForUpdate == busForUpdate));
}


@override
int get hashCode => Object.hash(runtimeType,busForUpdate);

@override
String toString() {
  return 'BusStateModel(busForUpdate: $busForUpdate)';
}


}

/// @nodoc
abstract mixin class $BusStateModelCopyWith<$Res>  {
  factory $BusStateModelCopyWith(BusStateModel value, $Res Function(BusStateModel) _then) = _$BusStateModelCopyWithImpl;
@useResult
$Res call({
 BusModel? busForUpdate
});


$BusModelCopyWith<$Res>? get busForUpdate;

}
/// @nodoc
class _$BusStateModelCopyWithImpl<$Res>
    implements $BusStateModelCopyWith<$Res> {
  _$BusStateModelCopyWithImpl(this._self, this._then);

  final BusStateModel _self;
  final $Res Function(BusStateModel) _then;

/// Create a copy of BusStateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? busForUpdate = freezed,}) {
  return _then(_self.copyWith(
busForUpdate: freezed == busForUpdate ? _self.busForUpdate : busForUpdate // ignore: cast_nullable_to_non_nullable
as BusModel?,
  ));
}
/// Create a copy of BusStateModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BusModelCopyWith<$Res>? get busForUpdate {
    if (_self.busForUpdate == null) {
    return null;
  }

  return $BusModelCopyWith<$Res>(_self.busForUpdate!, (value) {
    return _then(_self.copyWith(busForUpdate: value));
  });
}
}


/// Adds pattern-matching-related methods to [BusStateModel].
extension BusStateModelPatterns on BusStateModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusStateModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusStateModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusStateModel value)  $default,){
final _that = this;
switch (_that) {
case _BusStateModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusStateModel value)?  $default,){
final _that = this;
switch (_that) {
case _BusStateModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BusModel? busForUpdate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusStateModel() when $default != null:
return $default(_that.busForUpdate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BusModel? busForUpdate)  $default,) {final _that = this;
switch (_that) {
case _BusStateModel():
return $default(_that.busForUpdate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BusModel? busForUpdate)?  $default,) {final _that = this;
switch (_that) {
case _BusStateModel() when $default != null:
return $default(_that.busForUpdate);case _:
  return null;

}
}

}

/// @nodoc


class _BusStateModel implements BusStateModel {
  const _BusStateModel({required this.busForUpdate});
  

// required PlatformFile? selectedImage,
@override final  BusModel? busForUpdate;

/// Create a copy of BusStateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusStateModelCopyWith<_BusStateModel> get copyWith => __$BusStateModelCopyWithImpl<_BusStateModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusStateModel&&(identical(other.busForUpdate, busForUpdate) || other.busForUpdate == busForUpdate));
}


@override
int get hashCode => Object.hash(runtimeType,busForUpdate);

@override
String toString() {
  return 'BusStateModel(busForUpdate: $busForUpdate)';
}


}

/// @nodoc
abstract mixin class _$BusStateModelCopyWith<$Res> implements $BusStateModelCopyWith<$Res> {
  factory _$BusStateModelCopyWith(_BusStateModel value, $Res Function(_BusStateModel) _then) = __$BusStateModelCopyWithImpl;
@override @useResult
$Res call({
 BusModel? busForUpdate
});


@override $BusModelCopyWith<$Res>? get busForUpdate;

}
/// @nodoc
class __$BusStateModelCopyWithImpl<$Res>
    implements _$BusStateModelCopyWith<$Res> {
  __$BusStateModelCopyWithImpl(this._self, this._then);

  final _BusStateModel _self;
  final $Res Function(_BusStateModel) _then;

/// Create a copy of BusStateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? busForUpdate = freezed,}) {
  return _then(_BusStateModel(
busForUpdate: freezed == busForUpdate ? _self.busForUpdate : busForUpdate // ignore: cast_nullable_to_non_nullable
as BusModel?,
  ));
}

/// Create a copy of BusStateModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BusModelCopyWith<$Res>? get busForUpdate {
    if (_self.busForUpdate == null) {
    return null;
  }

  return $BusModelCopyWith<$Res>(_self.busForUpdate!, (value) {
    return _then(_self.copyWith(busForUpdate: value));
  });
}
}

// dart format on

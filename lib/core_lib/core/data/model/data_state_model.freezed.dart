// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DataStateModel implements DiagnosticableTreeMixin {

 List<BusModel> get allBus; List<BusModel> get filteredBus;
/// Create a copy of DataStateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DataStateModelCopyWith<DataStateModel> get copyWith => _$DataStateModelCopyWithImpl<DataStateModel>(this as DataStateModel, _$identity);

  /// Serializes this DataStateModel to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DataStateModel'))
    ..add(DiagnosticsProperty('allBus', allBus))..add(DiagnosticsProperty('filteredBus', filteredBus));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DataStateModel&&const DeepCollectionEquality().equals(other.allBus, allBus)&&const DeepCollectionEquality().equals(other.filteredBus, filteredBus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(allBus),const DeepCollectionEquality().hash(filteredBus));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DataStateModel(allBus: $allBus, filteredBus: $filteredBus)';
}


}

/// @nodoc
abstract mixin class $DataStateModelCopyWith<$Res>  {
  factory $DataStateModelCopyWith(DataStateModel value, $Res Function(DataStateModel) _then) = _$DataStateModelCopyWithImpl;
@useResult
$Res call({
 List<BusModel> allBus, List<BusModel> filteredBus
});




}
/// @nodoc
class _$DataStateModelCopyWithImpl<$Res>
    implements $DataStateModelCopyWith<$Res> {
  _$DataStateModelCopyWithImpl(this._self, this._then);

  final DataStateModel _self;
  final $Res Function(DataStateModel) _then;

/// Create a copy of DataStateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? allBus = null,Object? filteredBus = null,}) {
  return _then(_self.copyWith(
allBus: null == allBus ? _self.allBus : allBus // ignore: cast_nullable_to_non_nullable
as List<BusModel>,filteredBus: null == filteredBus ? _self.filteredBus : filteredBus // ignore: cast_nullable_to_non_nullable
as List<BusModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [DataStateModel].
extension DataStateModelPatterns on DataStateModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DataStateModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DataStateModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DataStateModel value)  $default,){
final _that = this;
switch (_that) {
case _DataStateModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DataStateModel value)?  $default,){
final _that = this;
switch (_that) {
case _DataStateModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<BusModel> allBus,  List<BusModel> filteredBus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DataStateModel() when $default != null:
return $default(_that.allBus,_that.filteredBus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<BusModel> allBus,  List<BusModel> filteredBus)  $default,) {final _that = this;
switch (_that) {
case _DataStateModel():
return $default(_that.allBus,_that.filteredBus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<BusModel> allBus,  List<BusModel> filteredBus)?  $default,) {final _that = this;
switch (_that) {
case _DataStateModel() when $default != null:
return $default(_that.allBus,_that.filteredBus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DataStateModel with DiagnosticableTreeMixin implements DataStateModel {
  const _DataStateModel({final  List<BusModel> allBus = const [], final  List<BusModel> filteredBus = const []}): _allBus = allBus,_filteredBus = filteredBus;
  factory _DataStateModel.fromJson(Map<String, dynamic> json) => _$DataStateModelFromJson(json);

 final  List<BusModel> _allBus;
@override@JsonKey() List<BusModel> get allBus {
  if (_allBus is EqualUnmodifiableListView) return _allBus;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allBus);
}

 final  List<BusModel> _filteredBus;
@override@JsonKey() List<BusModel> get filteredBus {
  if (_filteredBus is EqualUnmodifiableListView) return _filteredBus;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredBus);
}


/// Create a copy of DataStateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DataStateModelCopyWith<_DataStateModel> get copyWith => __$DataStateModelCopyWithImpl<_DataStateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DataStateModelToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DataStateModel'))
    ..add(DiagnosticsProperty('allBus', allBus))..add(DiagnosticsProperty('filteredBus', filteredBus));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DataStateModel&&const DeepCollectionEquality().equals(other._allBus, _allBus)&&const DeepCollectionEquality().equals(other._filteredBus, _filteredBus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_allBus),const DeepCollectionEquality().hash(_filteredBus));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DataStateModel(allBus: $allBus, filteredBus: $filteredBus)';
}


}

/// @nodoc
abstract mixin class _$DataStateModelCopyWith<$Res> implements $DataStateModelCopyWith<$Res> {
  factory _$DataStateModelCopyWith(_DataStateModel value, $Res Function(_DataStateModel) _then) = __$DataStateModelCopyWithImpl;
@override @useResult
$Res call({
 List<BusModel> allBus, List<BusModel> filteredBus
});




}
/// @nodoc
class __$DataStateModelCopyWithImpl<$Res>
    implements _$DataStateModelCopyWith<$Res> {
  __$DataStateModelCopyWithImpl(this._self, this._then);

  final _DataStateModel _self;
  final $Res Function(_DataStateModel) _then;

/// Create a copy of DataStateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? allBus = null,Object? filteredBus = null,}) {
  return _then(_DataStateModel(
allBus: null == allBus ? _self._allBus : allBus // ignore: cast_nullable_to_non_nullable
as List<BusModel>,filteredBus: null == filteredBus ? _self._filteredBus : filteredBus // ignore: cast_nullable_to_non_nullable
as List<BusModel>,
  ));
}


}

// dart format on

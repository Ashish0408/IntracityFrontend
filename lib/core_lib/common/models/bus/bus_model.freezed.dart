// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bus_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BusModel implements DiagnosticableTreeMixin {

@JsonKey(name: 'id') int? get busId;@JsonKey(name: 'name') String? get busName;@JsonKey(name: 'operator') String? get busOperator;@JsonKey(name: 'fromCity') String? get busFromCity;@JsonKey(name: 'toCity') String? get busToCity;@JsonKey(name: 'departureTime') String? get busDepartureTime;@JsonKey(name: 'arrivalTime') String? get busArrivalTime;@JsonKey(name: 'price') double? get busPrice;@JsonKey(name: 'totalSeats') int? get busTotalSeats;@JsonKey(name: 'availableSeats') int? get busAvailableSeats;@JsonKey(name: 'stoppages') List<StoppageModel>? get busStoppages;@JsonKey(name: 'layoutId', includeIfNull: false) String? get busLayoutId;@JsonKey(name: 'seatConfigurations', includeIfNull: false) List<SeatConfigurationModel>? get busSeatConfigurations;
/// Create a copy of BusModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusModelCopyWith<BusModel> get copyWith => _$BusModelCopyWithImpl<BusModel>(this as BusModel, _$identity);

  /// Serializes this BusModel to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BusModel'))
    ..add(DiagnosticsProperty('busId', busId))..add(DiagnosticsProperty('busName', busName))..add(DiagnosticsProperty('busOperator', busOperator))..add(DiagnosticsProperty('busFromCity', busFromCity))..add(DiagnosticsProperty('busToCity', busToCity))..add(DiagnosticsProperty('busDepartureTime', busDepartureTime))..add(DiagnosticsProperty('busArrivalTime', busArrivalTime))..add(DiagnosticsProperty('busPrice', busPrice))..add(DiagnosticsProperty('busTotalSeats', busTotalSeats))..add(DiagnosticsProperty('busAvailableSeats', busAvailableSeats))..add(DiagnosticsProperty('busStoppages', busStoppages))..add(DiagnosticsProperty('busLayoutId', busLayoutId))..add(DiagnosticsProperty('busSeatConfigurations', busSeatConfigurations));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusModel&&(identical(other.busId, busId) || other.busId == busId)&&(identical(other.busName, busName) || other.busName == busName)&&(identical(other.busOperator, busOperator) || other.busOperator == busOperator)&&(identical(other.busFromCity, busFromCity) || other.busFromCity == busFromCity)&&(identical(other.busToCity, busToCity) || other.busToCity == busToCity)&&(identical(other.busDepartureTime, busDepartureTime) || other.busDepartureTime == busDepartureTime)&&(identical(other.busArrivalTime, busArrivalTime) || other.busArrivalTime == busArrivalTime)&&(identical(other.busPrice, busPrice) || other.busPrice == busPrice)&&(identical(other.busTotalSeats, busTotalSeats) || other.busTotalSeats == busTotalSeats)&&(identical(other.busAvailableSeats, busAvailableSeats) || other.busAvailableSeats == busAvailableSeats)&&const DeepCollectionEquality().equals(other.busStoppages, busStoppages)&&(identical(other.busLayoutId, busLayoutId) || other.busLayoutId == busLayoutId)&&const DeepCollectionEquality().equals(other.busSeatConfigurations, busSeatConfigurations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,busId,busName,busOperator,busFromCity,busToCity,busDepartureTime,busArrivalTime,busPrice,busTotalSeats,busAvailableSeats,const DeepCollectionEquality().hash(busStoppages),busLayoutId,const DeepCollectionEquality().hash(busSeatConfigurations));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BusModel(busId: $busId, busName: $busName, busOperator: $busOperator, busFromCity: $busFromCity, busToCity: $busToCity, busDepartureTime: $busDepartureTime, busArrivalTime: $busArrivalTime, busPrice: $busPrice, busTotalSeats: $busTotalSeats, busAvailableSeats: $busAvailableSeats, busStoppages: $busStoppages, busLayoutId: $busLayoutId, busSeatConfigurations: $busSeatConfigurations)';
}


}

/// @nodoc
abstract mixin class $BusModelCopyWith<$Res>  {
  factory $BusModelCopyWith(BusModel value, $Res Function(BusModel) _then) = _$BusModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') int? busId,@JsonKey(name: 'name') String? busName,@JsonKey(name: 'operator') String? busOperator,@JsonKey(name: 'fromCity') String? busFromCity,@JsonKey(name: 'toCity') String? busToCity,@JsonKey(name: 'departureTime') String? busDepartureTime,@JsonKey(name: 'arrivalTime') String? busArrivalTime,@JsonKey(name: 'price') double? busPrice,@JsonKey(name: 'totalSeats') int? busTotalSeats,@JsonKey(name: 'availableSeats') int? busAvailableSeats,@JsonKey(name: 'stoppages') List<StoppageModel>? busStoppages,@JsonKey(name: 'layoutId', includeIfNull: false) String? busLayoutId,@JsonKey(name: 'seatConfigurations', includeIfNull: false) List<SeatConfigurationModel>? busSeatConfigurations
});




}
/// @nodoc
class _$BusModelCopyWithImpl<$Res>
    implements $BusModelCopyWith<$Res> {
  _$BusModelCopyWithImpl(this._self, this._then);

  final BusModel _self;
  final $Res Function(BusModel) _then;

/// Create a copy of BusModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? busId = freezed,Object? busName = freezed,Object? busOperator = freezed,Object? busFromCity = freezed,Object? busToCity = freezed,Object? busDepartureTime = freezed,Object? busArrivalTime = freezed,Object? busPrice = freezed,Object? busTotalSeats = freezed,Object? busAvailableSeats = freezed,Object? busStoppages = freezed,Object? busLayoutId = freezed,Object? busSeatConfigurations = freezed,}) {
  return _then(_self.copyWith(
busId: freezed == busId ? _self.busId : busId // ignore: cast_nullable_to_non_nullable
as int?,busName: freezed == busName ? _self.busName : busName // ignore: cast_nullable_to_non_nullable
as String?,busOperator: freezed == busOperator ? _self.busOperator : busOperator // ignore: cast_nullable_to_non_nullable
as String?,busFromCity: freezed == busFromCity ? _self.busFromCity : busFromCity // ignore: cast_nullable_to_non_nullable
as String?,busToCity: freezed == busToCity ? _self.busToCity : busToCity // ignore: cast_nullable_to_non_nullable
as String?,busDepartureTime: freezed == busDepartureTime ? _self.busDepartureTime : busDepartureTime // ignore: cast_nullable_to_non_nullable
as String?,busArrivalTime: freezed == busArrivalTime ? _self.busArrivalTime : busArrivalTime // ignore: cast_nullable_to_non_nullable
as String?,busPrice: freezed == busPrice ? _self.busPrice : busPrice // ignore: cast_nullable_to_non_nullable
as double?,busTotalSeats: freezed == busTotalSeats ? _self.busTotalSeats : busTotalSeats // ignore: cast_nullable_to_non_nullable
as int?,busAvailableSeats: freezed == busAvailableSeats ? _self.busAvailableSeats : busAvailableSeats // ignore: cast_nullable_to_non_nullable
as int?,busStoppages: freezed == busStoppages ? _self.busStoppages : busStoppages // ignore: cast_nullable_to_non_nullable
as List<StoppageModel>?,busLayoutId: freezed == busLayoutId ? _self.busLayoutId : busLayoutId // ignore: cast_nullable_to_non_nullable
as String?,busSeatConfigurations: freezed == busSeatConfigurations ? _self.busSeatConfigurations : busSeatConfigurations // ignore: cast_nullable_to_non_nullable
as List<SeatConfigurationModel>?,
  ));
}

}


/// Adds pattern-matching-related methods to [BusModel].
extension BusModelPatterns on BusModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusModel value)  $default,){
final _that = this;
switch (_that) {
case _BusModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusModel value)?  $default,){
final _that = this;
switch (_that) {
case _BusModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int? busId, @JsonKey(name: 'name')  String? busName, @JsonKey(name: 'operator')  String? busOperator, @JsonKey(name: 'fromCity')  String? busFromCity, @JsonKey(name: 'toCity')  String? busToCity, @JsonKey(name: 'departureTime')  String? busDepartureTime, @JsonKey(name: 'arrivalTime')  String? busArrivalTime, @JsonKey(name: 'price')  double? busPrice, @JsonKey(name: 'totalSeats')  int? busTotalSeats, @JsonKey(name: 'availableSeats')  int? busAvailableSeats, @JsonKey(name: 'stoppages')  List<StoppageModel>? busStoppages, @JsonKey(name: 'layoutId', includeIfNull: false)  String? busLayoutId, @JsonKey(name: 'seatConfigurations', includeIfNull: false)  List<SeatConfigurationModel>? busSeatConfigurations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusModel() when $default != null:
return $default(_that.busId,_that.busName,_that.busOperator,_that.busFromCity,_that.busToCity,_that.busDepartureTime,_that.busArrivalTime,_that.busPrice,_that.busTotalSeats,_that.busAvailableSeats,_that.busStoppages,_that.busLayoutId,_that.busSeatConfigurations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int? busId, @JsonKey(name: 'name')  String? busName, @JsonKey(name: 'operator')  String? busOperator, @JsonKey(name: 'fromCity')  String? busFromCity, @JsonKey(name: 'toCity')  String? busToCity, @JsonKey(name: 'departureTime')  String? busDepartureTime, @JsonKey(name: 'arrivalTime')  String? busArrivalTime, @JsonKey(name: 'price')  double? busPrice, @JsonKey(name: 'totalSeats')  int? busTotalSeats, @JsonKey(name: 'availableSeats')  int? busAvailableSeats, @JsonKey(name: 'stoppages')  List<StoppageModel>? busStoppages, @JsonKey(name: 'layoutId', includeIfNull: false)  String? busLayoutId, @JsonKey(name: 'seatConfigurations', includeIfNull: false)  List<SeatConfigurationModel>? busSeatConfigurations)  $default,) {final _that = this;
switch (_that) {
case _BusModel():
return $default(_that.busId,_that.busName,_that.busOperator,_that.busFromCity,_that.busToCity,_that.busDepartureTime,_that.busArrivalTime,_that.busPrice,_that.busTotalSeats,_that.busAvailableSeats,_that.busStoppages,_that.busLayoutId,_that.busSeatConfigurations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  int? busId, @JsonKey(name: 'name')  String? busName, @JsonKey(name: 'operator')  String? busOperator, @JsonKey(name: 'fromCity')  String? busFromCity, @JsonKey(name: 'toCity')  String? busToCity, @JsonKey(name: 'departureTime')  String? busDepartureTime, @JsonKey(name: 'arrivalTime')  String? busArrivalTime, @JsonKey(name: 'price')  double? busPrice, @JsonKey(name: 'totalSeats')  int? busTotalSeats, @JsonKey(name: 'availableSeats')  int? busAvailableSeats, @JsonKey(name: 'stoppages')  List<StoppageModel>? busStoppages, @JsonKey(name: 'layoutId', includeIfNull: false)  String? busLayoutId, @JsonKey(name: 'seatConfigurations', includeIfNull: false)  List<SeatConfigurationModel>? busSeatConfigurations)?  $default,) {final _that = this;
switch (_that) {
case _BusModel() when $default != null:
return $default(_that.busId,_that.busName,_that.busOperator,_that.busFromCity,_that.busToCity,_that.busDepartureTime,_that.busArrivalTime,_that.busPrice,_that.busTotalSeats,_that.busAvailableSeats,_that.busStoppages,_that.busLayoutId,_that.busSeatConfigurations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusModel with DiagnosticableTreeMixin implements BusModel {
  const _BusModel({@JsonKey(name: 'id') this.busId, @JsonKey(name: 'name') this.busName, @JsonKey(name: 'operator') this.busOperator, @JsonKey(name: 'fromCity') this.busFromCity, @JsonKey(name: 'toCity') this.busToCity, @JsonKey(name: 'departureTime') this.busDepartureTime, @JsonKey(name: 'arrivalTime') this.busArrivalTime, @JsonKey(name: 'price') this.busPrice, @JsonKey(name: 'totalSeats') this.busTotalSeats, @JsonKey(name: 'availableSeats') this.busAvailableSeats, @JsonKey(name: 'stoppages') final  List<StoppageModel>? busStoppages, @JsonKey(name: 'layoutId', includeIfNull: false) this.busLayoutId, @JsonKey(name: 'seatConfigurations', includeIfNull: false) final  List<SeatConfigurationModel>? busSeatConfigurations}): _busStoppages = busStoppages,_busSeatConfigurations = busSeatConfigurations;
  factory _BusModel.fromJson(Map<String, dynamic> json) => _$BusModelFromJson(json);

@override@JsonKey(name: 'id') final  int? busId;
@override@JsonKey(name: 'name') final  String? busName;
@override@JsonKey(name: 'operator') final  String? busOperator;
@override@JsonKey(name: 'fromCity') final  String? busFromCity;
@override@JsonKey(name: 'toCity') final  String? busToCity;
@override@JsonKey(name: 'departureTime') final  String? busDepartureTime;
@override@JsonKey(name: 'arrivalTime') final  String? busArrivalTime;
@override@JsonKey(name: 'price') final  double? busPrice;
@override@JsonKey(name: 'totalSeats') final  int? busTotalSeats;
@override@JsonKey(name: 'availableSeats') final  int? busAvailableSeats;
 final  List<StoppageModel>? _busStoppages;
@override@JsonKey(name: 'stoppages') List<StoppageModel>? get busStoppages {
  final value = _busStoppages;
  if (value == null) return null;
  if (_busStoppages is EqualUnmodifiableListView) return _busStoppages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'layoutId', includeIfNull: false) final  String? busLayoutId;
 final  List<SeatConfigurationModel>? _busSeatConfigurations;
@override@JsonKey(name: 'seatConfigurations', includeIfNull: false) List<SeatConfigurationModel>? get busSeatConfigurations {
  final value = _busSeatConfigurations;
  if (value == null) return null;
  if (_busSeatConfigurations is EqualUnmodifiableListView) return _busSeatConfigurations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of BusModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusModelCopyWith<_BusModel> get copyWith => __$BusModelCopyWithImpl<_BusModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusModelToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BusModel'))
    ..add(DiagnosticsProperty('busId', busId))..add(DiagnosticsProperty('busName', busName))..add(DiagnosticsProperty('busOperator', busOperator))..add(DiagnosticsProperty('busFromCity', busFromCity))..add(DiagnosticsProperty('busToCity', busToCity))..add(DiagnosticsProperty('busDepartureTime', busDepartureTime))..add(DiagnosticsProperty('busArrivalTime', busArrivalTime))..add(DiagnosticsProperty('busPrice', busPrice))..add(DiagnosticsProperty('busTotalSeats', busTotalSeats))..add(DiagnosticsProperty('busAvailableSeats', busAvailableSeats))..add(DiagnosticsProperty('busStoppages', busStoppages))..add(DiagnosticsProperty('busLayoutId', busLayoutId))..add(DiagnosticsProperty('busSeatConfigurations', busSeatConfigurations));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusModel&&(identical(other.busId, busId) || other.busId == busId)&&(identical(other.busName, busName) || other.busName == busName)&&(identical(other.busOperator, busOperator) || other.busOperator == busOperator)&&(identical(other.busFromCity, busFromCity) || other.busFromCity == busFromCity)&&(identical(other.busToCity, busToCity) || other.busToCity == busToCity)&&(identical(other.busDepartureTime, busDepartureTime) || other.busDepartureTime == busDepartureTime)&&(identical(other.busArrivalTime, busArrivalTime) || other.busArrivalTime == busArrivalTime)&&(identical(other.busPrice, busPrice) || other.busPrice == busPrice)&&(identical(other.busTotalSeats, busTotalSeats) || other.busTotalSeats == busTotalSeats)&&(identical(other.busAvailableSeats, busAvailableSeats) || other.busAvailableSeats == busAvailableSeats)&&const DeepCollectionEquality().equals(other._busStoppages, _busStoppages)&&(identical(other.busLayoutId, busLayoutId) || other.busLayoutId == busLayoutId)&&const DeepCollectionEquality().equals(other._busSeatConfigurations, _busSeatConfigurations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,busId,busName,busOperator,busFromCity,busToCity,busDepartureTime,busArrivalTime,busPrice,busTotalSeats,busAvailableSeats,const DeepCollectionEquality().hash(_busStoppages),busLayoutId,const DeepCollectionEquality().hash(_busSeatConfigurations));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BusModel(busId: $busId, busName: $busName, busOperator: $busOperator, busFromCity: $busFromCity, busToCity: $busToCity, busDepartureTime: $busDepartureTime, busArrivalTime: $busArrivalTime, busPrice: $busPrice, busTotalSeats: $busTotalSeats, busAvailableSeats: $busAvailableSeats, busStoppages: $busStoppages, busLayoutId: $busLayoutId, busSeatConfigurations: $busSeatConfigurations)';
}


}

/// @nodoc
abstract mixin class _$BusModelCopyWith<$Res> implements $BusModelCopyWith<$Res> {
  factory _$BusModelCopyWith(_BusModel value, $Res Function(_BusModel) _then) = __$BusModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') int? busId,@JsonKey(name: 'name') String? busName,@JsonKey(name: 'operator') String? busOperator,@JsonKey(name: 'fromCity') String? busFromCity,@JsonKey(name: 'toCity') String? busToCity,@JsonKey(name: 'departureTime') String? busDepartureTime,@JsonKey(name: 'arrivalTime') String? busArrivalTime,@JsonKey(name: 'price') double? busPrice,@JsonKey(name: 'totalSeats') int? busTotalSeats,@JsonKey(name: 'availableSeats') int? busAvailableSeats,@JsonKey(name: 'stoppages') List<StoppageModel>? busStoppages,@JsonKey(name: 'layoutId', includeIfNull: false) String? busLayoutId,@JsonKey(name: 'seatConfigurations', includeIfNull: false) List<SeatConfigurationModel>? busSeatConfigurations
});




}
/// @nodoc
class __$BusModelCopyWithImpl<$Res>
    implements _$BusModelCopyWith<$Res> {
  __$BusModelCopyWithImpl(this._self, this._then);

  final _BusModel _self;
  final $Res Function(_BusModel) _then;

/// Create a copy of BusModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? busId = freezed,Object? busName = freezed,Object? busOperator = freezed,Object? busFromCity = freezed,Object? busToCity = freezed,Object? busDepartureTime = freezed,Object? busArrivalTime = freezed,Object? busPrice = freezed,Object? busTotalSeats = freezed,Object? busAvailableSeats = freezed,Object? busStoppages = freezed,Object? busLayoutId = freezed,Object? busSeatConfigurations = freezed,}) {
  return _then(_BusModel(
busId: freezed == busId ? _self.busId : busId // ignore: cast_nullable_to_non_nullable
as int?,busName: freezed == busName ? _self.busName : busName // ignore: cast_nullable_to_non_nullable
as String?,busOperator: freezed == busOperator ? _self.busOperator : busOperator // ignore: cast_nullable_to_non_nullable
as String?,busFromCity: freezed == busFromCity ? _self.busFromCity : busFromCity // ignore: cast_nullable_to_non_nullable
as String?,busToCity: freezed == busToCity ? _self.busToCity : busToCity // ignore: cast_nullable_to_non_nullable
as String?,busDepartureTime: freezed == busDepartureTime ? _self.busDepartureTime : busDepartureTime // ignore: cast_nullable_to_non_nullable
as String?,busArrivalTime: freezed == busArrivalTime ? _self.busArrivalTime : busArrivalTime // ignore: cast_nullable_to_non_nullable
as String?,busPrice: freezed == busPrice ? _self.busPrice : busPrice // ignore: cast_nullable_to_non_nullable
as double?,busTotalSeats: freezed == busTotalSeats ? _self.busTotalSeats : busTotalSeats // ignore: cast_nullable_to_non_nullable
as int?,busAvailableSeats: freezed == busAvailableSeats ? _self.busAvailableSeats : busAvailableSeats // ignore: cast_nullable_to_non_nullable
as int?,busStoppages: freezed == busStoppages ? _self._busStoppages : busStoppages // ignore: cast_nullable_to_non_nullable
as List<StoppageModel>?,busLayoutId: freezed == busLayoutId ? _self.busLayoutId : busLayoutId // ignore: cast_nullable_to_non_nullable
as String?,busSeatConfigurations: freezed == busSeatConfigurations ? _self._busSeatConfigurations : busSeatConfigurations // ignore: cast_nullable_to_non_nullable
as List<SeatConfigurationModel>?,
  ));
}


}

// dart format on

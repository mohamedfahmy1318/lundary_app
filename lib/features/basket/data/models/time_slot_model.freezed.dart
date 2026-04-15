// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_slot_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TimeSlotModel {

 String get id;@JsonKey(name: 'start_time') String get startTime;@JsonKey(name: 'end_time') String get endTime; String get type;@JsonKey(name: 'max_orders') String get maxOrders;@JsonKey(name: 'available_days') String get availableDays;@JsonKey(name: 'is_active') bool get isActive;
/// Create a copy of TimeSlotModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimeSlotModelCopyWith<TimeSlotModel> get copyWith => _$TimeSlotModelCopyWithImpl<TimeSlotModel>(this as TimeSlotModel, _$identity);

  /// Serializes this TimeSlotModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeSlotModel&&(identical(other.id, id) || other.id == id)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.type, type) || other.type == type)&&(identical(other.maxOrders, maxOrders) || other.maxOrders == maxOrders)&&(identical(other.availableDays, availableDays) || other.availableDays == availableDays)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startTime,endTime,type,maxOrders,availableDays,isActive);

@override
String toString() {
  return 'TimeSlotModel(id: $id, startTime: $startTime, endTime: $endTime, type: $type, maxOrders: $maxOrders, availableDays: $availableDays, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $TimeSlotModelCopyWith<$Res>  {
  factory $TimeSlotModelCopyWith(TimeSlotModel value, $Res Function(TimeSlotModel) _then) = _$TimeSlotModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'start_time') String startTime,@JsonKey(name: 'end_time') String endTime, String type,@JsonKey(name: 'max_orders') String maxOrders,@JsonKey(name: 'available_days') String availableDays,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class _$TimeSlotModelCopyWithImpl<$Res>
    implements $TimeSlotModelCopyWith<$Res> {
  _$TimeSlotModelCopyWithImpl(this._self, this._then);

  final TimeSlotModel _self;
  final $Res Function(TimeSlotModel) _then;

/// Create a copy of TimeSlotModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? startTime = null,Object? endTime = null,Object? type = null,Object? maxOrders = null,Object? availableDays = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,maxOrders: null == maxOrders ? _self.maxOrders : maxOrders // ignore: cast_nullable_to_non_nullable
as String,availableDays: null == availableDays ? _self.availableDays : availableDays // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TimeSlotModel].
extension TimeSlotModelPatterns on TimeSlotModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimeSlotModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimeSlotModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimeSlotModel value)  $default,){
final _that = this;
switch (_that) {
case _TimeSlotModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimeSlotModel value)?  $default,){
final _that = this;
switch (_that) {
case _TimeSlotModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'start_time')  String startTime, @JsonKey(name: 'end_time')  String endTime,  String type, @JsonKey(name: 'max_orders')  String maxOrders, @JsonKey(name: 'available_days')  String availableDays, @JsonKey(name: 'is_active')  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimeSlotModel() when $default != null:
return $default(_that.id,_that.startTime,_that.endTime,_that.type,_that.maxOrders,_that.availableDays,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'start_time')  String startTime, @JsonKey(name: 'end_time')  String endTime,  String type, @JsonKey(name: 'max_orders')  String maxOrders, @JsonKey(name: 'available_days')  String availableDays, @JsonKey(name: 'is_active')  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _TimeSlotModel():
return $default(_that.id,_that.startTime,_that.endTime,_that.type,_that.maxOrders,_that.availableDays,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'start_time')  String startTime, @JsonKey(name: 'end_time')  String endTime,  String type, @JsonKey(name: 'max_orders')  String maxOrders, @JsonKey(name: 'available_days')  String availableDays, @JsonKey(name: 'is_active')  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _TimeSlotModel() when $default != null:
return $default(_that.id,_that.startTime,_that.endTime,_that.type,_that.maxOrders,_that.availableDays,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TimeSlotModel extends TimeSlotModel {
  const _TimeSlotModel({required this.id, @JsonKey(name: 'start_time') required this.startTime, @JsonKey(name: 'end_time') required this.endTime, required this.type, @JsonKey(name: 'max_orders') required this.maxOrders, @JsonKey(name: 'available_days') required this.availableDays, @JsonKey(name: 'is_active') required this.isActive}): super._();
  factory _TimeSlotModel.fromJson(Map<String, dynamic> json) => _$TimeSlotModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'start_time') final  String startTime;
@override@JsonKey(name: 'end_time') final  String endTime;
@override final  String type;
@override@JsonKey(name: 'max_orders') final  String maxOrders;
@override@JsonKey(name: 'available_days') final  String availableDays;
@override@JsonKey(name: 'is_active') final  bool isActive;

/// Create a copy of TimeSlotModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimeSlotModelCopyWith<_TimeSlotModel> get copyWith => __$TimeSlotModelCopyWithImpl<_TimeSlotModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimeSlotModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimeSlotModel&&(identical(other.id, id) || other.id == id)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.type, type) || other.type == type)&&(identical(other.maxOrders, maxOrders) || other.maxOrders == maxOrders)&&(identical(other.availableDays, availableDays) || other.availableDays == availableDays)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startTime,endTime,type,maxOrders,availableDays,isActive);

@override
String toString() {
  return 'TimeSlotModel(id: $id, startTime: $startTime, endTime: $endTime, type: $type, maxOrders: $maxOrders, availableDays: $availableDays, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$TimeSlotModelCopyWith<$Res> implements $TimeSlotModelCopyWith<$Res> {
  factory _$TimeSlotModelCopyWith(_TimeSlotModel value, $Res Function(_TimeSlotModel) _then) = __$TimeSlotModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'start_time') String startTime,@JsonKey(name: 'end_time') String endTime, String type,@JsonKey(name: 'max_orders') String maxOrders,@JsonKey(name: 'available_days') String availableDays,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class __$TimeSlotModelCopyWithImpl<$Res>
    implements _$TimeSlotModelCopyWith<$Res> {
  __$TimeSlotModelCopyWithImpl(this._self, this._then);

  final _TimeSlotModel _self;
  final $Res Function(_TimeSlotModel) _then;

/// Create a copy of TimeSlotModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? startTime = null,Object? endTime = null,Object? type = null,Object? maxOrders = null,Object? availableDays = null,Object? isActive = null,}) {
  return _then(_TimeSlotModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,maxOrders: null == maxOrders ? _self.maxOrders : maxOrders // ignore: cast_nullable_to_non_nullable
as String,availableDays: null == availableDays ? _self.availableDays : availableDays // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

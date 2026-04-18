// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_order_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateOrderRequestModel {

 List<CartItemModel> get items;@JsonKey(name: 'pickup_date') String get pickupDate;@JsonKey(name: 'pickup_time_slot') String get pickupTimeSlot;@JsonKey(name: 'delivery_date') String get deliveryDate;@JsonKey(name: 'delivery_time_slot') String get deliveryTimeSlot;@JsonKey(name: 'pickup_address') String get pickupAddress;@JsonKey(name: 'delivery_address') String get deliveryAddress;@JsonKey(name: 'payment_method') String get paymentMethod;@JsonKey(name: 'is_express') bool get isExpress;@JsonKey(name: 'promo_code') String? get promoCode;@JsonKey(name: 'notes_pickup') String? get notesPickup;@JsonKey(name: 'notes_delivery') String? get notesDelivery;
/// Create a copy of CreateOrderRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateOrderRequestModelCopyWith<CreateOrderRequestModel> get copyWith => _$CreateOrderRequestModelCopyWithImpl<CreateOrderRequestModel>(this as CreateOrderRequestModel, _$identity);

  /// Serializes this CreateOrderRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateOrderRequestModel&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.pickupDate, pickupDate) || other.pickupDate == pickupDate)&&(identical(other.pickupTimeSlot, pickupTimeSlot) || other.pickupTimeSlot == pickupTimeSlot)&&(identical(other.deliveryDate, deliveryDate) || other.deliveryDate == deliveryDate)&&(identical(other.deliveryTimeSlot, deliveryTimeSlot) || other.deliveryTimeSlot == deliveryTimeSlot)&&(identical(other.pickupAddress, pickupAddress) || other.pickupAddress == pickupAddress)&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.isExpress, isExpress) || other.isExpress == isExpress)&&(identical(other.promoCode, promoCode) || other.promoCode == promoCode)&&(identical(other.notesPickup, notesPickup) || other.notesPickup == notesPickup)&&(identical(other.notesDelivery, notesDelivery) || other.notesDelivery == notesDelivery));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),pickupDate,pickupTimeSlot,deliveryDate,deliveryTimeSlot,pickupAddress,deliveryAddress,paymentMethod,isExpress,promoCode,notesPickup,notesDelivery);

@override
String toString() {
  return 'CreateOrderRequestModel(items: $items, pickupDate: $pickupDate, pickupTimeSlot: $pickupTimeSlot, deliveryDate: $deliveryDate, deliveryTimeSlot: $deliveryTimeSlot, pickupAddress: $pickupAddress, deliveryAddress: $deliveryAddress, paymentMethod: $paymentMethod, isExpress: $isExpress, promoCode: $promoCode, notesPickup: $notesPickup, notesDelivery: $notesDelivery)';
}


}

/// @nodoc
abstract mixin class $CreateOrderRequestModelCopyWith<$Res>  {
  factory $CreateOrderRequestModelCopyWith(CreateOrderRequestModel value, $Res Function(CreateOrderRequestModel) _then) = _$CreateOrderRequestModelCopyWithImpl;
@useResult
$Res call({
 List<CartItemModel> items,@JsonKey(name: 'pickup_date') String pickupDate,@JsonKey(name: 'pickup_time_slot') String pickupTimeSlot,@JsonKey(name: 'delivery_date') String deliveryDate,@JsonKey(name: 'delivery_time_slot') String deliveryTimeSlot,@JsonKey(name: 'pickup_address') String pickupAddress,@JsonKey(name: 'delivery_address') String deliveryAddress,@JsonKey(name: 'payment_method') String paymentMethod,@JsonKey(name: 'is_express') bool isExpress,@JsonKey(name: 'promo_code') String? promoCode,@JsonKey(name: 'notes_pickup') String? notesPickup,@JsonKey(name: 'notes_delivery') String? notesDelivery
});




}
/// @nodoc
class _$CreateOrderRequestModelCopyWithImpl<$Res>
    implements $CreateOrderRequestModelCopyWith<$Res> {
  _$CreateOrderRequestModelCopyWithImpl(this._self, this._then);

  final CreateOrderRequestModel _self;
  final $Res Function(CreateOrderRequestModel) _then;

/// Create a copy of CreateOrderRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? pickupDate = null,Object? pickupTimeSlot = null,Object? deliveryDate = null,Object? deliveryTimeSlot = null,Object? pickupAddress = null,Object? deliveryAddress = null,Object? paymentMethod = null,Object? isExpress = null,Object? promoCode = freezed,Object? notesPickup = freezed,Object? notesDelivery = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CartItemModel>,pickupDate: null == pickupDate ? _self.pickupDate : pickupDate // ignore: cast_nullable_to_non_nullable
as String,pickupTimeSlot: null == pickupTimeSlot ? _self.pickupTimeSlot : pickupTimeSlot // ignore: cast_nullable_to_non_nullable
as String,deliveryDate: null == deliveryDate ? _self.deliveryDate : deliveryDate // ignore: cast_nullable_to_non_nullable
as String,deliveryTimeSlot: null == deliveryTimeSlot ? _self.deliveryTimeSlot : deliveryTimeSlot // ignore: cast_nullable_to_non_nullable
as String,pickupAddress: null == pickupAddress ? _self.pickupAddress : pickupAddress // ignore: cast_nullable_to_non_nullable
as String,deliveryAddress: null == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,isExpress: null == isExpress ? _self.isExpress : isExpress // ignore: cast_nullable_to_non_nullable
as bool,promoCode: freezed == promoCode ? _self.promoCode : promoCode // ignore: cast_nullable_to_non_nullable
as String?,notesPickup: freezed == notesPickup ? _self.notesPickup : notesPickup // ignore: cast_nullable_to_non_nullable
as String?,notesDelivery: freezed == notesDelivery ? _self.notesDelivery : notesDelivery // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateOrderRequestModel].
extension CreateOrderRequestModelPatterns on CreateOrderRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateOrderRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateOrderRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateOrderRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _CreateOrderRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateOrderRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _CreateOrderRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CartItemModel> items, @JsonKey(name: 'pickup_date')  String pickupDate, @JsonKey(name: 'pickup_time_slot')  String pickupTimeSlot, @JsonKey(name: 'delivery_date')  String deliveryDate, @JsonKey(name: 'delivery_time_slot')  String deliveryTimeSlot, @JsonKey(name: 'pickup_address')  String pickupAddress, @JsonKey(name: 'delivery_address')  String deliveryAddress, @JsonKey(name: 'payment_method')  String paymentMethod, @JsonKey(name: 'is_express')  bool isExpress, @JsonKey(name: 'promo_code')  String? promoCode, @JsonKey(name: 'notes_pickup')  String? notesPickup, @JsonKey(name: 'notes_delivery')  String? notesDelivery)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateOrderRequestModel() when $default != null:
return $default(_that.items,_that.pickupDate,_that.pickupTimeSlot,_that.deliveryDate,_that.deliveryTimeSlot,_that.pickupAddress,_that.deliveryAddress,_that.paymentMethod,_that.isExpress,_that.promoCode,_that.notesPickup,_that.notesDelivery);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CartItemModel> items, @JsonKey(name: 'pickup_date')  String pickupDate, @JsonKey(name: 'pickup_time_slot')  String pickupTimeSlot, @JsonKey(name: 'delivery_date')  String deliveryDate, @JsonKey(name: 'delivery_time_slot')  String deliveryTimeSlot, @JsonKey(name: 'pickup_address')  String pickupAddress, @JsonKey(name: 'delivery_address')  String deliveryAddress, @JsonKey(name: 'payment_method')  String paymentMethod, @JsonKey(name: 'is_express')  bool isExpress, @JsonKey(name: 'promo_code')  String? promoCode, @JsonKey(name: 'notes_pickup')  String? notesPickup, @JsonKey(name: 'notes_delivery')  String? notesDelivery)  $default,) {final _that = this;
switch (_that) {
case _CreateOrderRequestModel():
return $default(_that.items,_that.pickupDate,_that.pickupTimeSlot,_that.deliveryDate,_that.deliveryTimeSlot,_that.pickupAddress,_that.deliveryAddress,_that.paymentMethod,_that.isExpress,_that.promoCode,_that.notesPickup,_that.notesDelivery);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CartItemModel> items, @JsonKey(name: 'pickup_date')  String pickupDate, @JsonKey(name: 'pickup_time_slot')  String pickupTimeSlot, @JsonKey(name: 'delivery_date')  String deliveryDate, @JsonKey(name: 'delivery_time_slot')  String deliveryTimeSlot, @JsonKey(name: 'pickup_address')  String pickupAddress, @JsonKey(name: 'delivery_address')  String deliveryAddress, @JsonKey(name: 'payment_method')  String paymentMethod, @JsonKey(name: 'is_express')  bool isExpress, @JsonKey(name: 'promo_code')  String? promoCode, @JsonKey(name: 'notes_pickup')  String? notesPickup, @JsonKey(name: 'notes_delivery')  String? notesDelivery)?  $default,) {final _that = this;
switch (_that) {
case _CreateOrderRequestModel() when $default != null:
return $default(_that.items,_that.pickupDate,_that.pickupTimeSlot,_that.deliveryDate,_that.deliveryTimeSlot,_that.pickupAddress,_that.deliveryAddress,_that.paymentMethod,_that.isExpress,_that.promoCode,_that.notesPickup,_that.notesDelivery);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateOrderRequestModel extends CreateOrderRequestModel {
  const _CreateOrderRequestModel({required final  List<CartItemModel> items, @JsonKey(name: 'pickup_date') required this.pickupDate, @JsonKey(name: 'pickup_time_slot') required this.pickupTimeSlot, @JsonKey(name: 'delivery_date') required this.deliveryDate, @JsonKey(name: 'delivery_time_slot') required this.deliveryTimeSlot, @JsonKey(name: 'pickup_address') required this.pickupAddress, @JsonKey(name: 'delivery_address') required this.deliveryAddress, @JsonKey(name: 'payment_method') required this.paymentMethod, @JsonKey(name: 'is_express') this.isExpress = false, @JsonKey(name: 'promo_code') this.promoCode, @JsonKey(name: 'notes_pickup') this.notesPickup, @JsonKey(name: 'notes_delivery') this.notesDelivery}): _items = items,super._();
  factory _CreateOrderRequestModel.fromJson(Map<String, dynamic> json) => _$CreateOrderRequestModelFromJson(json);

 final  List<CartItemModel> _items;
@override List<CartItemModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey(name: 'pickup_date') final  String pickupDate;
@override@JsonKey(name: 'pickup_time_slot') final  String pickupTimeSlot;
@override@JsonKey(name: 'delivery_date') final  String deliveryDate;
@override@JsonKey(name: 'delivery_time_slot') final  String deliveryTimeSlot;
@override@JsonKey(name: 'pickup_address') final  String pickupAddress;
@override@JsonKey(name: 'delivery_address') final  String deliveryAddress;
@override@JsonKey(name: 'payment_method') final  String paymentMethod;
@override@JsonKey(name: 'is_express') final  bool isExpress;
@override@JsonKey(name: 'promo_code') final  String? promoCode;
@override@JsonKey(name: 'notes_pickup') final  String? notesPickup;
@override@JsonKey(name: 'notes_delivery') final  String? notesDelivery;

/// Create a copy of CreateOrderRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateOrderRequestModelCopyWith<_CreateOrderRequestModel> get copyWith => __$CreateOrderRequestModelCopyWithImpl<_CreateOrderRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateOrderRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateOrderRequestModel&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.pickupDate, pickupDate) || other.pickupDate == pickupDate)&&(identical(other.pickupTimeSlot, pickupTimeSlot) || other.pickupTimeSlot == pickupTimeSlot)&&(identical(other.deliveryDate, deliveryDate) || other.deliveryDate == deliveryDate)&&(identical(other.deliveryTimeSlot, deliveryTimeSlot) || other.deliveryTimeSlot == deliveryTimeSlot)&&(identical(other.pickupAddress, pickupAddress) || other.pickupAddress == pickupAddress)&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.isExpress, isExpress) || other.isExpress == isExpress)&&(identical(other.promoCode, promoCode) || other.promoCode == promoCode)&&(identical(other.notesPickup, notesPickup) || other.notesPickup == notesPickup)&&(identical(other.notesDelivery, notesDelivery) || other.notesDelivery == notesDelivery));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),pickupDate,pickupTimeSlot,deliveryDate,deliveryTimeSlot,pickupAddress,deliveryAddress,paymentMethod,isExpress,promoCode,notesPickup,notesDelivery);

@override
String toString() {
  return 'CreateOrderRequestModel(items: $items, pickupDate: $pickupDate, pickupTimeSlot: $pickupTimeSlot, deliveryDate: $deliveryDate, deliveryTimeSlot: $deliveryTimeSlot, pickupAddress: $pickupAddress, deliveryAddress: $deliveryAddress, paymentMethod: $paymentMethod, isExpress: $isExpress, promoCode: $promoCode, notesPickup: $notesPickup, notesDelivery: $notesDelivery)';
}


}

/// @nodoc
abstract mixin class _$CreateOrderRequestModelCopyWith<$Res> implements $CreateOrderRequestModelCopyWith<$Res> {
  factory _$CreateOrderRequestModelCopyWith(_CreateOrderRequestModel value, $Res Function(_CreateOrderRequestModel) _then) = __$CreateOrderRequestModelCopyWithImpl;
@override @useResult
$Res call({
 List<CartItemModel> items,@JsonKey(name: 'pickup_date') String pickupDate,@JsonKey(name: 'pickup_time_slot') String pickupTimeSlot,@JsonKey(name: 'delivery_date') String deliveryDate,@JsonKey(name: 'delivery_time_slot') String deliveryTimeSlot,@JsonKey(name: 'pickup_address') String pickupAddress,@JsonKey(name: 'delivery_address') String deliveryAddress,@JsonKey(name: 'payment_method') String paymentMethod,@JsonKey(name: 'is_express') bool isExpress,@JsonKey(name: 'promo_code') String? promoCode,@JsonKey(name: 'notes_pickup') String? notesPickup,@JsonKey(name: 'notes_delivery') String? notesDelivery
});




}
/// @nodoc
class __$CreateOrderRequestModelCopyWithImpl<$Res>
    implements _$CreateOrderRequestModelCopyWith<$Res> {
  __$CreateOrderRequestModelCopyWithImpl(this._self, this._then);

  final _CreateOrderRequestModel _self;
  final $Res Function(_CreateOrderRequestModel) _then;

/// Create a copy of CreateOrderRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? pickupDate = null,Object? pickupTimeSlot = null,Object? deliveryDate = null,Object? deliveryTimeSlot = null,Object? pickupAddress = null,Object? deliveryAddress = null,Object? paymentMethod = null,Object? isExpress = null,Object? promoCode = freezed,Object? notesPickup = freezed,Object? notesDelivery = freezed,}) {
  return _then(_CreateOrderRequestModel(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CartItemModel>,pickupDate: null == pickupDate ? _self.pickupDate : pickupDate // ignore: cast_nullable_to_non_nullable
as String,pickupTimeSlot: null == pickupTimeSlot ? _self.pickupTimeSlot : pickupTimeSlot // ignore: cast_nullable_to_non_nullable
as String,deliveryDate: null == deliveryDate ? _self.deliveryDate : deliveryDate // ignore: cast_nullable_to_non_nullable
as String,deliveryTimeSlot: null == deliveryTimeSlot ? _self.deliveryTimeSlot : deliveryTimeSlot // ignore: cast_nullable_to_non_nullable
as String,pickupAddress: null == pickupAddress ? _self.pickupAddress : pickupAddress // ignore: cast_nullable_to_non_nullable
as String,deliveryAddress: null == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,isExpress: null == isExpress ? _self.isExpress : isExpress // ignore: cast_nullable_to_non_nullable
as bool,promoCode: freezed == promoCode ? _self.promoCode : promoCode // ignore: cast_nullable_to_non_nullable
as String?,notesPickup: freezed == notesPickup ? _self.notesPickup : notesPickup // ignore: cast_nullable_to_non_nullable
as String?,notesDelivery: freezed == notesDelivery ? _self.notesDelivery : notesDelivery // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CreateOrderResponseModel {

 bool get success; String get message;@JsonKey(name: 'order_id') int? get orderId;@JsonKey(name: 'order_number') String? get orderNumber;
/// Create a copy of CreateOrderResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateOrderResponseModelCopyWith<CreateOrderResponseModel> get copyWith => _$CreateOrderResponseModelCopyWithImpl<CreateOrderResponseModel>(this as CreateOrderResponseModel, _$identity);

  /// Serializes this CreateOrderResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateOrderResponseModel&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,orderId,orderNumber);

@override
String toString() {
  return 'CreateOrderResponseModel(success: $success, message: $message, orderId: $orderId, orderNumber: $orderNumber)';
}


}

/// @nodoc
abstract mixin class $CreateOrderResponseModelCopyWith<$Res>  {
  factory $CreateOrderResponseModelCopyWith(CreateOrderResponseModel value, $Res Function(CreateOrderResponseModel) _then) = _$CreateOrderResponseModelCopyWithImpl;
@useResult
$Res call({
 bool success, String message,@JsonKey(name: 'order_id') int? orderId,@JsonKey(name: 'order_number') String? orderNumber
});




}
/// @nodoc
class _$CreateOrderResponseModelCopyWithImpl<$Res>
    implements $CreateOrderResponseModelCopyWith<$Res> {
  _$CreateOrderResponseModelCopyWithImpl(this._self, this._then);

  final CreateOrderResponseModel _self;
  final $Res Function(CreateOrderResponseModel) _then;

/// Create a copy of CreateOrderResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? orderId = freezed,Object? orderNumber = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int?,orderNumber: freezed == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateOrderResponseModel].
extension CreateOrderResponseModelPatterns on CreateOrderResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateOrderResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateOrderResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateOrderResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _CreateOrderResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateOrderResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _CreateOrderResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message, @JsonKey(name: 'order_id')  int? orderId, @JsonKey(name: 'order_number')  String? orderNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateOrderResponseModel() when $default != null:
return $default(_that.success,_that.message,_that.orderId,_that.orderNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message, @JsonKey(name: 'order_id')  int? orderId, @JsonKey(name: 'order_number')  String? orderNumber)  $default,) {final _that = this;
switch (_that) {
case _CreateOrderResponseModel():
return $default(_that.success,_that.message,_that.orderId,_that.orderNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message, @JsonKey(name: 'order_id')  int? orderId, @JsonKey(name: 'order_number')  String? orderNumber)?  $default,) {final _that = this;
switch (_that) {
case _CreateOrderResponseModel() when $default != null:
return $default(_that.success,_that.message,_that.orderId,_that.orderNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateOrderResponseModel extends CreateOrderResponseModel {
  const _CreateOrderResponseModel({required this.success, required this.message, @JsonKey(name: 'order_id') this.orderId, @JsonKey(name: 'order_number') this.orderNumber}): super._();
  factory _CreateOrderResponseModel.fromJson(Map<String, dynamic> json) => _$CreateOrderResponseModelFromJson(json);

@override final  bool success;
@override final  String message;
@override@JsonKey(name: 'order_id') final  int? orderId;
@override@JsonKey(name: 'order_number') final  String? orderNumber;

/// Create a copy of CreateOrderResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateOrderResponseModelCopyWith<_CreateOrderResponseModel> get copyWith => __$CreateOrderResponseModelCopyWithImpl<_CreateOrderResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateOrderResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateOrderResponseModel&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,orderId,orderNumber);

@override
String toString() {
  return 'CreateOrderResponseModel(success: $success, message: $message, orderId: $orderId, orderNumber: $orderNumber)';
}


}

/// @nodoc
abstract mixin class _$CreateOrderResponseModelCopyWith<$Res> implements $CreateOrderResponseModelCopyWith<$Res> {
  factory _$CreateOrderResponseModelCopyWith(_CreateOrderResponseModel value, $Res Function(_CreateOrderResponseModel) _then) = __$CreateOrderResponseModelCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message,@JsonKey(name: 'order_id') int? orderId,@JsonKey(name: 'order_number') String? orderNumber
});




}
/// @nodoc
class __$CreateOrderResponseModelCopyWithImpl<$Res>
    implements _$CreateOrderResponseModelCopyWith<$Res> {
  __$CreateOrderResponseModelCopyWithImpl(this._self, this._then);

  final _CreateOrderResponseModel _self;
  final $Res Function(_CreateOrderResponseModel) _then;

/// Create a copy of CreateOrderResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? orderId = freezed,Object? orderNumber = freezed,}) {
  return _then(_CreateOrderResponseModel(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int?,orderNumber: freezed == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

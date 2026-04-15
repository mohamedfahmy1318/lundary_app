// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderItemModel {

 int get id;@JsonKey(name: 'order_id') int get orderId;@JsonKey(name: 'service_id') int get serviceId;@JsonKey(name: 'service_name') String get serviceName; int get quantity;@JsonKey(name: 'unit_price') String get unitPrice;@JsonKey(name: 'total_price') String get totalPrice;@JsonKey(name: 'special_instructions') String? get specialInstructions;
/// Create a copy of OrderItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderItemModelCopyWith<OrderItemModel> get copyWith => _$OrderItemModelCopyWithImpl<OrderItemModel>(this as OrderItemModel, _$identity);

  /// Serializes this OrderItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice)&&(identical(other.specialInstructions, specialInstructions) || other.specialInstructions == specialInstructions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderId,serviceId,serviceName,quantity,unitPrice,totalPrice,specialInstructions);

@override
String toString() {
  return 'OrderItemModel(id: $id, orderId: $orderId, serviceId: $serviceId, serviceName: $serviceName, quantity: $quantity, unitPrice: $unitPrice, totalPrice: $totalPrice, specialInstructions: $specialInstructions)';
}


}

/// @nodoc
abstract mixin class $OrderItemModelCopyWith<$Res>  {
  factory $OrderItemModelCopyWith(OrderItemModel value, $Res Function(OrderItemModel) _then) = _$OrderItemModelCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'order_id') int orderId,@JsonKey(name: 'service_id') int serviceId,@JsonKey(name: 'service_name') String serviceName, int quantity,@JsonKey(name: 'unit_price') String unitPrice,@JsonKey(name: 'total_price') String totalPrice,@JsonKey(name: 'special_instructions') String? specialInstructions
});




}
/// @nodoc
class _$OrderItemModelCopyWithImpl<$Res>
    implements $OrderItemModelCopyWith<$Res> {
  _$OrderItemModelCopyWithImpl(this._self, this._then);

  final OrderItemModel _self;
  final $Res Function(OrderItemModel) _then;

/// Create a copy of OrderItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderId = null,Object? serviceId = null,Object? serviceName = null,Object? quantity = null,Object? unitPrice = null,Object? totalPrice = null,Object? specialInstructions = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as String,totalPrice: null == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as String,specialInstructions: freezed == specialInstructions ? _self.specialInstructions : specialInstructions // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderItemModel].
extension OrderItemModelPatterns on OrderItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderItemModel value)  $default,){
final _that = this;
switch (_that) {
case _OrderItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _OrderItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'order_id')  int orderId, @JsonKey(name: 'service_id')  int serviceId, @JsonKey(name: 'service_name')  String serviceName,  int quantity, @JsonKey(name: 'unit_price')  String unitPrice, @JsonKey(name: 'total_price')  String totalPrice, @JsonKey(name: 'special_instructions')  String? specialInstructions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderItemModel() when $default != null:
return $default(_that.id,_that.orderId,_that.serviceId,_that.serviceName,_that.quantity,_that.unitPrice,_that.totalPrice,_that.specialInstructions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'order_id')  int orderId, @JsonKey(name: 'service_id')  int serviceId, @JsonKey(name: 'service_name')  String serviceName,  int quantity, @JsonKey(name: 'unit_price')  String unitPrice, @JsonKey(name: 'total_price')  String totalPrice, @JsonKey(name: 'special_instructions')  String? specialInstructions)  $default,) {final _that = this;
switch (_that) {
case _OrderItemModel():
return $default(_that.id,_that.orderId,_that.serviceId,_that.serviceName,_that.quantity,_that.unitPrice,_that.totalPrice,_that.specialInstructions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'order_id')  int orderId, @JsonKey(name: 'service_id')  int serviceId, @JsonKey(name: 'service_name')  String serviceName,  int quantity, @JsonKey(name: 'unit_price')  String unitPrice, @JsonKey(name: 'total_price')  String totalPrice, @JsonKey(name: 'special_instructions')  String? specialInstructions)?  $default,) {final _that = this;
switch (_that) {
case _OrderItemModel() when $default != null:
return $default(_that.id,_that.orderId,_that.serviceId,_that.serviceName,_that.quantity,_that.unitPrice,_that.totalPrice,_that.specialInstructions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderItemModel extends OrderItemModel {
  const _OrderItemModel({required this.id, @JsonKey(name: 'order_id') required this.orderId, @JsonKey(name: 'service_id') required this.serviceId, @JsonKey(name: 'service_name') required this.serviceName, required this.quantity, @JsonKey(name: 'unit_price') required this.unitPrice, @JsonKey(name: 'total_price') required this.totalPrice, @JsonKey(name: 'special_instructions') this.specialInstructions}): super._();
  factory _OrderItemModel.fromJson(Map<String, dynamic> json) => _$OrderItemModelFromJson(json);

@override final  int id;
@override@JsonKey(name: 'order_id') final  int orderId;
@override@JsonKey(name: 'service_id') final  int serviceId;
@override@JsonKey(name: 'service_name') final  String serviceName;
@override final  int quantity;
@override@JsonKey(name: 'unit_price') final  String unitPrice;
@override@JsonKey(name: 'total_price') final  String totalPrice;
@override@JsonKey(name: 'special_instructions') final  String? specialInstructions;

/// Create a copy of OrderItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderItemModelCopyWith<_OrderItemModel> get copyWith => __$OrderItemModelCopyWithImpl<_OrderItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice)&&(identical(other.specialInstructions, specialInstructions) || other.specialInstructions == specialInstructions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderId,serviceId,serviceName,quantity,unitPrice,totalPrice,specialInstructions);

@override
String toString() {
  return 'OrderItemModel(id: $id, orderId: $orderId, serviceId: $serviceId, serviceName: $serviceName, quantity: $quantity, unitPrice: $unitPrice, totalPrice: $totalPrice, specialInstructions: $specialInstructions)';
}


}

/// @nodoc
abstract mixin class _$OrderItemModelCopyWith<$Res> implements $OrderItemModelCopyWith<$Res> {
  factory _$OrderItemModelCopyWith(_OrderItemModel value, $Res Function(_OrderItemModel) _then) = __$OrderItemModelCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'order_id') int orderId,@JsonKey(name: 'service_id') int serviceId,@JsonKey(name: 'service_name') String serviceName, int quantity,@JsonKey(name: 'unit_price') String unitPrice,@JsonKey(name: 'total_price') String totalPrice,@JsonKey(name: 'special_instructions') String? specialInstructions
});




}
/// @nodoc
class __$OrderItemModelCopyWithImpl<$Res>
    implements _$OrderItemModelCopyWith<$Res> {
  __$OrderItemModelCopyWithImpl(this._self, this._then);

  final _OrderItemModel _self;
  final $Res Function(_OrderItemModel) _then;

/// Create a copy of OrderItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderId = null,Object? serviceId = null,Object? serviceName = null,Object? quantity = null,Object? unitPrice = null,Object? totalPrice = null,Object? specialInstructions = freezed,}) {
  return _then(_OrderItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as String,totalPrice: null == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as String,specialInstructions: freezed == specialInstructions ? _self.specialInstructions : specialInstructions // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$OrderModel {

 int get id;@JsonKey(name: 'order_number') String get orderNumber;@JsonKey(name: 'user_id') int get userId;@OrderStatusJsonConverter() OrderStatus get status;@JsonKey(name: 'pickup_date') String? get pickupDate;@JsonKey(name: 'pickup_time_slot') String? get pickupTimeSlot;@JsonKey(name: 'pickup_address') String? get pickupAddress;@JsonKey(name: 'delivery_date') String? get deliveryDate;@JsonKey(name: 'delivery_time_slot') String? get deliveryTimeSlot;@JsonKey(name: 'delivery_address') String? get deliveryAddress; String get subtotal;@JsonKey(name: 'delivery_fee') String get deliveryFee;@JsonKey(name: 'discount_amount') String get discountAmount;@JsonKey(name: 'total_amount') String get totalAmount;@JsonKey(name: 'payment_method') String? get paymentMethod;@JsonKey(name: 'payment_status') String? get paymentStatus; String? get notes;@JsonKey(name: 'promo_code') String? get promoCode;@JsonKey(name: 'is_express') bool get isExpress;@JsonKey(name: 'cancelled_at') String? get cancelledAt;@JsonKey(name: 'cancellation_reason') String? get cancellationReason;@JsonKey(name: 'created_at') String? get createdAt;@JsonKey(name: 'updated_at') String? get updatedAt; List<OrderItemModel>? get items;
/// Create a copy of OrderModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderModelCopyWith<OrderModel> get copyWith => _$OrderModelCopyWithImpl<OrderModel>(this as OrderModel, _$identity);

  /// Serializes this OrderModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.status, status) || other.status == status)&&(identical(other.pickupDate, pickupDate) || other.pickupDate == pickupDate)&&(identical(other.pickupTimeSlot, pickupTimeSlot) || other.pickupTimeSlot == pickupTimeSlot)&&(identical(other.pickupAddress, pickupAddress) || other.pickupAddress == pickupAddress)&&(identical(other.deliveryDate, deliveryDate) || other.deliveryDate == deliveryDate)&&(identical(other.deliveryTimeSlot, deliveryTimeSlot) || other.deliveryTimeSlot == deliveryTimeSlot)&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.deliveryFee, deliveryFee) || other.deliveryFee == deliveryFee)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.promoCode, promoCode) || other.promoCode == promoCode)&&(identical(other.isExpress, isExpress) || other.isExpress == isExpress)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.cancellationReason, cancellationReason) || other.cancellationReason == cancellationReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,orderNumber,userId,status,pickupDate,pickupTimeSlot,pickupAddress,deliveryDate,deliveryTimeSlot,deliveryAddress,subtotal,deliveryFee,discountAmount,totalAmount,paymentMethod,paymentStatus,notes,promoCode,isExpress,cancelledAt,cancellationReason,createdAt,updatedAt,const DeepCollectionEquality().hash(items)]);

@override
String toString() {
  return 'OrderModel(id: $id, orderNumber: $orderNumber, userId: $userId, status: $status, pickupDate: $pickupDate, pickupTimeSlot: $pickupTimeSlot, pickupAddress: $pickupAddress, deliveryDate: $deliveryDate, deliveryTimeSlot: $deliveryTimeSlot, deliveryAddress: $deliveryAddress, subtotal: $subtotal, deliveryFee: $deliveryFee, discountAmount: $discountAmount, totalAmount: $totalAmount, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, notes: $notes, promoCode: $promoCode, isExpress: $isExpress, cancelledAt: $cancelledAt, cancellationReason: $cancellationReason, createdAt: $createdAt, updatedAt: $updatedAt, items: $items)';
}


}

/// @nodoc
abstract mixin class $OrderModelCopyWith<$Res>  {
  factory $OrderModelCopyWith(OrderModel value, $Res Function(OrderModel) _then) = _$OrderModelCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'order_number') String orderNumber,@JsonKey(name: 'user_id') int userId,@OrderStatusJsonConverter() OrderStatus status,@JsonKey(name: 'pickup_date') String? pickupDate,@JsonKey(name: 'pickup_time_slot') String? pickupTimeSlot,@JsonKey(name: 'pickup_address') String? pickupAddress,@JsonKey(name: 'delivery_date') String? deliveryDate,@JsonKey(name: 'delivery_time_slot') String? deliveryTimeSlot,@JsonKey(name: 'delivery_address') String? deliveryAddress, String subtotal,@JsonKey(name: 'delivery_fee') String deliveryFee,@JsonKey(name: 'discount_amount') String discountAmount,@JsonKey(name: 'total_amount') String totalAmount,@JsonKey(name: 'payment_method') String? paymentMethod,@JsonKey(name: 'payment_status') String? paymentStatus, String? notes,@JsonKey(name: 'promo_code') String? promoCode,@JsonKey(name: 'is_express') bool isExpress,@JsonKey(name: 'cancelled_at') String? cancelledAt,@JsonKey(name: 'cancellation_reason') String? cancellationReason,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt, List<OrderItemModel>? items
});




}
/// @nodoc
class _$OrderModelCopyWithImpl<$Res>
    implements $OrderModelCopyWith<$Res> {
  _$OrderModelCopyWithImpl(this._self, this._then);

  final OrderModel _self;
  final $Res Function(OrderModel) _then;

/// Create a copy of OrderModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderNumber = null,Object? userId = null,Object? status = null,Object? pickupDate = freezed,Object? pickupTimeSlot = freezed,Object? pickupAddress = freezed,Object? deliveryDate = freezed,Object? deliveryTimeSlot = freezed,Object? deliveryAddress = freezed,Object? subtotal = null,Object? deliveryFee = null,Object? discountAmount = null,Object? totalAmount = null,Object? paymentMethod = freezed,Object? paymentStatus = freezed,Object? notes = freezed,Object? promoCode = freezed,Object? isExpress = null,Object? cancelledAt = freezed,Object? cancellationReason = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? items = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,pickupDate: freezed == pickupDate ? _self.pickupDate : pickupDate // ignore: cast_nullable_to_non_nullable
as String?,pickupTimeSlot: freezed == pickupTimeSlot ? _self.pickupTimeSlot : pickupTimeSlot // ignore: cast_nullable_to_non_nullable
as String?,pickupAddress: freezed == pickupAddress ? _self.pickupAddress : pickupAddress // ignore: cast_nullable_to_non_nullable
as String?,deliveryDate: freezed == deliveryDate ? _self.deliveryDate : deliveryDate // ignore: cast_nullable_to_non_nullable
as String?,deliveryTimeSlot: freezed == deliveryTimeSlot ? _self.deliveryTimeSlot : deliveryTimeSlot // ignore: cast_nullable_to_non_nullable
as String?,deliveryAddress: freezed == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as String?,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as String,deliveryFee: null == deliveryFee ? _self.deliveryFee : deliveryFee // ignore: cast_nullable_to_non_nullable
as String,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,paymentStatus: freezed == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,promoCode: freezed == promoCode ? _self.promoCode : promoCode // ignore: cast_nullable_to_non_nullable
as String?,isExpress: null == isExpress ? _self.isExpress : isExpress // ignore: cast_nullable_to_non_nullable
as bool,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as String?,cancellationReason: freezed == cancellationReason ? _self.cancellationReason : cancellationReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,items: freezed == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<OrderItemModel>?,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderModel].
extension OrderModelPatterns on OrderModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderModel value)  $default,){
final _that = this;
switch (_that) {
case _OrderModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderModel value)?  $default,){
final _that = this;
switch (_that) {
case _OrderModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'order_number')  String orderNumber, @JsonKey(name: 'user_id')  int userId, @OrderStatusJsonConverter()  OrderStatus status, @JsonKey(name: 'pickup_date')  String? pickupDate, @JsonKey(name: 'pickup_time_slot')  String? pickupTimeSlot, @JsonKey(name: 'pickup_address')  String? pickupAddress, @JsonKey(name: 'delivery_date')  String? deliveryDate, @JsonKey(name: 'delivery_time_slot')  String? deliveryTimeSlot, @JsonKey(name: 'delivery_address')  String? deliveryAddress,  String subtotal, @JsonKey(name: 'delivery_fee')  String deliveryFee, @JsonKey(name: 'discount_amount')  String discountAmount, @JsonKey(name: 'total_amount')  String totalAmount, @JsonKey(name: 'payment_method')  String? paymentMethod, @JsonKey(name: 'payment_status')  String? paymentStatus,  String? notes, @JsonKey(name: 'promo_code')  String? promoCode, @JsonKey(name: 'is_express')  bool isExpress, @JsonKey(name: 'cancelled_at')  String? cancelledAt, @JsonKey(name: 'cancellation_reason')  String? cancellationReason, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt,  List<OrderItemModel>? items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderModel() when $default != null:
return $default(_that.id,_that.orderNumber,_that.userId,_that.status,_that.pickupDate,_that.pickupTimeSlot,_that.pickupAddress,_that.deliveryDate,_that.deliveryTimeSlot,_that.deliveryAddress,_that.subtotal,_that.deliveryFee,_that.discountAmount,_that.totalAmount,_that.paymentMethod,_that.paymentStatus,_that.notes,_that.promoCode,_that.isExpress,_that.cancelledAt,_that.cancellationReason,_that.createdAt,_that.updatedAt,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'order_number')  String orderNumber, @JsonKey(name: 'user_id')  int userId, @OrderStatusJsonConverter()  OrderStatus status, @JsonKey(name: 'pickup_date')  String? pickupDate, @JsonKey(name: 'pickup_time_slot')  String? pickupTimeSlot, @JsonKey(name: 'pickup_address')  String? pickupAddress, @JsonKey(name: 'delivery_date')  String? deliveryDate, @JsonKey(name: 'delivery_time_slot')  String? deliveryTimeSlot, @JsonKey(name: 'delivery_address')  String? deliveryAddress,  String subtotal, @JsonKey(name: 'delivery_fee')  String deliveryFee, @JsonKey(name: 'discount_amount')  String discountAmount, @JsonKey(name: 'total_amount')  String totalAmount, @JsonKey(name: 'payment_method')  String? paymentMethod, @JsonKey(name: 'payment_status')  String? paymentStatus,  String? notes, @JsonKey(name: 'promo_code')  String? promoCode, @JsonKey(name: 'is_express')  bool isExpress, @JsonKey(name: 'cancelled_at')  String? cancelledAt, @JsonKey(name: 'cancellation_reason')  String? cancellationReason, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt,  List<OrderItemModel>? items)  $default,) {final _that = this;
switch (_that) {
case _OrderModel():
return $default(_that.id,_that.orderNumber,_that.userId,_that.status,_that.pickupDate,_that.pickupTimeSlot,_that.pickupAddress,_that.deliveryDate,_that.deliveryTimeSlot,_that.deliveryAddress,_that.subtotal,_that.deliveryFee,_that.discountAmount,_that.totalAmount,_that.paymentMethod,_that.paymentStatus,_that.notes,_that.promoCode,_that.isExpress,_that.cancelledAt,_that.cancellationReason,_that.createdAt,_that.updatedAt,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'order_number')  String orderNumber, @JsonKey(name: 'user_id')  int userId, @OrderStatusJsonConverter()  OrderStatus status, @JsonKey(name: 'pickup_date')  String? pickupDate, @JsonKey(name: 'pickup_time_slot')  String? pickupTimeSlot, @JsonKey(name: 'pickup_address')  String? pickupAddress, @JsonKey(name: 'delivery_date')  String? deliveryDate, @JsonKey(name: 'delivery_time_slot')  String? deliveryTimeSlot, @JsonKey(name: 'delivery_address')  String? deliveryAddress,  String subtotal, @JsonKey(name: 'delivery_fee')  String deliveryFee, @JsonKey(name: 'discount_amount')  String discountAmount, @JsonKey(name: 'total_amount')  String totalAmount, @JsonKey(name: 'payment_method')  String? paymentMethod, @JsonKey(name: 'payment_status')  String? paymentStatus,  String? notes, @JsonKey(name: 'promo_code')  String? promoCode, @JsonKey(name: 'is_express')  bool isExpress, @JsonKey(name: 'cancelled_at')  String? cancelledAt, @JsonKey(name: 'cancellation_reason')  String? cancellationReason, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt,  List<OrderItemModel>? items)?  $default,) {final _that = this;
switch (_that) {
case _OrderModel() when $default != null:
return $default(_that.id,_that.orderNumber,_that.userId,_that.status,_that.pickupDate,_that.pickupTimeSlot,_that.pickupAddress,_that.deliveryDate,_that.deliveryTimeSlot,_that.deliveryAddress,_that.subtotal,_that.deliveryFee,_that.discountAmount,_that.totalAmount,_that.paymentMethod,_that.paymentStatus,_that.notes,_that.promoCode,_that.isExpress,_that.cancelledAt,_that.cancellationReason,_that.createdAt,_that.updatedAt,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderModel extends OrderModel {
  const _OrderModel({required this.id, @JsonKey(name: 'order_number') required this.orderNumber, @JsonKey(name: 'user_id') required this.userId, @OrderStatusJsonConverter() required this.status, @JsonKey(name: 'pickup_date') this.pickupDate, @JsonKey(name: 'pickup_time_slot') this.pickupTimeSlot, @JsonKey(name: 'pickup_address') this.pickupAddress, @JsonKey(name: 'delivery_date') this.deliveryDate, @JsonKey(name: 'delivery_time_slot') this.deliveryTimeSlot, @JsonKey(name: 'delivery_address') this.deliveryAddress, required this.subtotal, @JsonKey(name: 'delivery_fee') required this.deliveryFee, @JsonKey(name: 'discount_amount') required this.discountAmount, @JsonKey(name: 'total_amount') required this.totalAmount, @JsonKey(name: 'payment_method') this.paymentMethod, @JsonKey(name: 'payment_status') this.paymentStatus, this.notes, @JsonKey(name: 'promo_code') this.promoCode, @JsonKey(name: 'is_express') this.isExpress = false, @JsonKey(name: 'cancelled_at') this.cancelledAt, @JsonKey(name: 'cancellation_reason') this.cancellationReason, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, final  List<OrderItemModel>? items}): _items = items,super._();
  factory _OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);

@override final  int id;
@override@JsonKey(name: 'order_number') final  String orderNumber;
@override@JsonKey(name: 'user_id') final  int userId;
@override@OrderStatusJsonConverter() final  OrderStatus status;
@override@JsonKey(name: 'pickup_date') final  String? pickupDate;
@override@JsonKey(name: 'pickup_time_slot') final  String? pickupTimeSlot;
@override@JsonKey(name: 'pickup_address') final  String? pickupAddress;
@override@JsonKey(name: 'delivery_date') final  String? deliveryDate;
@override@JsonKey(name: 'delivery_time_slot') final  String? deliveryTimeSlot;
@override@JsonKey(name: 'delivery_address') final  String? deliveryAddress;
@override final  String subtotal;
@override@JsonKey(name: 'delivery_fee') final  String deliveryFee;
@override@JsonKey(name: 'discount_amount') final  String discountAmount;
@override@JsonKey(name: 'total_amount') final  String totalAmount;
@override@JsonKey(name: 'payment_method') final  String? paymentMethod;
@override@JsonKey(name: 'payment_status') final  String? paymentStatus;
@override final  String? notes;
@override@JsonKey(name: 'promo_code') final  String? promoCode;
@override@JsonKey(name: 'is_express') final  bool isExpress;
@override@JsonKey(name: 'cancelled_at') final  String? cancelledAt;
@override@JsonKey(name: 'cancellation_reason') final  String? cancellationReason;
@override@JsonKey(name: 'created_at') final  String? createdAt;
@override@JsonKey(name: 'updated_at') final  String? updatedAt;
 final  List<OrderItemModel>? _items;
@override List<OrderItemModel>? get items {
  final value = _items;
  if (value == null) return null;
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of OrderModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderModelCopyWith<_OrderModel> get copyWith => __$OrderModelCopyWithImpl<_OrderModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.status, status) || other.status == status)&&(identical(other.pickupDate, pickupDate) || other.pickupDate == pickupDate)&&(identical(other.pickupTimeSlot, pickupTimeSlot) || other.pickupTimeSlot == pickupTimeSlot)&&(identical(other.pickupAddress, pickupAddress) || other.pickupAddress == pickupAddress)&&(identical(other.deliveryDate, deliveryDate) || other.deliveryDate == deliveryDate)&&(identical(other.deliveryTimeSlot, deliveryTimeSlot) || other.deliveryTimeSlot == deliveryTimeSlot)&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.deliveryFee, deliveryFee) || other.deliveryFee == deliveryFee)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.promoCode, promoCode) || other.promoCode == promoCode)&&(identical(other.isExpress, isExpress) || other.isExpress == isExpress)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.cancellationReason, cancellationReason) || other.cancellationReason == cancellationReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,orderNumber,userId,status,pickupDate,pickupTimeSlot,pickupAddress,deliveryDate,deliveryTimeSlot,deliveryAddress,subtotal,deliveryFee,discountAmount,totalAmount,paymentMethod,paymentStatus,notes,promoCode,isExpress,cancelledAt,cancellationReason,createdAt,updatedAt,const DeepCollectionEquality().hash(_items)]);

@override
String toString() {
  return 'OrderModel(id: $id, orderNumber: $orderNumber, userId: $userId, status: $status, pickupDate: $pickupDate, pickupTimeSlot: $pickupTimeSlot, pickupAddress: $pickupAddress, deliveryDate: $deliveryDate, deliveryTimeSlot: $deliveryTimeSlot, deliveryAddress: $deliveryAddress, subtotal: $subtotal, deliveryFee: $deliveryFee, discountAmount: $discountAmount, totalAmount: $totalAmount, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, notes: $notes, promoCode: $promoCode, isExpress: $isExpress, cancelledAt: $cancelledAt, cancellationReason: $cancellationReason, createdAt: $createdAt, updatedAt: $updatedAt, items: $items)';
}


}

/// @nodoc
abstract mixin class _$OrderModelCopyWith<$Res> implements $OrderModelCopyWith<$Res> {
  factory _$OrderModelCopyWith(_OrderModel value, $Res Function(_OrderModel) _then) = __$OrderModelCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'order_number') String orderNumber,@JsonKey(name: 'user_id') int userId,@OrderStatusJsonConverter() OrderStatus status,@JsonKey(name: 'pickup_date') String? pickupDate,@JsonKey(name: 'pickup_time_slot') String? pickupTimeSlot,@JsonKey(name: 'pickup_address') String? pickupAddress,@JsonKey(name: 'delivery_date') String? deliveryDate,@JsonKey(name: 'delivery_time_slot') String? deliveryTimeSlot,@JsonKey(name: 'delivery_address') String? deliveryAddress, String subtotal,@JsonKey(name: 'delivery_fee') String deliveryFee,@JsonKey(name: 'discount_amount') String discountAmount,@JsonKey(name: 'total_amount') String totalAmount,@JsonKey(name: 'payment_method') String? paymentMethod,@JsonKey(name: 'payment_status') String? paymentStatus, String? notes,@JsonKey(name: 'promo_code') String? promoCode,@JsonKey(name: 'is_express') bool isExpress,@JsonKey(name: 'cancelled_at') String? cancelledAt,@JsonKey(name: 'cancellation_reason') String? cancellationReason,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt, List<OrderItemModel>? items
});




}
/// @nodoc
class __$OrderModelCopyWithImpl<$Res>
    implements _$OrderModelCopyWith<$Res> {
  __$OrderModelCopyWithImpl(this._self, this._then);

  final _OrderModel _self;
  final $Res Function(_OrderModel) _then;

/// Create a copy of OrderModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderNumber = null,Object? userId = null,Object? status = null,Object? pickupDate = freezed,Object? pickupTimeSlot = freezed,Object? pickupAddress = freezed,Object? deliveryDate = freezed,Object? deliveryTimeSlot = freezed,Object? deliveryAddress = freezed,Object? subtotal = null,Object? deliveryFee = null,Object? discountAmount = null,Object? totalAmount = null,Object? paymentMethod = freezed,Object? paymentStatus = freezed,Object? notes = freezed,Object? promoCode = freezed,Object? isExpress = null,Object? cancelledAt = freezed,Object? cancellationReason = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? items = freezed,}) {
  return _then(_OrderModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,pickupDate: freezed == pickupDate ? _self.pickupDate : pickupDate // ignore: cast_nullable_to_non_nullable
as String?,pickupTimeSlot: freezed == pickupTimeSlot ? _self.pickupTimeSlot : pickupTimeSlot // ignore: cast_nullable_to_non_nullable
as String?,pickupAddress: freezed == pickupAddress ? _self.pickupAddress : pickupAddress // ignore: cast_nullable_to_non_nullable
as String?,deliveryDate: freezed == deliveryDate ? _self.deliveryDate : deliveryDate // ignore: cast_nullable_to_non_nullable
as String?,deliveryTimeSlot: freezed == deliveryTimeSlot ? _self.deliveryTimeSlot : deliveryTimeSlot // ignore: cast_nullable_to_non_nullable
as String?,deliveryAddress: freezed == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as String?,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as String,deliveryFee: null == deliveryFee ? _self.deliveryFee : deliveryFee // ignore: cast_nullable_to_non_nullable
as String,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,paymentStatus: freezed == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,promoCode: freezed == promoCode ? _self.promoCode : promoCode // ignore: cast_nullable_to_non_nullable
as String?,isExpress: null == isExpress ? _self.isExpress : isExpress // ignore: cast_nullable_to_non_nullable
as bool,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as String?,cancellationReason: freezed == cancellationReason ? _self.cancellationReason : cancellationReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,items: freezed == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<OrderItemModel>?,
  ));
}


}


/// @nodoc
mixin _$OrderStatisticsModel {

@JsonKey(name: 'total_orders') int get totalOrders;@JsonKey(name: 'pending_orders') int get pendingOrders;@JsonKey(name: 'completed_orders') int get completedOrders;@JsonKey(name: 'total_spent') int get totalSpent;
/// Create a copy of OrderStatisticsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderStatisticsModelCopyWith<OrderStatisticsModel> get copyWith => _$OrderStatisticsModelCopyWithImpl<OrderStatisticsModel>(this as OrderStatisticsModel, _$identity);

  /// Serializes this OrderStatisticsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderStatisticsModel&&(identical(other.totalOrders, totalOrders) || other.totalOrders == totalOrders)&&(identical(other.pendingOrders, pendingOrders) || other.pendingOrders == pendingOrders)&&(identical(other.completedOrders, completedOrders) || other.completedOrders == completedOrders)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalOrders,pendingOrders,completedOrders,totalSpent);

@override
String toString() {
  return 'OrderStatisticsModel(totalOrders: $totalOrders, pendingOrders: $pendingOrders, completedOrders: $completedOrders, totalSpent: $totalSpent)';
}


}

/// @nodoc
abstract mixin class $OrderStatisticsModelCopyWith<$Res>  {
  factory $OrderStatisticsModelCopyWith(OrderStatisticsModel value, $Res Function(OrderStatisticsModel) _then) = _$OrderStatisticsModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'total_orders') int totalOrders,@JsonKey(name: 'pending_orders') int pendingOrders,@JsonKey(name: 'completed_orders') int completedOrders,@JsonKey(name: 'total_spent') int totalSpent
});




}
/// @nodoc
class _$OrderStatisticsModelCopyWithImpl<$Res>
    implements $OrderStatisticsModelCopyWith<$Res> {
  _$OrderStatisticsModelCopyWithImpl(this._self, this._then);

  final OrderStatisticsModel _self;
  final $Res Function(OrderStatisticsModel) _then;

/// Create a copy of OrderStatisticsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalOrders = null,Object? pendingOrders = null,Object? completedOrders = null,Object? totalSpent = null,}) {
  return _then(_self.copyWith(
totalOrders: null == totalOrders ? _self.totalOrders : totalOrders // ignore: cast_nullable_to_non_nullable
as int,pendingOrders: null == pendingOrders ? _self.pendingOrders : pendingOrders // ignore: cast_nullable_to_non_nullable
as int,completedOrders: null == completedOrders ? _self.completedOrders : completedOrders // ignore: cast_nullable_to_non_nullable
as int,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderStatisticsModel].
extension OrderStatisticsModelPatterns on OrderStatisticsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderStatisticsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderStatisticsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderStatisticsModel value)  $default,){
final _that = this;
switch (_that) {
case _OrderStatisticsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderStatisticsModel value)?  $default,){
final _that = this;
switch (_that) {
case _OrderStatisticsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_orders')  int totalOrders, @JsonKey(name: 'pending_orders')  int pendingOrders, @JsonKey(name: 'completed_orders')  int completedOrders, @JsonKey(name: 'total_spent')  int totalSpent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderStatisticsModel() when $default != null:
return $default(_that.totalOrders,_that.pendingOrders,_that.completedOrders,_that.totalSpent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_orders')  int totalOrders, @JsonKey(name: 'pending_orders')  int pendingOrders, @JsonKey(name: 'completed_orders')  int completedOrders, @JsonKey(name: 'total_spent')  int totalSpent)  $default,) {final _that = this;
switch (_that) {
case _OrderStatisticsModel():
return $default(_that.totalOrders,_that.pendingOrders,_that.completedOrders,_that.totalSpent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'total_orders')  int totalOrders, @JsonKey(name: 'pending_orders')  int pendingOrders, @JsonKey(name: 'completed_orders')  int completedOrders, @JsonKey(name: 'total_spent')  int totalSpent)?  $default,) {final _that = this;
switch (_that) {
case _OrderStatisticsModel() when $default != null:
return $default(_that.totalOrders,_that.pendingOrders,_that.completedOrders,_that.totalSpent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderStatisticsModel extends OrderStatisticsModel {
  const _OrderStatisticsModel({@JsonKey(name: 'total_orders') required this.totalOrders, @JsonKey(name: 'pending_orders') required this.pendingOrders, @JsonKey(name: 'completed_orders') required this.completedOrders, @JsonKey(name: 'total_spent') required this.totalSpent}): super._();
  factory _OrderStatisticsModel.fromJson(Map<String, dynamic> json) => _$OrderStatisticsModelFromJson(json);

@override@JsonKey(name: 'total_orders') final  int totalOrders;
@override@JsonKey(name: 'pending_orders') final  int pendingOrders;
@override@JsonKey(name: 'completed_orders') final  int completedOrders;
@override@JsonKey(name: 'total_spent') final  int totalSpent;

/// Create a copy of OrderStatisticsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderStatisticsModelCopyWith<_OrderStatisticsModel> get copyWith => __$OrderStatisticsModelCopyWithImpl<_OrderStatisticsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderStatisticsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderStatisticsModel&&(identical(other.totalOrders, totalOrders) || other.totalOrders == totalOrders)&&(identical(other.pendingOrders, pendingOrders) || other.pendingOrders == pendingOrders)&&(identical(other.completedOrders, completedOrders) || other.completedOrders == completedOrders)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalOrders,pendingOrders,completedOrders,totalSpent);

@override
String toString() {
  return 'OrderStatisticsModel(totalOrders: $totalOrders, pendingOrders: $pendingOrders, completedOrders: $completedOrders, totalSpent: $totalSpent)';
}


}

/// @nodoc
abstract mixin class _$OrderStatisticsModelCopyWith<$Res> implements $OrderStatisticsModelCopyWith<$Res> {
  factory _$OrderStatisticsModelCopyWith(_OrderStatisticsModel value, $Res Function(_OrderStatisticsModel) _then) = __$OrderStatisticsModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'total_orders') int totalOrders,@JsonKey(name: 'pending_orders') int pendingOrders,@JsonKey(name: 'completed_orders') int completedOrders,@JsonKey(name: 'total_spent') int totalSpent
});




}
/// @nodoc
class __$OrderStatisticsModelCopyWithImpl<$Res>
    implements _$OrderStatisticsModelCopyWith<$Res> {
  __$OrderStatisticsModelCopyWithImpl(this._self, this._then);

  final _OrderStatisticsModel _self;
  final $Res Function(_OrderStatisticsModel) _then;

/// Create a copy of OrderStatisticsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalOrders = null,Object? pendingOrders = null,Object? completedOrders = null,Object? totalSpent = null,}) {
  return _then(_OrderStatisticsModel(
totalOrders: null == totalOrders ? _self.totalOrders : totalOrders // ignore: cast_nullable_to_non_nullable
as int,pendingOrders: null == pendingOrders ? _self.pendingOrders : pendingOrders // ignore: cast_nullable_to_non_nullable
as int,completedOrders: null == completedOrders ? _self.completedOrders : completedOrders // ignore: cast_nullable_to_non_nullable
as int,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

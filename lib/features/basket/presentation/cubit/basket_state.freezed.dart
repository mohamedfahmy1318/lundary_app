// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'basket_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BasketState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BasketState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BasketState()';
}


}

/// @nodoc
class $BasketStateCopyWith<$Res>  {
$BasketStateCopyWith(BasketState _, $Res Function(BasketState) __);
}


/// Adds pattern-matching-related methods to [BasketState].
extension BasketStatePatterns on BasketState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _OrderCreating value)?  orderCreating,TResult Function( _OrderPaymentRequired value)?  orderPaymentRequired,TResult Function( _OrderPaymentInitiationFailed value)?  orderPaymentInitiationFailed,TResult Function( _PaymentVerifying value)?  paymentVerifying,TResult Function( _OrderCreated value)?  orderCreated,TResult Function( _PaymentFailed value)?  paymentFailed,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _OrderCreating() when orderCreating != null:
return orderCreating(_that);case _OrderPaymentRequired() when orderPaymentRequired != null:
return orderPaymentRequired(_that);case _OrderPaymentInitiationFailed() when orderPaymentInitiationFailed != null:
return orderPaymentInitiationFailed(_that);case _PaymentVerifying() when paymentVerifying != null:
return paymentVerifying(_that);case _OrderCreated() when orderCreated != null:
return orderCreated(_that);case _PaymentFailed() when paymentFailed != null:
return paymentFailed(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _OrderCreating value)  orderCreating,required TResult Function( _OrderPaymentRequired value)  orderPaymentRequired,required TResult Function( _OrderPaymentInitiationFailed value)  orderPaymentInitiationFailed,required TResult Function( _PaymentVerifying value)  paymentVerifying,required TResult Function( _OrderCreated value)  orderCreated,required TResult Function( _PaymentFailed value)  paymentFailed,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _OrderCreating():
return orderCreating(_that);case _OrderPaymentRequired():
return orderPaymentRequired(_that);case _OrderPaymentInitiationFailed():
return orderPaymentInitiationFailed(_that);case _PaymentVerifying():
return paymentVerifying(_that);case _OrderCreated():
return orderCreated(_that);case _PaymentFailed():
return paymentFailed(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _OrderCreating value)?  orderCreating,TResult? Function( _OrderPaymentRequired value)?  orderPaymentRequired,TResult? Function( _OrderPaymentInitiationFailed value)?  orderPaymentInitiationFailed,TResult? Function( _PaymentVerifying value)?  paymentVerifying,TResult? Function( _OrderCreated value)?  orderCreated,TResult? Function( _PaymentFailed value)?  paymentFailed,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _OrderCreating() when orderCreating != null:
return orderCreating(_that);case _OrderPaymentRequired() when orderPaymentRequired != null:
return orderPaymentRequired(_that);case _OrderPaymentInitiationFailed() when orderPaymentInitiationFailed != null:
return orderPaymentInitiationFailed(_that);case _PaymentVerifying() when paymentVerifying != null:
return paymentVerifying(_that);case _OrderCreated() when orderCreated != null:
return orderCreated(_that);case _PaymentFailed() when paymentFailed != null:
return paymentFailed(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<CartItemEntity> items)?  loaded,TResult Function()?  orderCreating,TResult Function( int orderId,  String? orderNumber,  String paymentUrl)?  orderPaymentRequired,TResult Function( int orderId,  String? orderNumber,  String message)?  orderPaymentInitiationFailed,TResult Function()?  paymentVerifying,TResult Function( int? orderId,  String? orderNumber)?  orderCreated,TResult Function( String message)?  paymentFailed,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.items);case _OrderCreating() when orderCreating != null:
return orderCreating();case _OrderPaymentRequired() when orderPaymentRequired != null:
return orderPaymentRequired(_that.orderId,_that.orderNumber,_that.paymentUrl);case _OrderPaymentInitiationFailed() when orderPaymentInitiationFailed != null:
return orderPaymentInitiationFailed(_that.orderId,_that.orderNumber,_that.message);case _PaymentVerifying() when paymentVerifying != null:
return paymentVerifying();case _OrderCreated() when orderCreated != null:
return orderCreated(_that.orderId,_that.orderNumber);case _PaymentFailed() when paymentFailed != null:
return paymentFailed(_that.message);case _Error() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<CartItemEntity> items)  loaded,required TResult Function()  orderCreating,required TResult Function( int orderId,  String? orderNumber,  String paymentUrl)  orderPaymentRequired,required TResult Function( int orderId,  String? orderNumber,  String message)  orderPaymentInitiationFailed,required TResult Function()  paymentVerifying,required TResult Function( int? orderId,  String? orderNumber)  orderCreated,required TResult Function( String message)  paymentFailed,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.items);case _OrderCreating():
return orderCreating();case _OrderPaymentRequired():
return orderPaymentRequired(_that.orderId,_that.orderNumber,_that.paymentUrl);case _OrderPaymentInitiationFailed():
return orderPaymentInitiationFailed(_that.orderId,_that.orderNumber,_that.message);case _PaymentVerifying():
return paymentVerifying();case _OrderCreated():
return orderCreated(_that.orderId,_that.orderNumber);case _PaymentFailed():
return paymentFailed(_that.message);case _Error():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<CartItemEntity> items)?  loaded,TResult? Function()?  orderCreating,TResult? Function( int orderId,  String? orderNumber,  String paymentUrl)?  orderPaymentRequired,TResult? Function( int orderId,  String? orderNumber,  String message)?  orderPaymentInitiationFailed,TResult? Function()?  paymentVerifying,TResult? Function( int? orderId,  String? orderNumber)?  orderCreated,TResult? Function( String message)?  paymentFailed,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.items);case _OrderCreating() when orderCreating != null:
return orderCreating();case _OrderPaymentRequired() when orderPaymentRequired != null:
return orderPaymentRequired(_that.orderId,_that.orderNumber,_that.paymentUrl);case _OrderPaymentInitiationFailed() when orderPaymentInitiationFailed != null:
return orderPaymentInitiationFailed(_that.orderId,_that.orderNumber,_that.message);case _PaymentVerifying() when paymentVerifying != null:
return paymentVerifying();case _OrderCreated() when orderCreated != null:
return orderCreated(_that.orderId,_that.orderNumber);case _PaymentFailed() when paymentFailed != null:
return paymentFailed(_that.message);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements BasketState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BasketState.initial()';
}


}




/// @nodoc


class _Loading implements BasketState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BasketState.loading()';
}


}




/// @nodoc


class _Loaded implements BasketState {
  const _Loaded(final  List<CartItemEntity> items): _items = items;
  

 final  List<CartItemEntity> _items;
 List<CartItemEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of BasketState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'BasketState.loaded(items: $items)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $BasketStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<CartItemEntity> items
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of BasketState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_Loaded(
null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CartItemEntity>,
  ));
}


}

/// @nodoc


class _OrderCreating implements BasketState {
  const _OrderCreating();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderCreating);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BasketState.orderCreating()';
}


}




/// @nodoc


class _OrderPaymentRequired implements BasketState {
  const _OrderPaymentRequired({required this.orderId, this.orderNumber, required this.paymentUrl});
  

 final  int orderId;
 final  String? orderNumber;
 final  String paymentUrl;

/// Create a copy of BasketState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderPaymentRequiredCopyWith<_OrderPaymentRequired> get copyWith => __$OrderPaymentRequiredCopyWithImpl<_OrderPaymentRequired>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderPaymentRequired&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.paymentUrl, paymentUrl) || other.paymentUrl == paymentUrl));
}


@override
int get hashCode => Object.hash(runtimeType,orderId,orderNumber,paymentUrl);

@override
String toString() {
  return 'BasketState.orderPaymentRequired(orderId: $orderId, orderNumber: $orderNumber, paymentUrl: $paymentUrl)';
}


}

/// @nodoc
abstract mixin class _$OrderPaymentRequiredCopyWith<$Res> implements $BasketStateCopyWith<$Res> {
  factory _$OrderPaymentRequiredCopyWith(_OrderPaymentRequired value, $Res Function(_OrderPaymentRequired) _then) = __$OrderPaymentRequiredCopyWithImpl;
@useResult
$Res call({
 int orderId, String? orderNumber, String paymentUrl
});




}
/// @nodoc
class __$OrderPaymentRequiredCopyWithImpl<$Res>
    implements _$OrderPaymentRequiredCopyWith<$Res> {
  __$OrderPaymentRequiredCopyWithImpl(this._self, this._then);

  final _OrderPaymentRequired _self;
  final $Res Function(_OrderPaymentRequired) _then;

/// Create a copy of BasketState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,Object? orderNumber = freezed,Object? paymentUrl = null,}) {
  return _then(_OrderPaymentRequired(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,orderNumber: freezed == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String?,paymentUrl: null == paymentUrl ? _self.paymentUrl : paymentUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _OrderPaymentInitiationFailed implements BasketState {
  const _OrderPaymentInitiationFailed({required this.orderId, this.orderNumber, required this.message});
  

 final  int orderId;
 final  String? orderNumber;
 final  String message;

/// Create a copy of BasketState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderPaymentInitiationFailedCopyWith<_OrderPaymentInitiationFailed> get copyWith => __$OrderPaymentInitiationFailedCopyWithImpl<_OrderPaymentInitiationFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderPaymentInitiationFailed&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,orderId,orderNumber,message);

@override
String toString() {
  return 'BasketState.orderPaymentInitiationFailed(orderId: $orderId, orderNumber: $orderNumber, message: $message)';
}


}

/// @nodoc
abstract mixin class _$OrderPaymentInitiationFailedCopyWith<$Res> implements $BasketStateCopyWith<$Res> {
  factory _$OrderPaymentInitiationFailedCopyWith(_OrderPaymentInitiationFailed value, $Res Function(_OrderPaymentInitiationFailed) _then) = __$OrderPaymentInitiationFailedCopyWithImpl;
@useResult
$Res call({
 int orderId, String? orderNumber, String message
});




}
/// @nodoc
class __$OrderPaymentInitiationFailedCopyWithImpl<$Res>
    implements _$OrderPaymentInitiationFailedCopyWith<$Res> {
  __$OrderPaymentInitiationFailedCopyWithImpl(this._self, this._then);

  final _OrderPaymentInitiationFailed _self;
  final $Res Function(_OrderPaymentInitiationFailed) _then;

/// Create a copy of BasketState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,Object? orderNumber = freezed,Object? message = null,}) {
  return _then(_OrderPaymentInitiationFailed(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,orderNumber: freezed == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PaymentVerifying implements BasketState {
  const _PaymentVerifying();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentVerifying);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BasketState.paymentVerifying()';
}


}




/// @nodoc


class _OrderCreated implements BasketState {
  const _OrderCreated({this.orderId, this.orderNumber});
  

 final  int? orderId;
 final  String? orderNumber;

/// Create a copy of BasketState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderCreatedCopyWith<_OrderCreated> get copyWith => __$OrderCreatedCopyWithImpl<_OrderCreated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderCreated&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber));
}


@override
int get hashCode => Object.hash(runtimeType,orderId,orderNumber);

@override
String toString() {
  return 'BasketState.orderCreated(orderId: $orderId, orderNumber: $orderNumber)';
}


}

/// @nodoc
abstract mixin class _$OrderCreatedCopyWith<$Res> implements $BasketStateCopyWith<$Res> {
  factory _$OrderCreatedCopyWith(_OrderCreated value, $Res Function(_OrderCreated) _then) = __$OrderCreatedCopyWithImpl;
@useResult
$Res call({
 int? orderId, String? orderNumber
});




}
/// @nodoc
class __$OrderCreatedCopyWithImpl<$Res>
    implements _$OrderCreatedCopyWith<$Res> {
  __$OrderCreatedCopyWithImpl(this._self, this._then);

  final _OrderCreated _self;
  final $Res Function(_OrderCreated) _then;

/// Create a copy of BasketState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = freezed,Object? orderNumber = freezed,}) {
  return _then(_OrderCreated(
orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int?,orderNumber: freezed == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _PaymentFailed implements BasketState {
  const _PaymentFailed(this.message);
  

 final  String message;

/// Create a copy of BasketState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentFailedCopyWith<_PaymentFailed> get copyWith => __$PaymentFailedCopyWithImpl<_PaymentFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'BasketState.paymentFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class _$PaymentFailedCopyWith<$Res> implements $BasketStateCopyWith<$Res> {
  factory _$PaymentFailedCopyWith(_PaymentFailed value, $Res Function(_PaymentFailed) _then) = __$PaymentFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$PaymentFailedCopyWithImpl<$Res>
    implements _$PaymentFailedCopyWith<$Res> {
  __$PaymentFailedCopyWithImpl(this._self, this._then);

  final _PaymentFailed _self;
  final $Res Function(_PaymentFailed) _then;

/// Create a copy of BasketState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_PaymentFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Error implements BasketState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of BasketState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'BasketState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $BasketStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of BasketState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

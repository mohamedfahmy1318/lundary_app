// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionPlanModel {

 int get id; String get name; String get slug; String? get description; String get price;@JsonKey(name: 'duration_days') int get durationDays;@JsonKey(name: 'item_limit') int get itemLimit;@JsonKey(name: 'unlimited_items') bool get unlimitedItems;@JsonKey(name: 'free_delivery') bool get freeDelivery;@JsonKey(name: 'express_service') bool get expressService;@JsonKey(name: 'priority_support') bool get prioritySupport;@JsonKey(name: 'discount_percentage') int get discountPercentage;@JsonKey(name: 'is_active') bool get isActive;
/// Create a copy of SubscriptionPlanModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionPlanModelCopyWith<SubscriptionPlanModel> get copyWith => _$SubscriptionPlanModelCopyWithImpl<SubscriptionPlanModel>(this as SubscriptionPlanModel, _$identity);

  /// Serializes this SubscriptionPlanModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionPlanModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.durationDays, durationDays) || other.durationDays == durationDays)&&(identical(other.itemLimit, itemLimit) || other.itemLimit == itemLimit)&&(identical(other.unlimitedItems, unlimitedItems) || other.unlimitedItems == unlimitedItems)&&(identical(other.freeDelivery, freeDelivery) || other.freeDelivery == freeDelivery)&&(identical(other.expressService, expressService) || other.expressService == expressService)&&(identical(other.prioritySupport, prioritySupport) || other.prioritySupport == prioritySupport)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,description,price,durationDays,itemLimit,unlimitedItems,freeDelivery,expressService,prioritySupport,discountPercentage,isActive);

@override
String toString() {
  return 'SubscriptionPlanModel(id: $id, name: $name, slug: $slug, description: $description, price: $price, durationDays: $durationDays, itemLimit: $itemLimit, unlimitedItems: $unlimitedItems, freeDelivery: $freeDelivery, expressService: $expressService, prioritySupport: $prioritySupport, discountPercentage: $discountPercentage, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $SubscriptionPlanModelCopyWith<$Res>  {
  factory $SubscriptionPlanModelCopyWith(SubscriptionPlanModel value, $Res Function(SubscriptionPlanModel) _then) = _$SubscriptionPlanModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String slug, String? description, String price,@JsonKey(name: 'duration_days') int durationDays,@JsonKey(name: 'item_limit') int itemLimit,@JsonKey(name: 'unlimited_items') bool unlimitedItems,@JsonKey(name: 'free_delivery') bool freeDelivery,@JsonKey(name: 'express_service') bool expressService,@JsonKey(name: 'priority_support') bool prioritySupport,@JsonKey(name: 'discount_percentage') int discountPercentage,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class _$SubscriptionPlanModelCopyWithImpl<$Res>
    implements $SubscriptionPlanModelCopyWith<$Res> {
  _$SubscriptionPlanModelCopyWithImpl(this._self, this._then);

  final SubscriptionPlanModel _self;
  final $Res Function(SubscriptionPlanModel) _then;

/// Create a copy of SubscriptionPlanModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? description = freezed,Object? price = null,Object? durationDays = null,Object? itemLimit = null,Object? unlimitedItems = null,Object? freeDelivery = null,Object? expressService = null,Object? prioritySupport = null,Object? discountPercentage = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,durationDays: null == durationDays ? _self.durationDays : durationDays // ignore: cast_nullable_to_non_nullable
as int,itemLimit: null == itemLimit ? _self.itemLimit : itemLimit // ignore: cast_nullable_to_non_nullable
as int,unlimitedItems: null == unlimitedItems ? _self.unlimitedItems : unlimitedItems // ignore: cast_nullable_to_non_nullable
as bool,freeDelivery: null == freeDelivery ? _self.freeDelivery : freeDelivery // ignore: cast_nullable_to_non_nullable
as bool,expressService: null == expressService ? _self.expressService : expressService // ignore: cast_nullable_to_non_nullable
as bool,prioritySupport: null == prioritySupport ? _self.prioritySupport : prioritySupport // ignore: cast_nullable_to_non_nullable
as bool,discountPercentage: null == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionPlanModel].
extension SubscriptionPlanModelPatterns on SubscriptionPlanModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionPlanModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionPlanModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionPlanModel value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionPlanModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionPlanModel value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionPlanModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String slug,  String? description,  String price, @JsonKey(name: 'duration_days')  int durationDays, @JsonKey(name: 'item_limit')  int itemLimit, @JsonKey(name: 'unlimited_items')  bool unlimitedItems, @JsonKey(name: 'free_delivery')  bool freeDelivery, @JsonKey(name: 'express_service')  bool expressService, @JsonKey(name: 'priority_support')  bool prioritySupport, @JsonKey(name: 'discount_percentage')  int discountPercentage, @JsonKey(name: 'is_active')  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionPlanModel() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.description,_that.price,_that.durationDays,_that.itemLimit,_that.unlimitedItems,_that.freeDelivery,_that.expressService,_that.prioritySupport,_that.discountPercentage,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String slug,  String? description,  String price, @JsonKey(name: 'duration_days')  int durationDays, @JsonKey(name: 'item_limit')  int itemLimit, @JsonKey(name: 'unlimited_items')  bool unlimitedItems, @JsonKey(name: 'free_delivery')  bool freeDelivery, @JsonKey(name: 'express_service')  bool expressService, @JsonKey(name: 'priority_support')  bool prioritySupport, @JsonKey(name: 'discount_percentage')  int discountPercentage, @JsonKey(name: 'is_active')  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionPlanModel():
return $default(_that.id,_that.name,_that.slug,_that.description,_that.price,_that.durationDays,_that.itemLimit,_that.unlimitedItems,_that.freeDelivery,_that.expressService,_that.prioritySupport,_that.discountPercentage,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String slug,  String? description,  String price, @JsonKey(name: 'duration_days')  int durationDays, @JsonKey(name: 'item_limit')  int itemLimit, @JsonKey(name: 'unlimited_items')  bool unlimitedItems, @JsonKey(name: 'free_delivery')  bool freeDelivery, @JsonKey(name: 'express_service')  bool expressService, @JsonKey(name: 'priority_support')  bool prioritySupport, @JsonKey(name: 'discount_percentage')  int discountPercentage, @JsonKey(name: 'is_active')  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionPlanModel() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.description,_that.price,_that.durationDays,_that.itemLimit,_that.unlimitedItems,_that.freeDelivery,_that.expressService,_that.prioritySupport,_that.discountPercentage,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionPlanModel extends SubscriptionPlanModel {
  const _SubscriptionPlanModel({required this.id, required this.name, required this.slug, this.description, required this.price, @JsonKey(name: 'duration_days') required this.durationDays, @JsonKey(name: 'item_limit') required this.itemLimit, @JsonKey(name: 'unlimited_items') required this.unlimitedItems, @JsonKey(name: 'free_delivery') required this.freeDelivery, @JsonKey(name: 'express_service') required this.expressService, @JsonKey(name: 'priority_support') required this.prioritySupport, @JsonKey(name: 'discount_percentage') required this.discountPercentage, @JsonKey(name: 'is_active') required this.isActive}): super._();
  factory _SubscriptionPlanModel.fromJson(Map<String, dynamic> json) => _$SubscriptionPlanModelFromJson(json);

@override final  int id;
@override final  String name;
@override final  String slug;
@override final  String? description;
@override final  String price;
@override@JsonKey(name: 'duration_days') final  int durationDays;
@override@JsonKey(name: 'item_limit') final  int itemLimit;
@override@JsonKey(name: 'unlimited_items') final  bool unlimitedItems;
@override@JsonKey(name: 'free_delivery') final  bool freeDelivery;
@override@JsonKey(name: 'express_service') final  bool expressService;
@override@JsonKey(name: 'priority_support') final  bool prioritySupport;
@override@JsonKey(name: 'discount_percentage') final  int discountPercentage;
@override@JsonKey(name: 'is_active') final  bool isActive;

/// Create a copy of SubscriptionPlanModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionPlanModelCopyWith<_SubscriptionPlanModel> get copyWith => __$SubscriptionPlanModelCopyWithImpl<_SubscriptionPlanModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionPlanModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionPlanModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.durationDays, durationDays) || other.durationDays == durationDays)&&(identical(other.itemLimit, itemLimit) || other.itemLimit == itemLimit)&&(identical(other.unlimitedItems, unlimitedItems) || other.unlimitedItems == unlimitedItems)&&(identical(other.freeDelivery, freeDelivery) || other.freeDelivery == freeDelivery)&&(identical(other.expressService, expressService) || other.expressService == expressService)&&(identical(other.prioritySupport, prioritySupport) || other.prioritySupport == prioritySupport)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,description,price,durationDays,itemLimit,unlimitedItems,freeDelivery,expressService,prioritySupport,discountPercentage,isActive);

@override
String toString() {
  return 'SubscriptionPlanModel(id: $id, name: $name, slug: $slug, description: $description, price: $price, durationDays: $durationDays, itemLimit: $itemLimit, unlimitedItems: $unlimitedItems, freeDelivery: $freeDelivery, expressService: $expressService, prioritySupport: $prioritySupport, discountPercentage: $discountPercentage, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionPlanModelCopyWith<$Res> implements $SubscriptionPlanModelCopyWith<$Res> {
  factory _$SubscriptionPlanModelCopyWith(_SubscriptionPlanModel value, $Res Function(_SubscriptionPlanModel) _then) = __$SubscriptionPlanModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String slug, String? description, String price,@JsonKey(name: 'duration_days') int durationDays,@JsonKey(name: 'item_limit') int itemLimit,@JsonKey(name: 'unlimited_items') bool unlimitedItems,@JsonKey(name: 'free_delivery') bool freeDelivery,@JsonKey(name: 'express_service') bool expressService,@JsonKey(name: 'priority_support') bool prioritySupport,@JsonKey(name: 'discount_percentage') int discountPercentage,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class __$SubscriptionPlanModelCopyWithImpl<$Res>
    implements _$SubscriptionPlanModelCopyWith<$Res> {
  __$SubscriptionPlanModelCopyWithImpl(this._self, this._then);

  final _SubscriptionPlanModel _self;
  final $Res Function(_SubscriptionPlanModel) _then;

/// Create a copy of SubscriptionPlanModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? description = freezed,Object? price = null,Object? durationDays = null,Object? itemLimit = null,Object? unlimitedItems = null,Object? freeDelivery = null,Object? expressService = null,Object? prioritySupport = null,Object? discountPercentage = null,Object? isActive = null,}) {
  return _then(_SubscriptionPlanModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,durationDays: null == durationDays ? _self.durationDays : durationDays // ignore: cast_nullable_to_non_nullable
as int,itemLimit: null == itemLimit ? _self.itemLimit : itemLimit // ignore: cast_nullable_to_non_nullable
as int,unlimitedItems: null == unlimitedItems ? _self.unlimitedItems : unlimitedItems // ignore: cast_nullable_to_non_nullable
as bool,freeDelivery: null == freeDelivery ? _self.freeDelivery : freeDelivery // ignore: cast_nullable_to_non_nullable
as bool,expressService: null == expressService ? _self.expressService : expressService // ignore: cast_nullable_to_non_nullable
as bool,prioritySupport: null == prioritySupport ? _self.prioritySupport : prioritySupport // ignore: cast_nullable_to_non_nullable
as bool,discountPercentage: null == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ActiveSubscriptionModel {

 int get id;@JsonKey(name: 'user_id') int get userId;@JsonKey(name: 'plan_id') int get planId;@JsonKey(name: 'starts_at') String get startsAt;@JsonKey(name: 'ends_at') String get endsAt;@JsonKey(name: 'items_used') int get itemsUsed; String get status;@JsonKey(name: 'amount_paid') String get amountPaid; SubscriptionPlanModel get plan;
/// Create a copy of ActiveSubscriptionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveSubscriptionModelCopyWith<ActiveSubscriptionModel> get copyWith => _$ActiveSubscriptionModelCopyWithImpl<ActiveSubscriptionModel>(this as ActiveSubscriptionModel, _$identity);

  /// Serializes this ActiveSubscriptionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveSubscriptionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.itemsUsed, itemsUsed) || other.itemsUsed == itemsUsed)&&(identical(other.status, status) || other.status == status)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.plan, plan) || other.plan == plan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,planId,startsAt,endsAt,itemsUsed,status,amountPaid,plan);

@override
String toString() {
  return 'ActiveSubscriptionModel(id: $id, userId: $userId, planId: $planId, startsAt: $startsAt, endsAt: $endsAt, itemsUsed: $itemsUsed, status: $status, amountPaid: $amountPaid, plan: $plan)';
}


}

/// @nodoc
abstract mixin class $ActiveSubscriptionModelCopyWith<$Res>  {
  factory $ActiveSubscriptionModelCopyWith(ActiveSubscriptionModel value, $Res Function(ActiveSubscriptionModel) _then) = _$ActiveSubscriptionModelCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'user_id') int userId,@JsonKey(name: 'plan_id') int planId,@JsonKey(name: 'starts_at') String startsAt,@JsonKey(name: 'ends_at') String endsAt,@JsonKey(name: 'items_used') int itemsUsed, String status,@JsonKey(name: 'amount_paid') String amountPaid, SubscriptionPlanModel plan
});


$SubscriptionPlanModelCopyWith<$Res> get plan;

}
/// @nodoc
class _$ActiveSubscriptionModelCopyWithImpl<$Res>
    implements $ActiveSubscriptionModelCopyWith<$Res> {
  _$ActiveSubscriptionModelCopyWithImpl(this._self, this._then);

  final ActiveSubscriptionModel _self;
  final $Res Function(ActiveSubscriptionModel) _then;

/// Create a copy of ActiveSubscriptionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? planId = null,Object? startsAt = null,Object? endsAt = null,Object? itemsUsed = null,Object? status = null,Object? amountPaid = null,Object? plan = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as String,itemsUsed: null == itemsUsed ? _self.itemsUsed : itemsUsed // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,amountPaid: null == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as String,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as SubscriptionPlanModel,
  ));
}
/// Create a copy of ActiveSubscriptionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionPlanModelCopyWith<$Res> get plan {
  
  return $SubscriptionPlanModelCopyWith<$Res>(_self.plan, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}


/// Adds pattern-matching-related methods to [ActiveSubscriptionModel].
extension ActiveSubscriptionModelPatterns on ActiveSubscriptionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActiveSubscriptionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActiveSubscriptionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActiveSubscriptionModel value)  $default,){
final _that = this;
switch (_that) {
case _ActiveSubscriptionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActiveSubscriptionModel value)?  $default,){
final _that = this;
switch (_that) {
case _ActiveSubscriptionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'user_id')  int userId, @JsonKey(name: 'plan_id')  int planId, @JsonKey(name: 'starts_at')  String startsAt, @JsonKey(name: 'ends_at')  String endsAt, @JsonKey(name: 'items_used')  int itemsUsed,  String status, @JsonKey(name: 'amount_paid')  String amountPaid,  SubscriptionPlanModel plan)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActiveSubscriptionModel() when $default != null:
return $default(_that.id,_that.userId,_that.planId,_that.startsAt,_that.endsAt,_that.itemsUsed,_that.status,_that.amountPaid,_that.plan);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'user_id')  int userId, @JsonKey(name: 'plan_id')  int planId, @JsonKey(name: 'starts_at')  String startsAt, @JsonKey(name: 'ends_at')  String endsAt, @JsonKey(name: 'items_used')  int itemsUsed,  String status, @JsonKey(name: 'amount_paid')  String amountPaid,  SubscriptionPlanModel plan)  $default,) {final _that = this;
switch (_that) {
case _ActiveSubscriptionModel():
return $default(_that.id,_that.userId,_that.planId,_that.startsAt,_that.endsAt,_that.itemsUsed,_that.status,_that.amountPaid,_that.plan);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'user_id')  int userId, @JsonKey(name: 'plan_id')  int planId, @JsonKey(name: 'starts_at')  String startsAt, @JsonKey(name: 'ends_at')  String endsAt, @JsonKey(name: 'items_used')  int itemsUsed,  String status, @JsonKey(name: 'amount_paid')  String amountPaid,  SubscriptionPlanModel plan)?  $default,) {final _that = this;
switch (_that) {
case _ActiveSubscriptionModel() when $default != null:
return $default(_that.id,_that.userId,_that.planId,_that.startsAt,_that.endsAt,_that.itemsUsed,_that.status,_that.amountPaid,_that.plan);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActiveSubscriptionModel extends ActiveSubscriptionModel {
  const _ActiveSubscriptionModel({required this.id, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'plan_id') required this.planId, @JsonKey(name: 'starts_at') required this.startsAt, @JsonKey(name: 'ends_at') required this.endsAt, @JsonKey(name: 'items_used') required this.itemsUsed, required this.status, @JsonKey(name: 'amount_paid') required this.amountPaid, required this.plan}): super._();
  factory _ActiveSubscriptionModel.fromJson(Map<String, dynamic> json) => _$ActiveSubscriptionModelFromJson(json);

@override final  int id;
@override@JsonKey(name: 'user_id') final  int userId;
@override@JsonKey(name: 'plan_id') final  int planId;
@override@JsonKey(name: 'starts_at') final  String startsAt;
@override@JsonKey(name: 'ends_at') final  String endsAt;
@override@JsonKey(name: 'items_used') final  int itemsUsed;
@override final  String status;
@override@JsonKey(name: 'amount_paid') final  String amountPaid;
@override final  SubscriptionPlanModel plan;

/// Create a copy of ActiveSubscriptionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveSubscriptionModelCopyWith<_ActiveSubscriptionModel> get copyWith => __$ActiveSubscriptionModelCopyWithImpl<_ActiveSubscriptionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActiveSubscriptionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveSubscriptionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.itemsUsed, itemsUsed) || other.itemsUsed == itemsUsed)&&(identical(other.status, status) || other.status == status)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.plan, plan) || other.plan == plan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,planId,startsAt,endsAt,itemsUsed,status,amountPaid,plan);

@override
String toString() {
  return 'ActiveSubscriptionModel(id: $id, userId: $userId, planId: $planId, startsAt: $startsAt, endsAt: $endsAt, itemsUsed: $itemsUsed, status: $status, amountPaid: $amountPaid, plan: $plan)';
}


}

/// @nodoc
abstract mixin class _$ActiveSubscriptionModelCopyWith<$Res> implements $ActiveSubscriptionModelCopyWith<$Res> {
  factory _$ActiveSubscriptionModelCopyWith(_ActiveSubscriptionModel value, $Res Function(_ActiveSubscriptionModel) _then) = __$ActiveSubscriptionModelCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'user_id') int userId,@JsonKey(name: 'plan_id') int planId,@JsonKey(name: 'starts_at') String startsAt,@JsonKey(name: 'ends_at') String endsAt,@JsonKey(name: 'items_used') int itemsUsed, String status,@JsonKey(name: 'amount_paid') String amountPaid, SubscriptionPlanModel plan
});


@override $SubscriptionPlanModelCopyWith<$Res> get plan;

}
/// @nodoc
class __$ActiveSubscriptionModelCopyWithImpl<$Res>
    implements _$ActiveSubscriptionModelCopyWith<$Res> {
  __$ActiveSubscriptionModelCopyWithImpl(this._self, this._then);

  final _ActiveSubscriptionModel _self;
  final $Res Function(_ActiveSubscriptionModel) _then;

/// Create a copy of ActiveSubscriptionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? planId = null,Object? startsAt = null,Object? endsAt = null,Object? itemsUsed = null,Object? status = null,Object? amountPaid = null,Object? plan = null,}) {
  return _then(_ActiveSubscriptionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as String,itemsUsed: null == itemsUsed ? _self.itemsUsed : itemsUsed // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,amountPaid: null == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as String,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as SubscriptionPlanModel,
  ));
}

/// Create a copy of ActiveSubscriptionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionPlanModelCopyWith<$Res> get plan {
  
  return $SubscriptionPlanModelCopyWith<$Res>(_self.plan, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}


/// @nodoc
mixin _$ProfileModel {

 int get id; String get name; String get email; String get phone;@JsonKey(name: 'wallet_balance') String? get walletBalance; String? get avatar; List<String> get addresses;@JsonKey(name: 'active_subscription') ActiveSubscriptionModel? get activeSubscription;
/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileModelCopyWith<ProfileModel> get copyWith => _$ProfileModelCopyWithImpl<ProfileModel>(this as ProfileModel, _$identity);

  /// Serializes this ProfileModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.walletBalance, walletBalance) || other.walletBalance == walletBalance)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&const DeepCollectionEquality().equals(other.addresses, addresses)&&(identical(other.activeSubscription, activeSubscription) || other.activeSubscription == activeSubscription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,phone,walletBalance,avatar,const DeepCollectionEquality().hash(addresses),activeSubscription);

@override
String toString() {
  return 'ProfileModel(id: $id, name: $name, email: $email, phone: $phone, walletBalance: $walletBalance, avatar: $avatar, addresses: $addresses, activeSubscription: $activeSubscription)';
}


}

/// @nodoc
abstract mixin class $ProfileModelCopyWith<$Res>  {
  factory $ProfileModelCopyWith(ProfileModel value, $Res Function(ProfileModel) _then) = _$ProfileModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String email, String phone,@JsonKey(name: 'wallet_balance') String? walletBalance, String? avatar, List<String> addresses,@JsonKey(name: 'active_subscription') ActiveSubscriptionModel? activeSubscription
});


$ActiveSubscriptionModelCopyWith<$Res>? get activeSubscription;

}
/// @nodoc
class _$ProfileModelCopyWithImpl<$Res>
    implements $ProfileModelCopyWith<$Res> {
  _$ProfileModelCopyWithImpl(this._self, this._then);

  final ProfileModel _self;
  final $Res Function(ProfileModel) _then;

/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? email = null,Object? phone = null,Object? walletBalance = freezed,Object? avatar = freezed,Object? addresses = null,Object? activeSubscription = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,walletBalance: freezed == walletBalance ? _self.walletBalance : walletBalance // ignore: cast_nullable_to_non_nullable
as String?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,addresses: null == addresses ? _self.addresses : addresses // ignore: cast_nullable_to_non_nullable
as List<String>,activeSubscription: freezed == activeSubscription ? _self.activeSubscription : activeSubscription // ignore: cast_nullable_to_non_nullable
as ActiveSubscriptionModel?,
  ));
}
/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActiveSubscriptionModelCopyWith<$Res>? get activeSubscription {
    if (_self.activeSubscription == null) {
    return null;
  }

  return $ActiveSubscriptionModelCopyWith<$Res>(_self.activeSubscription!, (value) {
    return _then(_self.copyWith(activeSubscription: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfileModel].
extension ProfileModelPatterns on ProfileModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileModel value)  $default,){
final _that = this;
switch (_that) {
case _ProfileModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String email,  String phone, @JsonKey(name: 'wallet_balance')  String? walletBalance,  String? avatar,  List<String> addresses, @JsonKey(name: 'active_subscription')  ActiveSubscriptionModel? activeSubscription)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileModel() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.phone,_that.walletBalance,_that.avatar,_that.addresses,_that.activeSubscription);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String email,  String phone, @JsonKey(name: 'wallet_balance')  String? walletBalance,  String? avatar,  List<String> addresses, @JsonKey(name: 'active_subscription')  ActiveSubscriptionModel? activeSubscription)  $default,) {final _that = this;
switch (_that) {
case _ProfileModel():
return $default(_that.id,_that.name,_that.email,_that.phone,_that.walletBalance,_that.avatar,_that.addresses,_that.activeSubscription);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String email,  String phone, @JsonKey(name: 'wallet_balance')  String? walletBalance,  String? avatar,  List<String> addresses, @JsonKey(name: 'active_subscription')  ActiveSubscriptionModel? activeSubscription)?  $default,) {final _that = this;
switch (_that) {
case _ProfileModel() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.phone,_that.walletBalance,_that.avatar,_that.addresses,_that.activeSubscription);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileModel extends ProfileModel {
  const _ProfileModel({required this.id, required this.name, required this.email, required this.phone, @JsonKey(name: 'wallet_balance') this.walletBalance, this.avatar, final  List<String> addresses = const <String>[], @JsonKey(name: 'active_subscription') this.activeSubscription}): _addresses = addresses,super._();
  factory _ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);

@override final  int id;
@override final  String name;
@override final  String email;
@override final  String phone;
@override@JsonKey(name: 'wallet_balance') final  String? walletBalance;
@override final  String? avatar;
 final  List<String> _addresses;
@override@JsonKey() List<String> get addresses {
  if (_addresses is EqualUnmodifiableListView) return _addresses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addresses);
}

@override@JsonKey(name: 'active_subscription') final  ActiveSubscriptionModel? activeSubscription;

/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileModelCopyWith<_ProfileModel> get copyWith => __$ProfileModelCopyWithImpl<_ProfileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.walletBalance, walletBalance) || other.walletBalance == walletBalance)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&const DeepCollectionEquality().equals(other._addresses, _addresses)&&(identical(other.activeSubscription, activeSubscription) || other.activeSubscription == activeSubscription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,phone,walletBalance,avatar,const DeepCollectionEquality().hash(_addresses),activeSubscription);

@override
String toString() {
  return 'ProfileModel(id: $id, name: $name, email: $email, phone: $phone, walletBalance: $walletBalance, avatar: $avatar, addresses: $addresses, activeSubscription: $activeSubscription)';
}


}

/// @nodoc
abstract mixin class _$ProfileModelCopyWith<$Res> implements $ProfileModelCopyWith<$Res> {
  factory _$ProfileModelCopyWith(_ProfileModel value, $Res Function(_ProfileModel) _then) = __$ProfileModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String email, String phone,@JsonKey(name: 'wallet_balance') String? walletBalance, String? avatar, List<String> addresses,@JsonKey(name: 'active_subscription') ActiveSubscriptionModel? activeSubscription
});


@override $ActiveSubscriptionModelCopyWith<$Res>? get activeSubscription;

}
/// @nodoc
class __$ProfileModelCopyWithImpl<$Res>
    implements _$ProfileModelCopyWith<$Res> {
  __$ProfileModelCopyWithImpl(this._self, this._then);

  final _ProfileModel _self;
  final $Res Function(_ProfileModel) _then;

/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? email = null,Object? phone = null,Object? walletBalance = freezed,Object? avatar = freezed,Object? addresses = null,Object? activeSubscription = freezed,}) {
  return _then(_ProfileModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,walletBalance: freezed == walletBalance ? _self.walletBalance : walletBalance // ignore: cast_nullable_to_non_nullable
as String?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,addresses: null == addresses ? _self._addresses : addresses // ignore: cast_nullable_to_non_nullable
as List<String>,activeSubscription: freezed == activeSubscription ? _self.activeSubscription : activeSubscription // ignore: cast_nullable_to_non_nullable
as ActiveSubscriptionModel?,
  ));
}

/// Create a copy of ProfileModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActiveSubscriptionModelCopyWith<$Res>? get activeSubscription {
    if (_self.activeSubscription == null) {
    return null;
  }

  return $ActiveSubscriptionModelCopyWith<$Res>(_self.activeSubscription!, (value) {
    return _then(_self.copyWith(activeSubscription: value));
  });
}
}

// dart format on

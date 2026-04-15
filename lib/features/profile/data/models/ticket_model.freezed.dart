// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TicketLookupOptionModel {

 String get value; String get label;
/// Create a copy of TicketLookupOptionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketLookupOptionModelCopyWith<TicketLookupOptionModel> get copyWith => _$TicketLookupOptionModelCopyWithImpl<TicketLookupOptionModel>(this as TicketLookupOptionModel, _$identity);

  /// Serializes this TicketLookupOptionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketLookupOptionModel&&(identical(other.value, value) || other.value == value)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,label);

@override
String toString() {
  return 'TicketLookupOptionModel(value: $value, label: $label)';
}


}

/// @nodoc
abstract mixin class $TicketLookupOptionModelCopyWith<$Res>  {
  factory $TicketLookupOptionModelCopyWith(TicketLookupOptionModel value, $Res Function(TicketLookupOptionModel) _then) = _$TicketLookupOptionModelCopyWithImpl;
@useResult
$Res call({
 String value, String label
});




}
/// @nodoc
class _$TicketLookupOptionModelCopyWithImpl<$Res>
    implements $TicketLookupOptionModelCopyWith<$Res> {
  _$TicketLookupOptionModelCopyWithImpl(this._self, this._then);

  final TicketLookupOptionModel _self;
  final $Res Function(TicketLookupOptionModel) _then;

/// Create a copy of TicketLookupOptionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? label = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketLookupOptionModel].
extension TicketLookupOptionModelPatterns on TicketLookupOptionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketLookupOptionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketLookupOptionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketLookupOptionModel value)  $default,){
final _that = this;
switch (_that) {
case _TicketLookupOptionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketLookupOptionModel value)?  $default,){
final _that = this;
switch (_that) {
case _TicketLookupOptionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String value,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketLookupOptionModel() when $default != null:
return $default(_that.value,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String value,  String label)  $default,) {final _that = this;
switch (_that) {
case _TicketLookupOptionModel():
return $default(_that.value,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String value,  String label)?  $default,) {final _that = this;
switch (_that) {
case _TicketLookupOptionModel() when $default != null:
return $default(_that.value,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketLookupOptionModel extends TicketLookupOptionModel {
  const _TicketLookupOptionModel({required this.value, required this.label}): super._();
  factory _TicketLookupOptionModel.fromJson(Map<String, dynamic> json) => _$TicketLookupOptionModelFromJson(json);

@override final  String value;
@override final  String label;

/// Create a copy of TicketLookupOptionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketLookupOptionModelCopyWith<_TicketLookupOptionModel> get copyWith => __$TicketLookupOptionModelCopyWithImpl<_TicketLookupOptionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketLookupOptionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketLookupOptionModel&&(identical(other.value, value) || other.value == value)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,label);

@override
String toString() {
  return 'TicketLookupOptionModel(value: $value, label: $label)';
}


}

/// @nodoc
abstract mixin class _$TicketLookupOptionModelCopyWith<$Res> implements $TicketLookupOptionModelCopyWith<$Res> {
  factory _$TicketLookupOptionModelCopyWith(_TicketLookupOptionModel value, $Res Function(_TicketLookupOptionModel) _then) = __$TicketLookupOptionModelCopyWithImpl;
@override @useResult
$Res call({
 String value, String label
});




}
/// @nodoc
class __$TicketLookupOptionModelCopyWithImpl<$Res>
    implements _$TicketLookupOptionModelCopyWith<$Res> {
  __$TicketLookupOptionModelCopyWithImpl(this._self, this._then);

  final _TicketLookupOptionModel _self;
  final $Res Function(_TicketLookupOptionModel) _then;

/// Create a copy of TicketLookupOptionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? label = null,}) {
  return _then(_TicketLookupOptionModel(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TicketReplyUserModel {

 int get id; String get name; String get role;
/// Create a copy of TicketReplyUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketReplyUserModelCopyWith<TicketReplyUserModel> get copyWith => _$TicketReplyUserModelCopyWithImpl<TicketReplyUserModel>(this as TicketReplyUserModel, _$identity);

  /// Serializes this TicketReplyUserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketReplyUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,role);

@override
String toString() {
  return 'TicketReplyUserModel(id: $id, name: $name, role: $role)';
}


}

/// @nodoc
abstract mixin class $TicketReplyUserModelCopyWith<$Res>  {
  factory $TicketReplyUserModelCopyWith(TicketReplyUserModel value, $Res Function(TicketReplyUserModel) _then) = _$TicketReplyUserModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String role
});




}
/// @nodoc
class _$TicketReplyUserModelCopyWithImpl<$Res>
    implements $TicketReplyUserModelCopyWith<$Res> {
  _$TicketReplyUserModelCopyWithImpl(this._self, this._then);

  final TicketReplyUserModel _self;
  final $Res Function(TicketReplyUserModel) _then;

/// Create a copy of TicketReplyUserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? role = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketReplyUserModel].
extension TicketReplyUserModelPatterns on TicketReplyUserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketReplyUserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketReplyUserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketReplyUserModel value)  $default,){
final _that = this;
switch (_that) {
case _TicketReplyUserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketReplyUserModel value)?  $default,){
final _that = this;
switch (_that) {
case _TicketReplyUserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketReplyUserModel() when $default != null:
return $default(_that.id,_that.name,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String role)  $default,) {final _that = this;
switch (_that) {
case _TicketReplyUserModel():
return $default(_that.id,_that.name,_that.role);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String role)?  $default,) {final _that = this;
switch (_that) {
case _TicketReplyUserModel() when $default != null:
return $default(_that.id,_that.name,_that.role);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketReplyUserModel extends TicketReplyUserModel {
  const _TicketReplyUserModel({required this.id, required this.name, required this.role}): super._();
  factory _TicketReplyUserModel.fromJson(Map<String, dynamic> json) => _$TicketReplyUserModelFromJson(json);

@override final  int id;
@override final  String name;
@override final  String role;

/// Create a copy of TicketReplyUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketReplyUserModelCopyWith<_TicketReplyUserModel> get copyWith => __$TicketReplyUserModelCopyWithImpl<_TicketReplyUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketReplyUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketReplyUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,role);

@override
String toString() {
  return 'TicketReplyUserModel(id: $id, name: $name, role: $role)';
}


}

/// @nodoc
abstract mixin class _$TicketReplyUserModelCopyWith<$Res> implements $TicketReplyUserModelCopyWith<$Res> {
  factory _$TicketReplyUserModelCopyWith(_TicketReplyUserModel value, $Res Function(_TicketReplyUserModel) _then) = __$TicketReplyUserModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String role
});




}
/// @nodoc
class __$TicketReplyUserModelCopyWithImpl<$Res>
    implements _$TicketReplyUserModelCopyWith<$Res> {
  __$TicketReplyUserModelCopyWithImpl(this._self, this._then);

  final _TicketReplyUserModel _self;
  final $Res Function(_TicketReplyUserModel) _then;

/// Create a copy of TicketReplyUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? role = null,}) {
  return _then(_TicketReplyUserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TicketReplyModel {

 int get id;@JsonKey(name: 'ticket_id') int get ticketId;@JsonKey(name: 'user_id') int get userId; String get message;@JsonKey(name: 'is_staff_reply') bool get isStaffReply; String? get attachments;@JsonKey(name: 'created_at') String get createdAt;@JsonKey(name: 'updated_at') String get updatedAt; TicketReplyUserModel? get user;
/// Create a copy of TicketReplyModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketReplyModelCopyWith<TicketReplyModel> get copyWith => _$TicketReplyModelCopyWithImpl<TicketReplyModel>(this as TicketReplyModel, _$identity);

  /// Serializes this TicketReplyModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketReplyModel&&(identical(other.id, id) || other.id == id)&&(identical(other.ticketId, ticketId) || other.ticketId == ticketId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.message, message) || other.message == message)&&(identical(other.isStaffReply, isStaffReply) || other.isStaffReply == isStaffReply)&&(identical(other.attachments, attachments) || other.attachments == attachments)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ticketId,userId,message,isStaffReply,attachments,createdAt,updatedAt,user);

@override
String toString() {
  return 'TicketReplyModel(id: $id, ticketId: $ticketId, userId: $userId, message: $message, isStaffReply: $isStaffReply, attachments: $attachments, createdAt: $createdAt, updatedAt: $updatedAt, user: $user)';
}


}

/// @nodoc
abstract mixin class $TicketReplyModelCopyWith<$Res>  {
  factory $TicketReplyModelCopyWith(TicketReplyModel value, $Res Function(TicketReplyModel) _then) = _$TicketReplyModelCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'ticket_id') int ticketId,@JsonKey(name: 'user_id') int userId, String message,@JsonKey(name: 'is_staff_reply') bool isStaffReply, String? attachments,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt, TicketReplyUserModel? user
});


$TicketReplyUserModelCopyWith<$Res>? get user;

}
/// @nodoc
class _$TicketReplyModelCopyWithImpl<$Res>
    implements $TicketReplyModelCopyWith<$Res> {
  _$TicketReplyModelCopyWithImpl(this._self, this._then);

  final TicketReplyModel _self;
  final $Res Function(TicketReplyModel) _then;

/// Create a copy of TicketReplyModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ticketId = null,Object? userId = null,Object? message = null,Object? isStaffReply = null,Object? attachments = freezed,Object? createdAt = null,Object? updatedAt = null,Object? user = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,ticketId: null == ticketId ? _self.ticketId : ticketId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,isStaffReply: null == isStaffReply ? _self.isStaffReply : isStaffReply // ignore: cast_nullable_to_non_nullable
as bool,attachments: freezed == attachments ? _self.attachments : attachments // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as TicketReplyUserModel?,
  ));
}
/// Create a copy of TicketReplyModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketReplyUserModelCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $TicketReplyUserModelCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [TicketReplyModel].
extension TicketReplyModelPatterns on TicketReplyModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketReplyModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketReplyModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketReplyModel value)  $default,){
final _that = this;
switch (_that) {
case _TicketReplyModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketReplyModel value)?  $default,){
final _that = this;
switch (_that) {
case _TicketReplyModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'ticket_id')  int ticketId, @JsonKey(name: 'user_id')  int userId,  String message, @JsonKey(name: 'is_staff_reply')  bool isStaffReply,  String? attachments, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt,  TicketReplyUserModel? user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketReplyModel() when $default != null:
return $default(_that.id,_that.ticketId,_that.userId,_that.message,_that.isStaffReply,_that.attachments,_that.createdAt,_that.updatedAt,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'ticket_id')  int ticketId, @JsonKey(name: 'user_id')  int userId,  String message, @JsonKey(name: 'is_staff_reply')  bool isStaffReply,  String? attachments, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt,  TicketReplyUserModel? user)  $default,) {final _that = this;
switch (_that) {
case _TicketReplyModel():
return $default(_that.id,_that.ticketId,_that.userId,_that.message,_that.isStaffReply,_that.attachments,_that.createdAt,_that.updatedAt,_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'ticket_id')  int ticketId, @JsonKey(name: 'user_id')  int userId,  String message, @JsonKey(name: 'is_staff_reply')  bool isStaffReply,  String? attachments, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt,  TicketReplyUserModel? user)?  $default,) {final _that = this;
switch (_that) {
case _TicketReplyModel() when $default != null:
return $default(_that.id,_that.ticketId,_that.userId,_that.message,_that.isStaffReply,_that.attachments,_that.createdAt,_that.updatedAt,_that.user);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketReplyModel extends TicketReplyModel {
  const _TicketReplyModel({required this.id, @JsonKey(name: 'ticket_id') required this.ticketId, @JsonKey(name: 'user_id') required this.userId, required this.message, @JsonKey(name: 'is_staff_reply') required this.isStaffReply, this.attachments, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt, this.user}): super._();
  factory _TicketReplyModel.fromJson(Map<String, dynamic> json) => _$TicketReplyModelFromJson(json);

@override final  int id;
@override@JsonKey(name: 'ticket_id') final  int ticketId;
@override@JsonKey(name: 'user_id') final  int userId;
@override final  String message;
@override@JsonKey(name: 'is_staff_reply') final  bool isStaffReply;
@override final  String? attachments;
@override@JsonKey(name: 'created_at') final  String createdAt;
@override@JsonKey(name: 'updated_at') final  String updatedAt;
@override final  TicketReplyUserModel? user;

/// Create a copy of TicketReplyModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketReplyModelCopyWith<_TicketReplyModel> get copyWith => __$TicketReplyModelCopyWithImpl<_TicketReplyModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketReplyModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketReplyModel&&(identical(other.id, id) || other.id == id)&&(identical(other.ticketId, ticketId) || other.ticketId == ticketId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.message, message) || other.message == message)&&(identical(other.isStaffReply, isStaffReply) || other.isStaffReply == isStaffReply)&&(identical(other.attachments, attachments) || other.attachments == attachments)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ticketId,userId,message,isStaffReply,attachments,createdAt,updatedAt,user);

@override
String toString() {
  return 'TicketReplyModel(id: $id, ticketId: $ticketId, userId: $userId, message: $message, isStaffReply: $isStaffReply, attachments: $attachments, createdAt: $createdAt, updatedAt: $updatedAt, user: $user)';
}


}

/// @nodoc
abstract mixin class _$TicketReplyModelCopyWith<$Res> implements $TicketReplyModelCopyWith<$Res> {
  factory _$TicketReplyModelCopyWith(_TicketReplyModel value, $Res Function(_TicketReplyModel) _then) = __$TicketReplyModelCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'ticket_id') int ticketId,@JsonKey(name: 'user_id') int userId, String message,@JsonKey(name: 'is_staff_reply') bool isStaffReply, String? attachments,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt, TicketReplyUserModel? user
});


@override $TicketReplyUserModelCopyWith<$Res>? get user;

}
/// @nodoc
class __$TicketReplyModelCopyWithImpl<$Res>
    implements _$TicketReplyModelCopyWith<$Res> {
  __$TicketReplyModelCopyWithImpl(this._self, this._then);

  final _TicketReplyModel _self;
  final $Res Function(_TicketReplyModel) _then;

/// Create a copy of TicketReplyModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ticketId = null,Object? userId = null,Object? message = null,Object? isStaffReply = null,Object? attachments = freezed,Object? createdAt = null,Object? updatedAt = null,Object? user = freezed,}) {
  return _then(_TicketReplyModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,ticketId: null == ticketId ? _self.ticketId : ticketId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,isStaffReply: null == isStaffReply ? _self.isStaffReply : isStaffReply // ignore: cast_nullable_to_non_nullable
as bool,attachments: freezed == attachments ? _self.attachments : attachments // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as TicketReplyUserModel?,
  ));
}

/// Create a copy of TicketReplyModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketReplyUserModelCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $TicketReplyUserModelCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$TicketModel {

 int get id;@JsonKey(name: 'ticket_number') String get ticketNumber;@JsonKey(name: 'user_id') int get userId;@JsonKey(name: 'order_id') int? get orderId; String get subject; String get description; String get category; String get priority;@TicketStatusJsonConverter() TicketStatus get status;@JsonKey(name: 'assigned_to') String? get assignedTo;@JsonKey(name: 'first_response_at') String? get firstResponseAt;@JsonKey(name: 'resolved_at') String? get resolvedAt;@JsonKey(name: 'created_at') String get createdAt;@JsonKey(name: 'updated_at') String get updatedAt; List<TicketReplyModel>? get replies;
/// Create a copy of TicketModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketModelCopyWith<TicketModel> get copyWith => _$TicketModelCopyWithImpl<TicketModel>(this as TicketModel, _$identity);

  /// Serializes this TicketModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketModel&&(identical(other.id, id) || other.id == id)&&(identical(other.ticketNumber, ticketNumber) || other.ticketNumber == ticketNumber)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.assignedTo, assignedTo) || other.assignedTo == assignedTo)&&(identical(other.firstResponseAt, firstResponseAt) || other.firstResponseAt == firstResponseAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.replies, replies));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ticketNumber,userId,orderId,subject,description,category,priority,status,assignedTo,firstResponseAt,resolvedAt,createdAt,updatedAt,const DeepCollectionEquality().hash(replies));

@override
String toString() {
  return 'TicketModel(id: $id, ticketNumber: $ticketNumber, userId: $userId, orderId: $orderId, subject: $subject, description: $description, category: $category, priority: $priority, status: $status, assignedTo: $assignedTo, firstResponseAt: $firstResponseAt, resolvedAt: $resolvedAt, createdAt: $createdAt, updatedAt: $updatedAt, replies: $replies)';
}


}

/// @nodoc
abstract mixin class $TicketModelCopyWith<$Res>  {
  factory $TicketModelCopyWith(TicketModel value, $Res Function(TicketModel) _then) = _$TicketModelCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'ticket_number') String ticketNumber,@JsonKey(name: 'user_id') int userId,@JsonKey(name: 'order_id') int? orderId, String subject, String description, String category, String priority,@TicketStatusJsonConverter() TicketStatus status,@JsonKey(name: 'assigned_to') String? assignedTo,@JsonKey(name: 'first_response_at') String? firstResponseAt,@JsonKey(name: 'resolved_at') String? resolvedAt,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt, List<TicketReplyModel>? replies
});




}
/// @nodoc
class _$TicketModelCopyWithImpl<$Res>
    implements $TicketModelCopyWith<$Res> {
  _$TicketModelCopyWithImpl(this._self, this._then);

  final TicketModel _self;
  final $Res Function(TicketModel) _then;

/// Create a copy of TicketModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ticketNumber = null,Object? userId = null,Object? orderId = freezed,Object? subject = null,Object? description = null,Object? category = null,Object? priority = null,Object? status = null,Object? assignedTo = freezed,Object? firstResponseAt = freezed,Object? resolvedAt = freezed,Object? createdAt = null,Object? updatedAt = null,Object? replies = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,ticketNumber: null == ticketNumber ? _self.ticketNumber : ticketNumber // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int?,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TicketStatus,assignedTo: freezed == assignedTo ? _self.assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as String?,firstResponseAt: freezed == firstResponseAt ? _self.firstResponseAt : firstResponseAt // ignore: cast_nullable_to_non_nullable
as String?,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,replies: freezed == replies ? _self.replies : replies // ignore: cast_nullable_to_non_nullable
as List<TicketReplyModel>?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketModel].
extension TicketModelPatterns on TicketModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketModel value)  $default,){
final _that = this;
switch (_that) {
case _TicketModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketModel value)?  $default,){
final _that = this;
switch (_that) {
case _TicketModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'ticket_number')  String ticketNumber, @JsonKey(name: 'user_id')  int userId, @JsonKey(name: 'order_id')  int? orderId,  String subject,  String description,  String category,  String priority, @TicketStatusJsonConverter()  TicketStatus status, @JsonKey(name: 'assigned_to')  String? assignedTo, @JsonKey(name: 'first_response_at')  String? firstResponseAt, @JsonKey(name: 'resolved_at')  String? resolvedAt, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt,  List<TicketReplyModel>? replies)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketModel() when $default != null:
return $default(_that.id,_that.ticketNumber,_that.userId,_that.orderId,_that.subject,_that.description,_that.category,_that.priority,_that.status,_that.assignedTo,_that.firstResponseAt,_that.resolvedAt,_that.createdAt,_that.updatedAt,_that.replies);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'ticket_number')  String ticketNumber, @JsonKey(name: 'user_id')  int userId, @JsonKey(name: 'order_id')  int? orderId,  String subject,  String description,  String category,  String priority, @TicketStatusJsonConverter()  TicketStatus status, @JsonKey(name: 'assigned_to')  String? assignedTo, @JsonKey(name: 'first_response_at')  String? firstResponseAt, @JsonKey(name: 'resolved_at')  String? resolvedAt, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt,  List<TicketReplyModel>? replies)  $default,) {final _that = this;
switch (_that) {
case _TicketModel():
return $default(_that.id,_that.ticketNumber,_that.userId,_that.orderId,_that.subject,_that.description,_that.category,_that.priority,_that.status,_that.assignedTo,_that.firstResponseAt,_that.resolvedAt,_that.createdAt,_that.updatedAt,_that.replies);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'ticket_number')  String ticketNumber, @JsonKey(name: 'user_id')  int userId, @JsonKey(name: 'order_id')  int? orderId,  String subject,  String description,  String category,  String priority, @TicketStatusJsonConverter()  TicketStatus status, @JsonKey(name: 'assigned_to')  String? assignedTo, @JsonKey(name: 'first_response_at')  String? firstResponseAt, @JsonKey(name: 'resolved_at')  String? resolvedAt, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt,  List<TicketReplyModel>? replies)?  $default,) {final _that = this;
switch (_that) {
case _TicketModel() when $default != null:
return $default(_that.id,_that.ticketNumber,_that.userId,_that.orderId,_that.subject,_that.description,_that.category,_that.priority,_that.status,_that.assignedTo,_that.firstResponseAt,_that.resolvedAt,_that.createdAt,_that.updatedAt,_that.replies);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketModel extends TicketModel {
  const _TicketModel({required this.id, @JsonKey(name: 'ticket_number') required this.ticketNumber, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'order_id') this.orderId, required this.subject, required this.description, required this.category, required this.priority, @TicketStatusJsonConverter() required this.status, @JsonKey(name: 'assigned_to') this.assignedTo, @JsonKey(name: 'first_response_at') this.firstResponseAt, @JsonKey(name: 'resolved_at') this.resolvedAt, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt, final  List<TicketReplyModel>? replies}): _replies = replies,super._();
  factory _TicketModel.fromJson(Map<String, dynamic> json) => _$TicketModelFromJson(json);

@override final  int id;
@override@JsonKey(name: 'ticket_number') final  String ticketNumber;
@override@JsonKey(name: 'user_id') final  int userId;
@override@JsonKey(name: 'order_id') final  int? orderId;
@override final  String subject;
@override final  String description;
@override final  String category;
@override final  String priority;
@override@TicketStatusJsonConverter() final  TicketStatus status;
@override@JsonKey(name: 'assigned_to') final  String? assignedTo;
@override@JsonKey(name: 'first_response_at') final  String? firstResponseAt;
@override@JsonKey(name: 'resolved_at') final  String? resolvedAt;
@override@JsonKey(name: 'created_at') final  String createdAt;
@override@JsonKey(name: 'updated_at') final  String updatedAt;
 final  List<TicketReplyModel>? _replies;
@override List<TicketReplyModel>? get replies {
  final value = _replies;
  if (value == null) return null;
  if (_replies is EqualUnmodifiableListView) return _replies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of TicketModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketModelCopyWith<_TicketModel> get copyWith => __$TicketModelCopyWithImpl<_TicketModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketModel&&(identical(other.id, id) || other.id == id)&&(identical(other.ticketNumber, ticketNumber) || other.ticketNumber == ticketNumber)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.assignedTo, assignedTo) || other.assignedTo == assignedTo)&&(identical(other.firstResponseAt, firstResponseAt) || other.firstResponseAt == firstResponseAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._replies, _replies));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ticketNumber,userId,orderId,subject,description,category,priority,status,assignedTo,firstResponseAt,resolvedAt,createdAt,updatedAt,const DeepCollectionEquality().hash(_replies));

@override
String toString() {
  return 'TicketModel(id: $id, ticketNumber: $ticketNumber, userId: $userId, orderId: $orderId, subject: $subject, description: $description, category: $category, priority: $priority, status: $status, assignedTo: $assignedTo, firstResponseAt: $firstResponseAt, resolvedAt: $resolvedAt, createdAt: $createdAt, updatedAt: $updatedAt, replies: $replies)';
}


}

/// @nodoc
abstract mixin class _$TicketModelCopyWith<$Res> implements $TicketModelCopyWith<$Res> {
  factory _$TicketModelCopyWith(_TicketModel value, $Res Function(_TicketModel) _then) = __$TicketModelCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'ticket_number') String ticketNumber,@JsonKey(name: 'user_id') int userId,@JsonKey(name: 'order_id') int? orderId, String subject, String description, String category, String priority,@TicketStatusJsonConverter() TicketStatus status,@JsonKey(name: 'assigned_to') String? assignedTo,@JsonKey(name: 'first_response_at') String? firstResponseAt,@JsonKey(name: 'resolved_at') String? resolvedAt,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt, List<TicketReplyModel>? replies
});




}
/// @nodoc
class __$TicketModelCopyWithImpl<$Res>
    implements _$TicketModelCopyWith<$Res> {
  __$TicketModelCopyWithImpl(this._self, this._then);

  final _TicketModel _self;
  final $Res Function(_TicketModel) _then;

/// Create a copy of TicketModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ticketNumber = null,Object? userId = null,Object? orderId = freezed,Object? subject = null,Object? description = null,Object? category = null,Object? priority = null,Object? status = null,Object? assignedTo = freezed,Object? firstResponseAt = freezed,Object? resolvedAt = freezed,Object? createdAt = null,Object? updatedAt = null,Object? replies = freezed,}) {
  return _then(_TicketModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,ticketNumber: null == ticketNumber ? _self.ticketNumber : ticketNumber // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int?,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TicketStatus,assignedTo: freezed == assignedTo ? _self.assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as String?,firstResponseAt: freezed == firstResponseAt ? _self.firstResponseAt : firstResponseAt // ignore: cast_nullable_to_non_nullable
as String?,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,replies: freezed == replies ? _self._replies : replies // ignore: cast_nullable_to_non_nullable
as List<TicketReplyModel>?,
  ));
}


}

// dart format on

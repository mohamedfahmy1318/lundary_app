// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'on_boarding_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OnBoardingModel {

 int get id; String get title; String get description; String? get image;
/// Create a copy of OnBoardingModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnBoardingModelCopyWith<OnBoardingModel> get copyWith => _$OnBoardingModelCopyWithImpl<OnBoardingModel>(this as OnBoardingModel, _$identity);

  /// Serializes this OnBoardingModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnBoardingModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,image);

@override
String toString() {
  return 'OnBoardingModel(id: $id, title: $title, description: $description, image: $image)';
}


}

/// @nodoc
abstract mixin class $OnBoardingModelCopyWith<$Res>  {
  factory $OnBoardingModelCopyWith(OnBoardingModel value, $Res Function(OnBoardingModel) _then) = _$OnBoardingModelCopyWithImpl;
@useResult
$Res call({
 int id, String title, String description, String? image
});




}
/// @nodoc
class _$OnBoardingModelCopyWithImpl<$Res>
    implements $OnBoardingModelCopyWith<$Res> {
  _$OnBoardingModelCopyWithImpl(this._self, this._then);

  final OnBoardingModel _self;
  final $Res Function(OnBoardingModel) _then;

/// Create a copy of OnBoardingModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? image = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OnBoardingModel].
extension OnBoardingModelPatterns on OnBoardingModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnBoardingModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnBoardingModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnBoardingModel value)  $default,){
final _that = this;
switch (_that) {
case _OnBoardingModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnBoardingModel value)?  $default,){
final _that = this;
switch (_that) {
case _OnBoardingModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String description,  String? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnBoardingModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String description,  String? image)  $default,) {final _that = this;
switch (_that) {
case _OnBoardingModel():
return $default(_that.id,_that.title,_that.description,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String description,  String? image)?  $default,) {final _that = this;
switch (_that) {
case _OnBoardingModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OnBoardingModel extends OnBoardingModel {
  const _OnBoardingModel({required this.id, required this.title, required this.description, required this.image}): super._();
  factory _OnBoardingModel.fromJson(Map<String, dynamic> json) => _$OnBoardingModelFromJson(json);

@override final  int id;
@override final  String title;
@override final  String description;
@override final  String? image;

/// Create a copy of OnBoardingModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnBoardingModelCopyWith<_OnBoardingModel> get copyWith => __$OnBoardingModelCopyWithImpl<_OnBoardingModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OnBoardingModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnBoardingModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,image);

@override
String toString() {
  return 'OnBoardingModel(id: $id, title: $title, description: $description, image: $image)';
}


}

/// @nodoc
abstract mixin class _$OnBoardingModelCopyWith<$Res> implements $OnBoardingModelCopyWith<$Res> {
  factory _$OnBoardingModelCopyWith(_OnBoardingModel value, $Res Function(_OnBoardingModel) _then) = __$OnBoardingModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String description, String? image
});




}
/// @nodoc
class __$OnBoardingModelCopyWithImpl<$Res>
    implements _$OnBoardingModelCopyWith<$Res> {
  __$OnBoardingModelCopyWithImpl(this._self, this._then);

  final _OnBoardingModel _self;
  final $Res Function(_OnBoardingModel) _then;

/// Create a copy of OnBoardingModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? image = freezed,}) {
  return _then(_OnBoardingModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

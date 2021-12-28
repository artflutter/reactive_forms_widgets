// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'multi_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MultiImageTearOff {
  const _$MultiImageTearOff();

  _MultiImage<T> call<T>(
      {List<T> images = const [], List<Asset> assets = const []}) {
    return _MultiImage<T>(
      images: images,
      assets: assets,
    );
  }
}

/// @nodoc
const $MultiImage = _$MultiImageTearOff();

/// @nodoc
mixin _$MultiImage<T> {
  List<T> get images => throw _privateConstructorUsedError;
  List<Asset> get assets => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MultiImageCopyWith<T, MultiImage<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MultiImageCopyWith<T, $Res> {
  factory $MultiImageCopyWith(
          MultiImage<T> value, $Res Function(MultiImage<T>) then) =
      _$MultiImageCopyWithImpl<T, $Res>;
  $Res call({List<T> images, List<Asset> assets});
}

/// @nodoc
class _$MultiImageCopyWithImpl<T, $Res>
    implements $MultiImageCopyWith<T, $Res> {
  _$MultiImageCopyWithImpl(this._value, this._then);

  final MultiImage<T> _value;
  // ignore: unused_field
  final $Res Function(MultiImage<T>) _then;

  @override
  $Res call({
    Object? images = freezed,
    Object? assets = freezed,
  }) {
    return _then(_value.copyWith(
      images: images == freezed
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<T>,
      assets: assets == freezed
          ? _value.assets
          : assets // ignore: cast_nullable_to_non_nullable
              as List<Asset>,
    ));
  }
}

/// @nodoc
abstract class _$MultiImageCopyWith<T, $Res>
    implements $MultiImageCopyWith<T, $Res> {
  factory _$MultiImageCopyWith(
          _MultiImage<T> value, $Res Function(_MultiImage<T>) then) =
      __$MultiImageCopyWithImpl<T, $Res>;
  @override
  $Res call({List<T> images, List<Asset> assets});
}

/// @nodoc
class __$MultiImageCopyWithImpl<T, $Res>
    extends _$MultiImageCopyWithImpl<T, $Res>
    implements _$MultiImageCopyWith<T, $Res> {
  __$MultiImageCopyWithImpl(
      _MultiImage<T> _value, $Res Function(_MultiImage<T>) _then)
      : super(_value, (v) => _then(v as _MultiImage<T>));

  @override
  _MultiImage<T> get _value => super._value as _MultiImage<T>;

  @override
  $Res call({
    Object? images = freezed,
    Object? assets = freezed,
  }) {
    return _then(_MultiImage<T>(
      images: images == freezed
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<T>,
      assets: assets == freezed
          ? _value.assets
          : assets // ignore: cast_nullable_to_non_nullable
              as List<Asset>,
    ));
  }
}

/// @nodoc

class _$_MultiImage<T> extends _MultiImage<T> {
  const _$_MultiImage({this.images = const [], this.assets = const []})
      : super._();

  @JsonKey()
  @override
  final List<T> images;
  @JsonKey()
  @override
  final List<Asset> assets;

  @override
  String toString() {
    return 'MultiImage<$T>(images: $images, assets: $assets)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MultiImage<T> &&
            const DeepCollectionEquality().equals(other.images, images) &&
            const DeepCollectionEquality().equals(other.assets, assets));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(images),
      const DeepCollectionEquality().hash(assets));

  @JsonKey(ignore: true)
  @override
  _$MultiImageCopyWith<T, _MultiImage<T>> get copyWith =>
      __$MultiImageCopyWithImpl<T, _MultiImage<T>>(this, _$identity);
}

abstract class _MultiImage<T> extends MultiImage<T> {
  const factory _MultiImage({List<T> images, List<Asset> assets}) =
      _$_MultiImage<T>;
  const _MultiImage._() : super._();

  @override
  List<T> get images;
  @override
  List<Asset> get assets;
  @override
  @JsonKey(ignore: true)
  _$MultiImageCopyWith<T, _MultiImage<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

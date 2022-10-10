// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'image_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ImageFile {
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get localImage => throw _privateConstructorUsedError;
  File? get image => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ImageFileCopyWith<ImageFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageFileCopyWith<$Res> {
  factory $ImageFileCopyWith(ImageFile value, $Res Function(ImageFile) then) =
      _$ImageFileCopyWithImpl<$Res>;
  $Res call({String? imageUrl, String? localImage, File? image});
}

/// @nodoc
class _$ImageFileCopyWithImpl<$Res> implements $ImageFileCopyWith<$Res> {
  _$ImageFileCopyWithImpl(this._value, this._then);

  final ImageFile _value;
  // ignore: unused_field
  final $Res Function(ImageFile) _then;

  @override
  $Res call({
    Object? imageUrl = freezed,
    Object? localImage = freezed,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      localImage: localImage == freezed
          ? _value.localImage
          : localImage // ignore: cast_nullable_to_non_nullable
              as String?,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc
abstract class _$$_ImageFileCopyWith<$Res> implements $ImageFileCopyWith<$Res> {
  factory _$$_ImageFileCopyWith(
          _$_ImageFile value, $Res Function(_$_ImageFile) then) =
      __$$_ImageFileCopyWithImpl<$Res>;
  @override
  $Res call({String? imageUrl, String? localImage, File? image});
}

/// @nodoc
class __$$_ImageFileCopyWithImpl<$Res> extends _$ImageFileCopyWithImpl<$Res>
    implements _$$_ImageFileCopyWith<$Res> {
  __$$_ImageFileCopyWithImpl(
      _$_ImageFile _value, $Res Function(_$_ImageFile) _then)
      : super(_value, (v) => _then(v as _$_ImageFile));

  @override
  _$_ImageFile get _value => super._value as _$_ImageFile;

  @override
  $Res call({
    Object? imageUrl = freezed,
    Object? localImage = freezed,
    Object? image = freezed,
  }) {
    return _then(_$_ImageFile(
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      localImage: localImage == freezed
          ? _value.localImage
          : localImage // ignore: cast_nullable_to_non_nullable
              as String?,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc

class _$_ImageFile extends _ImageFile {
  const _$_ImageFile({this.imageUrl, this.localImage, this.image}) : super._();

  @override
  final String? imageUrl;
  @override
  final String? localImage;
  @override
  final File? image;

  @override
  String toString() {
    return 'ImageFile(imageUrl: $imageUrl, localImage: $localImage, image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ImageFile &&
            const DeepCollectionEquality().equals(other.imageUrl, imageUrl) &&
            const DeepCollectionEquality()
                .equals(other.localImage, localImage) &&
            const DeepCollectionEquality().equals(other.image, image));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(imageUrl),
      const DeepCollectionEquality().hash(localImage),
      const DeepCollectionEquality().hash(image));

  @JsonKey(ignore: true)
  @override
  _$$_ImageFileCopyWith<_$_ImageFile> get copyWith =>
      __$$_ImageFileCopyWithImpl<_$_ImageFile>(this, _$identity);
}

abstract class _ImageFile extends ImageFile {
  const factory _ImageFile(
      {final String? imageUrl,
      final String? localImage,
      final File? image}) = _$_ImageFile;
  const _ImageFile._() : super._();

  @override
  String? get imageUrl => throw _privateConstructorUsedError;
  @override
  String? get localImage => throw _privateConstructorUsedError;
  @override
  File? get image => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ImageFileCopyWith<_$_ImageFile> get copyWith =>
      throw _privateConstructorUsedError;
}

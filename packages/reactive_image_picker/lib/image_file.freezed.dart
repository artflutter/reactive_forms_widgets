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
      _$ImageFileCopyWithImpl<$Res, ImageFile>;
  @useResult
  $Res call({String? imageUrl, String? localImage, File? image});
}

/// @nodoc
class _$ImageFileCopyWithImpl<$Res, $Val extends ImageFile>
    implements $ImageFileCopyWith<$Res> {
  _$ImageFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = freezed,
    Object? localImage = freezed,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      localImage: freezed == localImage
          ? _value.localImage
          : localImage // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ImageFileCopyWith<$Res> implements $ImageFileCopyWith<$Res> {
  factory _$$_ImageFileCopyWith(
          _$_ImageFile value, $Res Function(_$_ImageFile) then) =
      __$$_ImageFileCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? imageUrl, String? localImage, File? image});
}

/// @nodoc
class __$$_ImageFileCopyWithImpl<$Res>
    extends _$ImageFileCopyWithImpl<$Res, _$_ImageFile>
    implements _$$_ImageFileCopyWith<$Res> {
  __$$_ImageFileCopyWithImpl(
      _$_ImageFile _value, $Res Function(_$_ImageFile) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = freezed,
    Object? localImage = freezed,
    Object? image = freezed,
  }) {
    return _then(_$_ImageFile(
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      localImage: freezed == localImage
          ? _value.localImage
          : localImage // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
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
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.localImage, localImage) ||
                other.localImage == localImage) &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, imageUrl, localImage, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
  String? get imageUrl;
  @override
  String? get localImage;
  @override
  File? get image;
  @override
  @JsonKey(ignore: true)
  _$$_ImageFileCopyWith<_$_ImageFile> get copyWith =>
      throw _privateConstructorUsedError;
}

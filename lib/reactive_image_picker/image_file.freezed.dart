// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'image_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$ImageFileTearOff {
  const _$ImageFileTearOff();

// ignore: unused_element
  _ImageFile call({String imageUrl, String localImage, File image}) {
    return _ImageFile(
      imageUrl: imageUrl,
      localImage: localImage,
      image: image,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ImageFile = _$ImageFileTearOff();

/// @nodoc
mixin _$ImageFile {
  String get imageUrl;
  String get localImage;
  File get image;

  @JsonKey(ignore: true)
  $ImageFileCopyWith<ImageFile> get copyWith;
}

/// @nodoc
abstract class $ImageFileCopyWith<$Res> {
  factory $ImageFileCopyWith(ImageFile value, $Res Function(ImageFile) then) =
      _$ImageFileCopyWithImpl<$Res>;
  $Res call({String imageUrl, String localImage, File image});
}

/// @nodoc
class _$ImageFileCopyWithImpl<$Res> implements $ImageFileCopyWith<$Res> {
  _$ImageFileCopyWithImpl(this._value, this._then);

  final ImageFile _value;
  // ignore: unused_field
  final $Res Function(ImageFile) _then;

  @override
  $Res call({
    Object imageUrl = freezed,
    Object localImage = freezed,
    Object image = freezed,
  }) {
    return _then(_value.copyWith(
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
      localImage:
          localImage == freezed ? _value.localImage : localImage as String,
      image: image == freezed ? _value.image : image as File,
    ));
  }
}

/// @nodoc
abstract class _$ImageFileCopyWith<$Res> implements $ImageFileCopyWith<$Res> {
  factory _$ImageFileCopyWith(
          _ImageFile value, $Res Function(_ImageFile) then) =
      __$ImageFileCopyWithImpl<$Res>;
  @override
  $Res call({String imageUrl, String localImage, File image});
}

/// @nodoc
class __$ImageFileCopyWithImpl<$Res> extends _$ImageFileCopyWithImpl<$Res>
    implements _$ImageFileCopyWith<$Res> {
  __$ImageFileCopyWithImpl(_ImageFile _value, $Res Function(_ImageFile) _then)
      : super(_value, (v) => _then(v as _ImageFile));

  @override
  _ImageFile get _value => super._value as _ImageFile;

  @override
  $Res call({
    Object imageUrl = freezed,
    Object localImage = freezed,
    Object image = freezed,
  }) {
    return _then(_ImageFile(
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
      localImage:
          localImage == freezed ? _value.localImage : localImage as String,
      image: image == freezed ? _value.image : image as File,
    ));
  }
}

/// @nodoc
class _$_ImageFile extends _ImageFile {
  const _$_ImageFile({this.imageUrl, this.localImage, this.image}) : super._();

  @override
  final String imageUrl;
  @override
  final String localImage;
  @override
  final File image;

  @override
  String toString() {
    return 'ImageFile(imageUrl: $imageUrl, localImage: $localImage, image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ImageFile &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.localImage, localImage) ||
                const DeepCollectionEquality()
                    .equals(other.localImage, localImage)) &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(localImage) ^
      const DeepCollectionEquality().hash(image);

  @JsonKey(ignore: true)
  @override
  _$ImageFileCopyWith<_ImageFile> get copyWith =>
      __$ImageFileCopyWithImpl<_ImageFile>(this, _$identity);
}

abstract class _ImageFile extends ImageFile {
  const _ImageFile._() : super._();
  const factory _ImageFile({String imageUrl, String localImage, File image}) =
      _$_ImageFile;

  @override
  String get imageUrl;
  @override
  String get localImage;
  @override
  File get image;
  @override
  @JsonKey(ignore: true)
  _$ImageFileCopyWith<_ImageFile> get copyWith;
}

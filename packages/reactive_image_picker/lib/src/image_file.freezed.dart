// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SelectedFile {
  String? get url => throw _privateConstructorUsedError;
  File? get file => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? url, File? file) video,
    required TResult Function(String? url, File? file) image,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? url, File? file)? video,
    TResult? Function(String? url, File? file)? image,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? url, File? file)? video,
    TResult Function(String? url, File? file)? image,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectedFileVideo value) video,
    required TResult Function(SelectedFileImage value) image,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectedFileVideo value)? video,
    TResult? Function(SelectedFileImage value)? image,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectedFileVideo value)? video,
    TResult Function(SelectedFileImage value)? image,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SelectedFileCopyWith<SelectedFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectedFileCopyWith<$Res> {
  factory $SelectedFileCopyWith(
          SelectedFile value, $Res Function(SelectedFile) then) =
      _$SelectedFileCopyWithImpl<$Res, SelectedFile>;
  @useResult
  $Res call({String? url, File? file});
}

/// @nodoc
class _$SelectedFileCopyWithImpl<$Res, $Val extends SelectedFile>
    implements $SelectedFileCopyWith<$Res> {
  _$SelectedFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? file = freezed,
  }) {
    return _then(_value.copyWith(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      file: freezed == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as File?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SelectedFileVideoCopyWith<$Res>
    implements $SelectedFileCopyWith<$Res> {
  factory _$$SelectedFileVideoCopyWith(
          _$SelectedFileVideo value, $Res Function(_$SelectedFileVideo) then) =
      __$$SelectedFileVideoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? url, File? file});
}

/// @nodoc
class __$$SelectedFileVideoCopyWithImpl<$Res>
    extends _$SelectedFileCopyWithImpl<$Res, _$SelectedFileVideo>
    implements _$$SelectedFileVideoCopyWith<$Res> {
  __$$SelectedFileVideoCopyWithImpl(
      _$SelectedFileVideo _value, $Res Function(_$SelectedFileVideo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? file = freezed,
  }) {
    return _then(_$SelectedFileVideo(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      file: freezed == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc

class _$SelectedFileVideo extends SelectedFileVideo {
  _$SelectedFileVideo({this.url, this.file}) : super._();

  @override
  final String? url;
  @override
  final File? file;

  @override
  String toString() {
    return 'SelectedFile.video(url: $url, file: $file)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectedFileVideo &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.file, file) || other.file == file));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url, file);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectedFileVideoCopyWith<_$SelectedFileVideo> get copyWith =>
      __$$SelectedFileVideoCopyWithImpl<_$SelectedFileVideo>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? url, File? file) video,
    required TResult Function(String? url, File? file) image,
  }) {
    return video(url, file);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? url, File? file)? video,
    TResult? Function(String? url, File? file)? image,
  }) {
    return video?.call(url, file);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? url, File? file)? video,
    TResult Function(String? url, File? file)? image,
    required TResult orElse(),
  }) {
    if (video != null) {
      return video(url, file);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectedFileVideo value) video,
    required TResult Function(SelectedFileImage value) image,
  }) {
    return video(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectedFileVideo value)? video,
    TResult? Function(SelectedFileImage value)? image,
  }) {
    return video?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectedFileVideo value)? video,
    TResult Function(SelectedFileImage value)? image,
    required TResult orElse(),
  }) {
    if (video != null) {
      return video(this);
    }
    return orElse();
  }
}

abstract class SelectedFileVideo extends SelectedFile {
  factory SelectedFileVideo({final String? url, final File? file}) =
      _$SelectedFileVideo;
  SelectedFileVideo._() : super._();

  @override
  String? get url;
  @override
  File? get file;
  @override
  @JsonKey(ignore: true)
  _$$SelectedFileVideoCopyWith<_$SelectedFileVideo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectedFileImageCopyWith<$Res>
    implements $SelectedFileCopyWith<$Res> {
  factory _$$SelectedFileImageCopyWith(
          _$SelectedFileImage value, $Res Function(_$SelectedFileImage) then) =
      __$$SelectedFileImageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? url, File? file});
}

/// @nodoc
class __$$SelectedFileImageCopyWithImpl<$Res>
    extends _$SelectedFileCopyWithImpl<$Res, _$SelectedFileImage>
    implements _$$SelectedFileImageCopyWith<$Res> {
  __$$SelectedFileImageCopyWithImpl(
      _$SelectedFileImage _value, $Res Function(_$SelectedFileImage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? file = freezed,
  }) {
    return _then(_$SelectedFileImage(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      file: freezed == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc

class _$SelectedFileImage extends SelectedFileImage {
  _$SelectedFileImage({this.url, this.file}) : super._();

  @override
  final String? url;
  @override
  final File? file;

  @override
  String toString() {
    return 'SelectedFile.image(url: $url, file: $file)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectedFileImage &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.file, file) || other.file == file));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url, file);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectedFileImageCopyWith<_$SelectedFileImage> get copyWith =>
      __$$SelectedFileImageCopyWithImpl<_$SelectedFileImage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? url, File? file) video,
    required TResult Function(String? url, File? file) image,
  }) {
    return image(url, file);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? url, File? file)? video,
    TResult? Function(String? url, File? file)? image,
  }) {
    return image?.call(url, file);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? url, File? file)? video,
    TResult Function(String? url, File? file)? image,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(url, file);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectedFileVideo value) video,
    required TResult Function(SelectedFileImage value) image,
  }) {
    return image(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectedFileVideo value)? video,
    TResult? Function(SelectedFileImage value)? image,
  }) {
    return image?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectedFileVideo value)? video,
    TResult Function(SelectedFileImage value)? image,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(this);
    }
    return orElse();
  }
}

abstract class SelectedFileImage extends SelectedFile {
  factory SelectedFileImage({final String? url, final File? file}) =
      _$SelectedFileImage;
  SelectedFileImage._() : super._();

  @override
  String? get url;
  @override
  File? get file;
  @override
  @JsonKey(ignore: true)
  _$$SelectedFileImageCopyWith<_$SelectedFileImage> get copyWith =>
      throw _privateConstructorUsedError;
}

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
  XFile? get file => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? url, XFile? file) video,
    required TResult Function(String? url, XFile? file) image,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? url, XFile? file)? video,
    TResult? Function(String? url, XFile? file)? image,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? url, XFile? file)? video,
    TResult Function(String? url, XFile? file)? image,
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
  $Res call({String? url, XFile? file});
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
              as XFile?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SelectedFileVideoImplCopyWith<$Res>
    implements $SelectedFileCopyWith<$Res> {
  factory _$$SelectedFileVideoImplCopyWith(_$SelectedFileVideoImpl value,
          $Res Function(_$SelectedFileVideoImpl) then) =
      __$$SelectedFileVideoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? url, XFile? file});
}

/// @nodoc
class __$$SelectedFileVideoImplCopyWithImpl<$Res>
    extends _$SelectedFileCopyWithImpl<$Res, _$SelectedFileVideoImpl>
    implements _$$SelectedFileVideoImplCopyWith<$Res> {
  __$$SelectedFileVideoImplCopyWithImpl(_$SelectedFileVideoImpl _value,
      $Res Function(_$SelectedFileVideoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? file = freezed,
  }) {
    return _then(_$SelectedFileVideoImpl(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      file: freezed == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as XFile?,
    ));
  }
}

/// @nodoc

class _$SelectedFileVideoImpl extends SelectedFileVideo {
  _$SelectedFileVideoImpl({this.url, this.file}) : super._();

  @override
  final String? url;
  @override
  final XFile? file;

  @override
  String toString() {
    return 'SelectedFile.video(url: $url, file: $file)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectedFileVideoImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.file, file) || other.file == file));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url, file);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectedFileVideoImplCopyWith<_$SelectedFileVideoImpl> get copyWith =>
      __$$SelectedFileVideoImplCopyWithImpl<_$SelectedFileVideoImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? url, XFile? file) video,
    required TResult Function(String? url, XFile? file) image,
  }) {
    return video(url, file);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? url, XFile? file)? video,
    TResult? Function(String? url, XFile? file)? image,
  }) {
    return video?.call(url, file);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? url, XFile? file)? video,
    TResult Function(String? url, XFile? file)? image,
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
  factory SelectedFileVideo({final String? url, final XFile? file}) =
      _$SelectedFileVideoImpl;
  SelectedFileVideo._() : super._();

  @override
  String? get url;
  @override
  XFile? get file;
  @override
  @JsonKey(ignore: true)
  _$$SelectedFileVideoImplCopyWith<_$SelectedFileVideoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectedFileImageImplCopyWith<$Res>
    implements $SelectedFileCopyWith<$Res> {
  factory _$$SelectedFileImageImplCopyWith(_$SelectedFileImageImpl value,
          $Res Function(_$SelectedFileImageImpl) then) =
      __$$SelectedFileImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? url, XFile? file});
}

/// @nodoc
class __$$SelectedFileImageImplCopyWithImpl<$Res>
    extends _$SelectedFileCopyWithImpl<$Res, _$SelectedFileImageImpl>
    implements _$$SelectedFileImageImplCopyWith<$Res> {
  __$$SelectedFileImageImplCopyWithImpl(_$SelectedFileImageImpl _value,
      $Res Function(_$SelectedFileImageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? file = freezed,
  }) {
    return _then(_$SelectedFileImageImpl(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      file: freezed == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as XFile?,
    ));
  }
}

/// @nodoc

class _$SelectedFileImageImpl extends SelectedFileImage {
  _$SelectedFileImageImpl({this.url, this.file}) : super._();

  @override
  final String? url;
  @override
  final XFile? file;

  @override
  String toString() {
    return 'SelectedFile.image(url: $url, file: $file)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectedFileImageImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.file, file) || other.file == file));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url, file);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectedFileImageImplCopyWith<_$SelectedFileImageImpl> get copyWith =>
      __$$SelectedFileImageImplCopyWithImpl<_$SelectedFileImageImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? url, XFile? file) video,
    required TResult Function(String? url, XFile? file) image,
  }) {
    return image(url, file);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? url, XFile? file)? video,
    TResult? Function(String? url, XFile? file)? image,
  }) {
    return image?.call(url, file);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? url, XFile? file)? video,
    TResult Function(String? url, XFile? file)? image,
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
  factory SelectedFileImage({final String? url, final XFile? file}) =
      _$SelectedFileImageImpl;
  SelectedFileImage._() : super._();

  @override
  String? get url;
  @override
  XFile? get file;
  @override
  @JsonKey(ignore: true)
  _$$SelectedFileImageImplCopyWith<_$SelectedFileImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

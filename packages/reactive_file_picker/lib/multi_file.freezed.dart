// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'multi_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MultiFileTearOff {
  const _$MultiFileTearOff();

  _MultiFile<T> call<T>(
      {List<T> files = const [], List<PlatformFile> platformFiles = const []}) {
    return _MultiFile<T>(
      files: files,
      platformFiles: platformFiles,
    );
  }
}

/// @nodoc
const $MultiFile = _$MultiFileTearOff();

/// @nodoc
mixin _$MultiFile<T> {
  List<T> get files => throw _privateConstructorUsedError;
  List<PlatformFile> get platformFiles => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MultiFileCopyWith<T, MultiFile<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MultiFileCopyWith<T, $Res> {
  factory $MultiFileCopyWith(
          MultiFile<T> value, $Res Function(MultiFile<T>) then) =
      _$MultiFileCopyWithImpl<T, $Res>;
  $Res call({List<T> files, List<PlatformFile> platformFiles});
}

/// @nodoc
class _$MultiFileCopyWithImpl<T, $Res> implements $MultiFileCopyWith<T, $Res> {
  _$MultiFileCopyWithImpl(this._value, this._then);

  final MultiFile<T> _value;
  // ignore: unused_field
  final $Res Function(MultiFile<T>) _then;

  @override
  $Res call({
    Object? files = freezed,
    Object? platformFiles = freezed,
  }) {
    return _then(_value.copyWith(
      files: files == freezed
          ? _value.files
          : files // ignore: cast_nullable_to_non_nullable
              as List<T>,
      platformFiles: platformFiles == freezed
          ? _value.platformFiles
          : platformFiles // ignore: cast_nullable_to_non_nullable
              as List<PlatformFile>,
    ));
  }
}

/// @nodoc
abstract class _$MultiFileCopyWith<T, $Res>
    implements $MultiFileCopyWith<T, $Res> {
  factory _$MultiFileCopyWith(
          _MultiFile<T> value, $Res Function(_MultiFile<T>) then) =
      __$MultiFileCopyWithImpl<T, $Res>;
  @override
  $Res call({List<T> files, List<PlatformFile> platformFiles});
}

/// @nodoc
class __$MultiFileCopyWithImpl<T, $Res> extends _$MultiFileCopyWithImpl<T, $Res>
    implements _$MultiFileCopyWith<T, $Res> {
  __$MultiFileCopyWithImpl(
      _MultiFile<T> _value, $Res Function(_MultiFile<T>) _then)
      : super(_value, (v) => _then(v as _MultiFile<T>));

  @override
  _MultiFile<T> get _value => super._value as _MultiFile<T>;

  @override
  $Res call({
    Object? files = freezed,
    Object? platformFiles = freezed,
  }) {
    return _then(_MultiFile<T>(
      files: files == freezed
          ? _value.files
          : files // ignore: cast_nullable_to_non_nullable
              as List<T>,
      platformFiles: platformFiles == freezed
          ? _value.platformFiles
          : platformFiles // ignore: cast_nullable_to_non_nullable
              as List<PlatformFile>,
    ));
  }
}

/// @nodoc

class _$_MultiFile<T> extends _MultiFile<T> {
  const _$_MultiFile({this.files = const [], this.platformFiles = const []})
      : super._();

  @JsonKey()
  @override
  final List<T> files;
  @JsonKey()
  @override
  final List<PlatformFile> platformFiles;

  @override
  String toString() {
    return 'MultiFile<$T>(files: $files, platformFiles: $platformFiles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MultiFile<T> &&
            const DeepCollectionEquality().equals(other.files, files) &&
            const DeepCollectionEquality()
                .equals(other.platformFiles, platformFiles));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(files),
      const DeepCollectionEquality().hash(platformFiles));

  @JsonKey(ignore: true)
  @override
  _$MultiFileCopyWith<T, _MultiFile<T>> get copyWith =>
      __$MultiFileCopyWithImpl<T, _MultiFile<T>>(this, _$identity);
}

abstract class _MultiFile<T> extends MultiFile<T> {
  const factory _MultiFile({List<T> files, List<PlatformFile> platformFiles}) =
      _$_MultiFile<T>;
  const _MultiFile._() : super._();

  @override
  List<T> get files;
  @override
  List<PlatformFile> get platformFiles;
  @override
  @JsonKey(ignore: true)
  _$MultiFileCopyWith<T, _MultiFile<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

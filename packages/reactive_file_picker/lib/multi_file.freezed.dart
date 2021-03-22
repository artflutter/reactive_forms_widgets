// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'multi_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$MultiFileTearOff {
  const _$MultiFileTearOff();

// ignore: unused_element
  _MultiFile<T> call<T>(
      {List<T> files = const [], List<PlatformFile> platformFiles = const []}) {
    return _MultiFile<T>(
      files: files,
      platformFiles: platformFiles,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $MultiFile = _$MultiFileTearOff();

/// @nodoc
mixin _$MultiFile<T> {
  List<T> get files;
  List<PlatformFile> get platformFiles;

  @JsonKey(ignore: true)
  $MultiFileCopyWith<T, MultiFile<T>> get copyWith;
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
    Object files = freezed,
    Object platformFiles = freezed,
  }) {
    return _then(_value.copyWith(
      files: files == freezed ? _value.files : files as List<T>,
      platformFiles: platformFiles == freezed
          ? _value.platformFiles
          : platformFiles as List<PlatformFile>,
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
    Object files = freezed,
    Object platformFiles = freezed,
  }) {
    return _then(_MultiFile<T>(
      files: files == freezed ? _value.files : files as List<T>,
      platformFiles: platformFiles == freezed
          ? _value.platformFiles
          : platformFiles as List<PlatformFile>,
    ));
  }
}

/// @nodoc
class _$_MultiFile<T> extends _MultiFile<T> {
  const _$_MultiFile({this.files = const [], this.platformFiles = const []})
      : assert(files != null),
        assert(platformFiles != null),
        super._();

  @JsonKey(defaultValue: const [])
  @override
  final List<T> files;
  @JsonKey(defaultValue: const [])
  @override
  final List<PlatformFile> platformFiles;

  @override
  String toString() {
    return 'MultiFile<$T>(files: $files, platformFiles: $platformFiles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MultiFile<T> &&
            (identical(other.files, files) ||
                const DeepCollectionEquality().equals(other.files, files)) &&
            (identical(other.platformFiles, platformFiles) ||
                const DeepCollectionEquality()
                    .equals(other.platformFiles, platformFiles)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(files) ^
      const DeepCollectionEquality().hash(platformFiles);

  @JsonKey(ignore: true)
  @override
  _$MultiFileCopyWith<T, _MultiFile<T>> get copyWith =>
      __$MultiFileCopyWithImpl<T, _MultiFile<T>>(this, _$identity);
}

abstract class _MultiFile<T> extends MultiFile<T> {
  const _MultiFile._() : super._();
  const factory _MultiFile({List<T> files, List<PlatformFile> platformFiles}) =
      _$_MultiFile<T>;

  @override
  List<T> get files;
  @override
  List<PlatformFile> get platformFiles;
  @override
  @JsonKey(ignore: true)
  _$MultiFileCopyWith<T, _MultiFile<T>> get copyWith;
}

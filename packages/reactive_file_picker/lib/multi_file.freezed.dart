// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'multi_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
      _$MultiFileCopyWithImpl<T, $Res, MultiFile<T>>;
  @useResult
  $Res call({List<T> files, List<PlatformFile> platformFiles});
}

/// @nodoc
class _$MultiFileCopyWithImpl<T, $Res, $Val extends MultiFile<T>>
    implements $MultiFileCopyWith<T, $Res> {
  _$MultiFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? files = null,
    Object? platformFiles = null,
  }) {
    return _then(_value.copyWith(
      files: null == files
          ? _value.files
          : files // ignore: cast_nullable_to_non_nullable
              as List<T>,
      platformFiles: null == platformFiles
          ? _value.platformFiles
          : platformFiles // ignore: cast_nullable_to_non_nullable
              as List<PlatformFile>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MultiFileCopyWith<T, $Res>
    implements $MultiFileCopyWith<T, $Res> {
  factory _$$_MultiFileCopyWith(
          _$_MultiFile<T> value, $Res Function(_$_MultiFile<T>) then) =
      __$$_MultiFileCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({List<T> files, List<PlatformFile> platformFiles});
}

/// @nodoc
class __$$_MultiFileCopyWithImpl<T, $Res>
    extends _$MultiFileCopyWithImpl<T, $Res, _$_MultiFile<T>>
    implements _$$_MultiFileCopyWith<T, $Res> {
  __$$_MultiFileCopyWithImpl(
      _$_MultiFile<T> _value, $Res Function(_$_MultiFile<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? files = null,
    Object? platformFiles = null,
  }) {
    return _then(_$_MultiFile<T>(
      files: null == files
          ? _value._files
          : files // ignore: cast_nullable_to_non_nullable
              as List<T>,
      platformFiles: null == platformFiles
          ? _value._platformFiles
          : platformFiles // ignore: cast_nullable_to_non_nullable
              as List<PlatformFile>,
    ));
  }
}

/// @nodoc

class _$_MultiFile<T> extends _MultiFile<T> {
  const _$_MultiFile(
      {final List<T> files = const [],
      final List<PlatformFile> platformFiles = const []})
      : _files = files,
        _platformFiles = platformFiles,
        super._();

  final List<T> _files;
  @override
  @JsonKey()
  List<T> get files {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  final List<PlatformFile> _platformFiles;
  @override
  @JsonKey()
  List<PlatformFile> get platformFiles {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_platformFiles);
  }

  @override
  String toString() {
    return 'MultiFile<$T>(files: $files, platformFiles: $platformFiles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MultiFile<T> &&
            const DeepCollectionEquality().equals(other._files, _files) &&
            const DeepCollectionEquality()
                .equals(other._platformFiles, _platformFiles));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_files),
      const DeepCollectionEquality().hash(_platformFiles));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MultiFileCopyWith<T, _$_MultiFile<T>> get copyWith =>
      __$$_MultiFileCopyWithImpl<T, _$_MultiFile<T>>(this, _$identity);
}

abstract class _MultiFile<T> extends MultiFile<T> {
  const factory _MultiFile(
      {final List<T> files,
      final List<PlatformFile> platformFiles}) = _$_MultiFile<T>;
  const _MultiFile._() : super._();

  @override
  List<T> get files;
  @override
  List<PlatformFile> get platformFiles;
  @override
  @JsonKey(ignore: true)
  _$$_MultiFileCopyWith<T, _$_MultiFile<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

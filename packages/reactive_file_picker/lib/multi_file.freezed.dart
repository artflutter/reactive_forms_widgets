// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'multi_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MultiFile<T> {
  List<T> get files;
  List<PlatformFile> get platformFiles;

  /// Create a copy of MultiFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MultiFileCopyWith<T, MultiFile<T>> get copyWith =>
      _$MultiFileCopyWithImpl<T, MultiFile<T>>(
          this as MultiFile<T>, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MultiFile<T> &&
            const DeepCollectionEquality().equals(other.files, files) &&
            const DeepCollectionEquality()
                .equals(other.platformFiles, platformFiles));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(files),
      const DeepCollectionEquality().hash(platformFiles));

  @override
  String toString() {
    return 'MultiFile<$T>(files: $files, platformFiles: $platformFiles)';
  }
}

/// @nodoc
abstract mixin class $MultiFileCopyWith<T, $Res> {
  factory $MultiFileCopyWith(
          MultiFile<T> value, $Res Function(MultiFile<T>) _then) =
      _$MultiFileCopyWithImpl;
  @useResult
  $Res call({List<T> files, List<PlatformFile> platformFiles});
}

/// @nodoc
class _$MultiFileCopyWithImpl<T, $Res> implements $MultiFileCopyWith<T, $Res> {
  _$MultiFileCopyWithImpl(this._self, this._then);

  final MultiFile<T> _self;
  final $Res Function(MultiFile<T>) _then;

  /// Create a copy of MultiFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? files = null,
    Object? platformFiles = null,
  }) {
    return _then(_self.copyWith(
      files: null == files
          ? _self.files
          : files // ignore: cast_nullable_to_non_nullable
              as List<T>,
      platformFiles: null == platformFiles
          ? _self.platformFiles
          : platformFiles // ignore: cast_nullable_to_non_nullable
              as List<PlatformFile>,
    ));
  }
}

/// @nodoc

class _MultiFile<T> implements MultiFile<T> {
  const _MultiFile(
      {final List<T> files = const [],
      final List<PlatformFile> platformFiles = const []})
      : _files = files,
        _platformFiles = platformFiles;

  final List<T> _files;
  @override
  @JsonKey()
  List<T> get files {
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  final List<PlatformFile> _platformFiles;
  @override
  @JsonKey()
  List<PlatformFile> get platformFiles {
    if (_platformFiles is EqualUnmodifiableListView) return _platformFiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_platformFiles);
  }

  /// Create a copy of MultiFile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MultiFileCopyWith<T, _MultiFile<T>> get copyWith =>
      __$MultiFileCopyWithImpl<T, _MultiFile<T>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MultiFile<T> &&
            const DeepCollectionEquality().equals(other._files, _files) &&
            const DeepCollectionEquality()
                .equals(other._platformFiles, _platformFiles));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_files),
      const DeepCollectionEquality().hash(_platformFiles));

  @override
  String toString() {
    return 'MultiFile<$T>(files: $files, platformFiles: $platformFiles)';
  }
}

/// @nodoc
abstract mixin class _$MultiFileCopyWith<T, $Res>
    implements $MultiFileCopyWith<T, $Res> {
  factory _$MultiFileCopyWith(
          _MultiFile<T> value, $Res Function(_MultiFile<T>) _then) =
      __$MultiFileCopyWithImpl;
  @override
  @useResult
  $Res call({List<T> files, List<PlatformFile> platformFiles});
}

/// @nodoc
class __$MultiFileCopyWithImpl<T, $Res>
    implements _$MultiFileCopyWith<T, $Res> {
  __$MultiFileCopyWithImpl(this._self, this._then);

  final _MultiFile<T> _self;
  final $Res Function(_MultiFile<T>) _then;

  /// Create a copy of MultiFile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? files = null,
    Object? platformFiles = null,
  }) {
    return _then(_MultiFile<T>(
      files: null == files
          ? _self._files
          : files // ignore: cast_nullable_to_non_nullable
              as List<T>,
      platformFiles: null == platformFiles
          ? _self._platformFiles
          : platformFiles // ignore: cast_nullable_to_non_nullable
              as List<PlatformFile>,
    ));
  }
}

// dart format on

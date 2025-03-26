// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SelectedFile {
  String? get url;
  XFile? get file;

  /// Create a copy of SelectedFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SelectedFileCopyWith<SelectedFile> get copyWith =>
      _$SelectedFileCopyWithImpl<SelectedFile>(
          this as SelectedFile, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SelectedFile &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.file, file) || other.file == file));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url, file);

  @override
  String toString() {
    return 'SelectedFile(url: $url, file: $file)';
  }
}

/// @nodoc
abstract mixin class $SelectedFileCopyWith<$Res> {
  factory $SelectedFileCopyWith(
          SelectedFile value, $Res Function(SelectedFile) _then) =
      _$SelectedFileCopyWithImpl;
  @useResult
  $Res call({String? url, XFile? file});
}

/// @nodoc
class _$SelectedFileCopyWithImpl<$Res> implements $SelectedFileCopyWith<$Res> {
  _$SelectedFileCopyWithImpl(this._self, this._then);

  final SelectedFile _self;
  final $Res Function(SelectedFile) _then;

  /// Create a copy of SelectedFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? file = freezed,
  }) {
    return _then(_self.copyWith(
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      file: freezed == file
          ? _self.file
          : file // ignore: cast_nullable_to_non_nullable
              as XFile?,
    ));
  }
}

/// @nodoc

class SelectedFileVideo extends SelectedFile {
  SelectedFileVideo({this.url, this.file}) : super._();

  @override
  final String? url;
  @override
  final XFile? file;

  /// Create a copy of SelectedFile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SelectedFileVideoCopyWith<SelectedFileVideo> get copyWith =>
      _$SelectedFileVideoCopyWithImpl<SelectedFileVideo>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SelectedFileVideo &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.file, file) || other.file == file));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url, file);

  @override
  String toString() {
    return 'SelectedFile.video(url: $url, file: $file)';
  }
}

/// @nodoc
abstract mixin class $SelectedFileVideoCopyWith<$Res>
    implements $SelectedFileCopyWith<$Res> {
  factory $SelectedFileVideoCopyWith(
          SelectedFileVideo value, $Res Function(SelectedFileVideo) _then) =
      _$SelectedFileVideoCopyWithImpl;
  @override
  @useResult
  $Res call({String? url, XFile? file});
}

/// @nodoc
class _$SelectedFileVideoCopyWithImpl<$Res>
    implements $SelectedFileVideoCopyWith<$Res> {
  _$SelectedFileVideoCopyWithImpl(this._self, this._then);

  final SelectedFileVideo _self;
  final $Res Function(SelectedFileVideo) _then;

  /// Create a copy of SelectedFile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? url = freezed,
    Object? file = freezed,
  }) {
    return _then(SelectedFileVideo(
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      file: freezed == file
          ? _self.file
          : file // ignore: cast_nullable_to_non_nullable
              as XFile?,
    ));
  }
}

/// @nodoc

class SelectedFileImage extends SelectedFile {
  SelectedFileImage({this.url, this.file}) : super._();

  @override
  final String? url;
  @override
  final XFile? file;

  /// Create a copy of SelectedFile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SelectedFileImageCopyWith<SelectedFileImage> get copyWith =>
      _$SelectedFileImageCopyWithImpl<SelectedFileImage>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SelectedFileImage &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.file, file) || other.file == file));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url, file);

  @override
  String toString() {
    return 'SelectedFile.image(url: $url, file: $file)';
  }
}

/// @nodoc
abstract mixin class $SelectedFileImageCopyWith<$Res>
    implements $SelectedFileCopyWith<$Res> {
  factory $SelectedFileImageCopyWith(
          SelectedFileImage value, $Res Function(SelectedFileImage) _then) =
      _$SelectedFileImageCopyWithImpl;
  @override
  @useResult
  $Res call({String? url, XFile? file});
}

/// @nodoc
class _$SelectedFileImageCopyWithImpl<$Res>
    implements $SelectedFileImageCopyWith<$Res> {
  _$SelectedFileImageCopyWithImpl(this._self, this._then);

  final SelectedFileImage _self;
  final $Res Function(SelectedFileImage) _then;

  /// Create a copy of SelectedFile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? url = freezed,
    Object? file = freezed,
  }) {
    return _then(SelectedFileImage(
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      file: freezed == file
          ? _self.file
          : file // ignore: cast_nullable_to_non_nullable
              as XFile?,
    ));
  }
}

// dart format on

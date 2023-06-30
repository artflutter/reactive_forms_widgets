import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

export 'package:wechat_assets_picker/wechat_assets_picker.dart';

typedef PickImageCallback = Future<void> Function();
typedef ImagePickerChangeCallback<T> = void Function(List<AssetEntity> images);

typedef ImagePickerBuilder<T> = Widget Function(
  PickImageCallback pickImage,
  List<AssetEntity> images,
  ImagePickerChangeCallback<T> onChange,
);

/// A [ReactiveWechatAssetsPicker] that contains a [WechatAssetsPicker].
///
/// This is a convenience widget that wraps a [WechatAssetsPicker] widget in a
/// [ReactiveWechatAssetsPicker].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveWechatAssetsPicker<T>
    extends ReactiveFormField<T, List<AssetEntity>> {
  /// Creates a [ReactiveWechatAssetsPicker] that contains a [WechatAssetsPicker].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// Can optionally provide a [validationMessages] argument to customize a
  /// message for different kinds of validation errors.
  ///
  /// Can optionally provide a [valueAccessor] to set a custom value accessors.
  /// See [ControlValueAccessor].
  ///
  /// Can optionally provide a [showErrors] function to customize when to show
  /// validation messages. Reactive Widgets make validation messages visible
  /// when the control is INVALID and TOUCHED, this behavior can be customized
  /// in the [showErrors] function.
  ///
  /// ### Example:
  /// Binds a text field.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveWechatAssetsPicker(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveWechatAssetsPicker(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveWechatAssetsPicker(
  ///   formControlName: 'email',
  ///   validationMessages: {
  ///     ValidationMessage.required: 'The email must not be empty',
  ///     ValidationMessage.email: 'The email must be a valid email',
  ///   }
  /// ),
  /// ```
  ///
  /// Customize when to show up validation messages.
  /// ```dart
  /// ReactiveWechatAssetsPicker(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [WechatAssetsPicker] class
  /// and [WechatAssetsPicker], the constructor.
  ReactiveWechatAssetsPicker({
    Key? key,
    Key? widgetKey,
    String? formControlName,
    FormControl<T>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ControlValueAccessor<T, List<AssetEntity>>? valueAccessor,
    ShowErrorsFunction<T>? showErrors,

    //////////////////////////////////////////////////////////////////////////
    required ImagePickerBuilder<T> imagePickerBuilder,
    InputDecoration? decoration,
    AssetPickerConfig pickerConfig = const AssetPickerConfig(),
    bool useRootNavigator = true,
    AssetPickerPageRouteBuilder<List<AssetEntity>>? pageRouteBuilder,
    double disabledOpacity = 0.5,
    // put component specific params here
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            final value = field.value;

            final InputDecoration effectiveDecoration = (decoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            String? pickerError;

            pickImage() async {
              try {
                final resultList = await AssetPicker.pickAssets(
                  field.context,
                  key: widgetKey,
                  pickerConfig: pickerConfig,
                  useRootNavigator: useRootNavigator,
                  pageRouteBuilder: pageRouteBuilder,
                );

                field.control.markAsTouched();
                field.didChange(resultList);
              } on Exception catch (e) {
                pickerError = e.toString();
              }
            }

            return InputDecorator(
              decoration: effectiveDecoration.copyWith(
                errorText: field.errorText ?? pickerError,
                enabled: field.control.enabled,
              ),
              child: IgnorePointer(
                ignoring: !field.control.enabled,
                child: Opacity(
                  opacity: field.control.enabled ? 1 : disabledOpacity,
                  child: imagePickerBuilder.call(
                    pickImage,
                    value ?? [],
                    (images) {
                      field.control.markAsTouched();
                      field.didChange(images);
                    },
                  ),
                ),
              ),
            );
          },
        );
}

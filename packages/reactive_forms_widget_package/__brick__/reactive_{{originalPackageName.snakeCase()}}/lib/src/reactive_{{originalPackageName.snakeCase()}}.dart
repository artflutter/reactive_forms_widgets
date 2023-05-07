import 'package:flutter/material.dart';
import 'package:{{originalPackageName.snakeCase()}}/{{originalPackageName.snakeCase()}}.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A [Reactive{{originalPackageName.pascalCase()}}] that contains a [{{originalPackageName.pascalCase()}}].
///
/// This is a convenience widget that wraps a [{{originalPackageName.pascalCase()}}] widget in a
/// [Reactive{{originalPackageName.pascalCase()}}].
///
/// A [ReactiveForm] ancestor is required.
///
class Reactive{{originalPackageName.pascalCase()}}<T, V> extends ReactiveFormField<T, V> {
  /// Creates a [Reactive{{originalPackageName.pascalCase()}}] that contains a [{{originalPackageName.pascalCase()}}].
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
  /// Reactive{{originalPackageName.pascalCase()}}(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// Reactive{{originalPackageName.pascalCase()}}(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// Reactive{{originalPackageName.pascalCase()}}(
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
  /// Reactive{{originalPackageName.pascalCase()}}(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [{{originalPackageName.pascalCase()}}] class
  /// and [{{originalPackageName.pascalCase()}}], the constructor.
  Reactive{{originalPackageName.pascalCase()}}(
      {
        super.key,
        Key? widgetKey,
        super.formControlName,
        super.formControl,
        super.validationMessages,
        super.valueAccessor,
        super.showErrors,
        super.focusNode,

        //////////////////////////////////////////////////////////////////////////
        // put component specific params here
    })
      : super( 
    builder: (field) {
      return {{originalPackageName.pascalCase()}}(
        key: widgetKey,
      );
    },
  );
}

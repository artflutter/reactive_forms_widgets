library reactive_md_editable_textinput;

// Copyright 2020 Vasyl Dytsiak. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import 'package:reactive_forms/reactive_forms.dart';

export 'package:markdown_editable_textinput/format_markdown.dart';
export 'package:markdown_editable_textinput/markdown_text_input.dart';

/// A [ReactiveMarkdownEditableTextInput] that contains a [MarkdownTextInput].
///
/// This is a convenience widget that wraps a [MarkdownTextInput] widget in a
/// [ReactiveMarkdownEditableTextInput].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveMarkdownEditableTextInput<T>
    extends ReactiveFormField<T, String> {
  /// Creates a [ReactiveMarkdownEditableTextInput] that contains a [MarkdownTextInput].
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
  /// ReactiveMarkdownEditableTextInput(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveMarkdownEditableTextInput(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveMarkdownEditableTextInput(
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
  /// ReactiveMarkdownEditableTextInput(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [MarkdownTextInput] class
  /// and [MarkdownTextInput], the constructor.
  ReactiveMarkdownEditableTextInput({
    Key? key,
    String? formControlName,
    FormControl<T>? formControl,
    ValidationMessagesFunction<T>? validationMessages,
    ControlValueAccessor<T, String>? valueAccessor,
    ShowErrorsFunction? showErrors,

    ////////////////////////////////////////////////////////////////////////////
    InputDecoration decoration = const InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      isDense: true,
      isCollapsed: true,
    ),
    String label = '',
    TextDirection textDirection = TextDirection.ltr,
    int maxLines = 10,
    List<MarkdownType> actions = const [
      MarkdownType.bold,
      MarkdownType.italic,
      MarkdownType.title,
      MarkdownType.link,
      MarkdownType.list
    ],
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            final InputDecoration effectiveDecoration = decoration
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return InputDecorator(
              decoration: effectiveDecoration.copyWith(
                errorText: field.errorText,
                enabled: field.control.enabled,
              ),
              child: MarkdownTextInput(
                field.didChange,
                field.value ?? '',
                label: label,
                textDirection: textDirection,
                maxLines: maxLines,
                actions: actions,
              ),
            );
          },
        );
}

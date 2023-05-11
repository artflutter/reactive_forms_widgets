import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_language_picker/reactive_language_picker.dart';

/// A [ReactiveLanguagePickerDropdown] that contains a [LanguagePicker].
///
/// This is a convenience widget that wraps a [LanguagePicker] widget in a
/// [ReactiveLanguagePickerDropdown].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveLanguagePickerDialog<T> extends ReactiveFormField<T, Language> {
  /// Creates a [ReactiveLanguagePickerDialog] that contains a [LanguagePickerDialog].
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
  /// final form = fb.group({'language': Validators.required});
  ///
  /// ReactiveLanguagePickerDialog(
  ///   formControlName: 'language',
  /// ),
  ///
  /// ```
  ///
  /// Binds directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'language': Validators.required});
  ///
  /// ReactiveLanguagePickerDialog(
  ///   formControl: form.control('language'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveLanguagePickerDialog(
  ///   formControlName: 'language',
  ///   validationMessages: {
  ///     ValidationMessage.required: 'The language is required',
  ///   }
  /// ),
  /// ```
  ///
  /// Customize when to show up validation messages.
  /// ```dart
  /// ReactiveLanguagePickerDialog(
  ///   formControlName: 'language',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [LanguagePicker] class
  /// and [LanguagePicker], the constructor.
  ReactiveLanguagePickerDialog({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,
    super.focusNode,
    GlobalKey<SingleChoiceDialogState>? dialogKey,
    //Builder
    required Widget Function(
      BuildContext context,
      Language? language,
      Future<Language?> Function() showDialog,
    )
        builder,

    /// Callback that is called with selected Language
    final ValueChanged<Language>? onValuePicked,

    /// The (optional) title of the dialog is displayed in a large font at the top
    /// of the dialog.
    ///
    /// Typically a [Text] widget.
    final Widget? title,

    /// Padding around the title.
    ///
    /// If there is no title, no padding will be provided. Otherwise, this padding
    /// is used.
    ///
    /// This property defaults to providing 12 pixels on the top,
    /// 16 pixels on bottom of the title. If the [content] is not null, then no bottom padding is
    /// provided (but see [contentPadding]). If it _is_ null, then an extra 20
    /// pixels of bottom padding is added to separate the [title] from the
    /// [actions].
    final EdgeInsetsGeometry? titlePadding,

    /// Padding around the content.
    final EdgeInsetsGeometry contentPadding =
        const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 16.0),

    /// The semantic label of the dialog used by accessibility frameworks to
    /// announce screen transitions when the dialog is opened and closed.
    ///
    /// If this label is not provided, a semantic label will be infered from the
    /// [title] if it is not null.  If there is no title, the label will be taken
    /// from [MaterialLocalizations.alertDialogLabel].
    ///
    /// See also:
    ///
    ///  * [SemanticsConfiguration.isRouteName], for a description of how this
    ///    value is used.
    final String? semanticLabel,

    ///Callback that is called with selected item of type Language which returns a
    ///Widget to build list view item inside dialog
    final ItemBuilder? itemBuilder,

    /// The (optional) horizontal separator used between title, content and
    /// actions.
    ///
    /// If this divider is not provided a [Divider] is used with [height]
    /// property is set to 0.0
    final Widget divider = const Divider(height: 0.0),

    /// The [divider] is not displayed if set to false. Default is set to true.
    final bool isDividerEnabled = false,

    /// Determines if search [TextField] is shown or not
    /// Defaults to false
    final bool isSearchable = false,

    /// The optional [decoration] of search [TextField]
    final InputDecoration? searchInputDecoration,

    ///The optional [cursorColor] of search [TextField]
    final Color? searchCursorColor,

    ///The search empty view is displayed if nothing returns from search result
    final Widget? searchEmptyView,

    /// List of languages available in this picker.
    final List<Language>? languages,

    //showDialog config
    final bool barrierDismissible = true,
    final Color? barrierColor = Colors.black54,
    final String? barrierLabel,
    final bool useSafeArea = true,
    final bool useRootNavigator = true,
    final RouteSettings? routeSettings,
    final Offset? anchorPoint,
  }) : super(
          builder: (field) {
            return builder(
              field.context,
              field.value,
              () async {
                Language? res;
                await showDialog<void>(
                  context: field.context,
                  anchorPoint: anchorPoint,
                  barrierColor: barrierColor,
                  barrierDismissible: barrierDismissible,
                  barrierLabel: barrierLabel,
                  routeSettings: routeSettings,
                  useRootNavigator: useRootNavigator,
                  useSafeArea: useSafeArea,
                  builder: (context) => LanguagePickerDialog(
                    key: dialogKey,
                    titlePadding: titlePadding,
                    searchCursorColor: searchCursorColor,
                    searchInputDecoration: searchInputDecoration,
                    isSearchable: isSearchable,
                    title: title,
                    onValuePicked: (Language language) {
                      res = language;
                    },
                    itemBuilder: itemBuilder,
                    contentPadding: contentPadding,
                    divider: divider,
                    isDividerEnabled: isDividerEnabled,
                    languages: languages,
                    searchEmptyView: searchEmptyView,
                    semanticLabel: semanticLabel,
                  ),
                );
                if (res != null) {
                  onValuePicked?.call(res!);
                  field.didChange(res);
                }
                return res;
              },
            );
          },
        );
}

library;

import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '/src/decoration.dart';

/// A [ReactiveSmartSelectSingle] that contains a [AdvancedSwitch].
///
/// This is a convenience widget that wraps a [AdvancedSwitch] widget in a
/// [ReactiveSmartSelectSingle].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveSmartSelectSingle<T, V> extends ReactiveFormField<T, V?> {
  /// Creates a [ReactiveSmartSelectSingle] that contains a [AdvancedSwitch].
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
  /// ReactiveSmartSelectSingle(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveSmartSelectSingle(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveSmartSelectSingle(
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
  /// ReactiveSmartSelectSingle(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [AwesomeSelect] class
  /// and [AwesomeSelect], the constructor.
  ReactiveSmartSelectSingle({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    ControlValueAccessor<T, V>? super.valueAccessor,
    super.showErrors,
    ////////////////////////////////////////////////////////////////////////////
    InputDecoration decoration = decorationInvisible,
    String? title,
    String placeholder = 'Select one',
    S2Choice<V?>? selectedChoice,
    S2SingleSelectedResolver<V?>? selectedResolver,
    S2ChoiceSelect<S2SingleState<V?>, S2Choice<V?>>? onSelect,
    S2ModalOpen<S2SingleState<V?>>? onModalOpen,
    S2ModalClose<S2SingleState<V?>>? onModalClose,
    S2ModalWillOpen<S2SingleState<V?>>? onModalWillOpen,
    S2ModalWillClose<S2SingleState<V?>>? onModalWillClose,
    // S2Validation<S2SingleChosen<V?>>? validation,
    S2Validation<S2SingleChosen<V?>>? modalValidation,
    List<S2Choice<V?>>? choiceItems,
    S2ChoiceLoader<V?>? choiceLoader,
    S2SingleBuilder<V?>? builder,
    S2WidgetBuilder<S2SingleState<V?>>? tileBuilder,
    S2WidgetBuilder<S2SingleState<V?>>? modalBuilder,
    S2WidgetBuilder<S2SingleState<V?>>? modalHeaderBuilder,
    S2ListWidgetBuilder<S2SingleState<V?>>? modalActionsBuilder,
    S2WidgetBuilder<S2SingleState<V?>>? modalConfirmBuilder,
    S2WidgetBuilder<S2SingleState<V?>>? modalDividerBuilder,
    S2WidgetBuilder<S2SingleState<V?>>? modalFooterBuilder,
    S2WidgetBuilder<S2SingleState<V?>>? modalFilterBuilder,
    S2WidgetBuilder<S2SingleState<V?>>? modalFilterToggleBuilder,
    S2ComplexWidgetBuilder<S2SingleState<V?>, S2Choice<V?>>? choiceBuilder,
    S2ComplexWidgetBuilder<S2SingleState<V?>, S2Choice<V?>>? choiceTitleBuilder,
    S2ComplexWidgetBuilder<S2SingleState<V?>, S2Choice<V?>>?
        choiceSubtitleBuilder,
    S2ComplexWidgetBuilder<S2SingleState<V?>, S2Choice<V?>>?
        choiceSecondaryBuilder,
    IndexedWidgetBuilder? choiceDividerBuilder,
    S2WidgetBuilder<S2SingleState<V?>>? choiceEmptyBuilder,
    S2ComplexWidgetBuilder<S2SingleState<V?>, S2Group<V?>>? groupBuilder,
    S2ComplexWidgetBuilder<S2SingleState<V?>, S2Group<V?>>? groupHeaderBuilder,
    S2ChoiceConfig? choiceConfig,
    S2ChoiceStyle? choiceStyle,
    S2ChoiceStyle? choiceActiveStyle,
    S2ChoiceType? choiceType,
    S2ChoiceLayout? choiceLayout,
    Axis? choiceDirection,
    bool? choiceGrouped,
    bool? choiceDivider,
    SliverGridDelegate? choiceGrid,
    int? choiceGridCount,
    double? choiceGridSpacing,
    int? choicePageLimit,
    Duration? choiceDelay,
    S2GroupConfig? groupConfig,
    bool? groupEnabled,
    bool? groupSelector,
    bool? groupCounter,
    S2GroupSort? groupSortBy,
    S2GroupHeaderStyle? groupHeaderStyle,
    S2ModalConfig? modalConfig,
    S2ModalStyle? modalStyle,
    S2ModalHeaderStyle? modalHeaderStyle,
    S2ModalType? modalType,
    String? modalTitle,
    bool? modalConfirm,
    bool? modalHeader,
    bool? modalFilter,
    bool? modalFilterAuto,
    String? modalFilterHint,
    double disabledOpacity = 0.5,
    bool decorationError = true,
    bool fieldError = false,
    bool modalError = false,
  }) : super(
          builder: (field) {
            final InputDecoration effectiveDecoration = decoration
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return InputDecorator(
              decoration: effectiveDecoration.copyWith(
                errorText: decorationError ? field.errorText : null,
                enabled: field.control.enabled,
              ),
              child: Opacity(
                opacity: field.control.enabled ? 1 : disabledOpacity,
                child: IgnorePointer(
                  ignoring: !field.control.enabled,
                  child: SmartSelect<V?>.single(
                    title: title,
                    placeholder: placeholder,
                    selectedValue: field.value,
                    selectedChoice: selectedChoice,
                    selectedResolver: selectedResolver,
                    onChange: (value) => field.didChange(value.value),
                    onSelect: onSelect,
                    onModalOpen: onModalOpen,
                    onModalClose: onModalClose,
                    onModalWillOpen: onModalWillOpen,
                    onModalWillClose: onModalWillClose,
                    validation:
                        fieldError ? (_) => field.errorText ?? '' : null,
                    modalValidation:
                        modalError ? (_) => field.errorText ?? '' : null,
                    choiceItems: choiceItems as List<S2Choice<V?>>,
                    choiceLoader: choiceLoader,
                    builder: builder,
                    tileBuilder: tileBuilder,
                    modalBuilder: modalBuilder,
                    modalHeaderBuilder: modalHeaderBuilder,
                    modalActionsBuilder: modalActionsBuilder,
                    modalConfirmBuilder: modalConfirmBuilder,
                    modalDividerBuilder: modalDividerBuilder,
                    modalFooterBuilder: modalFooterBuilder,
                    modalFilterBuilder: modalFilterBuilder,
                    modalFilterToggleBuilder: modalFilterToggleBuilder,
                    choiceBuilder: choiceBuilder,
                    choiceTitleBuilder: choiceTitleBuilder,
                    choiceSubtitleBuilder: choiceSubtitleBuilder,
                    choiceSecondaryBuilder: choiceSecondaryBuilder,
                    choiceDividerBuilder: choiceDividerBuilder,
                    choiceEmptyBuilder: choiceEmptyBuilder,
                    groupBuilder: groupBuilder,
                    groupHeaderBuilder: groupHeaderBuilder,
                    choiceConfig: choiceConfig,
                    choiceStyle: choiceStyle,
                    choiceActiveStyle: choiceActiveStyle,
                    choiceType: choiceType,
                    choiceLayout: choiceLayout,
                    choiceDirection: choiceDirection,
                    choiceGrouped: choiceGrouped,
                    choiceDivider: choiceDivider,
                    choiceGrid: choiceGrid,
                    choiceGridCount: choiceGridCount,
                    choiceGridSpacing: choiceGridSpacing,
                    choicePageLimit: choicePageLimit,
                    choiceDelay: choiceDelay,
                    groupConfig: groupConfig,
                    groupEnabled: field.control.enabled,
                    groupSelector: groupSelector,
                    groupCounter: groupCounter,
                    groupSortBy: groupSortBy,
                    groupHeaderStyle: groupHeaderStyle,
                    modalConfig: modalConfig,
                    modalStyle: modalStyle,
                    modalHeaderStyle: modalHeaderStyle,
                    modalType: modalType,
                    modalTitle: modalTitle,
                    modalConfirm: modalConfirm,
                    modalHeader: modalHeader,
                    modalFilter: modalFilter,
                    modalFilterAuto: modalFilterAuto,
                    modalFilterHint: modalFilterHint,
                  ),
                ),
              ),
            );
          },
        );

// @override
// ReactiveFormFieldState<T, bool> createState() =>
//     _ReactiveSmartSelectSingleState<V?>();
}

// class _ReactiveSmartSelectSingleState<V?>
//     extends ReactiveFormFieldState<T, bool> {
//   late AdvancedSwitchController _advancedSwitchController;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _advancedSwitchController = AdvancedSwitchController(
//       this.valueAccessor.modelToViewValue(this.control.value) ?? false,
//     )..addListener(
//         () {
//           this.control.markAsTouched();
//           this.didChange(_advancedSwitchController.value);
//         },
//       );
//   }
//
//   @override
//   void dispose() {
//     _advancedSwitchController.dispose();
//     super.dispose();
//   }
// }

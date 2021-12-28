library reactive_awesome_select;

import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '/src/decoration.dart';

/// A [ReactiveSmartSelectMultiple] that contains a [AdvancedSwitch].
///
/// This is a convenience widget that wraps a [AdvancedSwitch] widget in a
/// [ReactiveSmartSelectMultiple].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveSmartSelectMultiple<T, V>
    extends ReactiveFormField<List<T>, List<V>> {
  /// Creates a [ReactiveSmartSelectMultiple] that contains a [AdvancedSwitch].
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
  /// ReactiveSmartSelectMultiple(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveSmartSelectMultiple(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveSmartSelectMultiple(
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
  /// ReactiveSmartSelectMultiple(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [AwesomeSelect] class
  /// and [new AwesomeSelect], the constructor.
  ReactiveSmartSelectMultiple({
    Key? key,
    String? formControlName,
    FormControl<List<T>>? formControl,
    ValidationMessagesFunction<List<T>>? validationMessages,
    ControlValueAccessor<List<T>, List<V>>? valueAccessor,
    ShowErrorsFunction? showErrors,
    ////////////////////////////////////////////////////////////////////////////
    InputDecoration decoration = decorationInvisible,
    String? title,
    String placeholder = 'Select one or more',
    List<S2Choice<V>>? selectedChoice,
    S2MultiSelectedResolver<V>? selectedResolver,
    S2ChoiceSelect<S2MultiState<V>, S2Choice<V>>? onSelect,
    S2ModalOpen<S2MultiState<V>>? onModalOpen,
    S2ModalClose<S2MultiState<V>>? onModalClose,
    S2ModalWillOpen<S2MultiState<V>>? onModalWillOpen,
    S2ModalWillClose<S2MultiState<V>>? onModalWillClose,
    S2Validation<S2MultiChosen<V>>? validation,
    S2Validation<S2MultiChosen<V>>? modalValidation,
    List<S2Choice<V>>? choiceItems,
    S2ChoiceLoader<V>? choiceLoader,
    S2MultiBuilder<V>? builder,
    S2WidgetBuilder<S2MultiState<V>>? tileBuilder,
    S2WidgetBuilder<S2MultiState<V>>? modalBuilder,
    S2WidgetBuilder<S2MultiState<V>>? modalHeaderBuilder,
    S2ListWidgetBuilder<S2MultiState<V>>? modalActionsBuilder,
    S2WidgetBuilder<S2MultiState<V>>? modalConfirmBuilder,
    S2WidgetBuilder<S2MultiState<V>>? modalDividerBuilder,
    S2WidgetBuilder<S2MultiState<V>>? modalFooterBuilder,
    S2WidgetBuilder<S2MultiState<V>>? modalFilterBuilder,
    S2WidgetBuilder<S2MultiState<V>>? modalFilterToggleBuilder,
    S2ComplexWidgetBuilder<S2MultiState<V>, S2Choice<V>>? choiceBuilder,
    S2ComplexWidgetBuilder<S2MultiState<V>, S2Choice<V>>? choiceTitleBuilder,
    S2ComplexWidgetBuilder<S2MultiState<V>, S2Choice<V>>? choiceSubtitleBuilder,
    S2ComplexWidgetBuilder<S2MultiState<V>, S2Choice<V>>?
        choiceSecondaryBuilder,
    IndexedWidgetBuilder? choiceDividerBuilder,
    S2WidgetBuilder<S2MultiState<V>>? choiceEmptyBuilder,
    S2ComplexWidgetBuilder<S2MultiState<V>, S2Group<V>>? groupBuilder,
    S2ComplexWidgetBuilder<S2MultiState<V>, S2Group<V>>? groupHeaderBuilder,
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
                errorText: decorationError ? field.errorText : null,
                enabled: field.control.enabled,
              ),
              child: Opacity(
                opacity: field.control.enabled ? 1 : disabledOpacity,
                child: IgnorePointer(
                  ignoring: !field.control.enabled,
                  child: SmartSelect<V>.multiple(
                    title: title,
                    placeholder: placeholder,
                    selectedValue: field.value ?? [],
                    selectedChoice: selectedChoice,
                    selectedResolver: selectedResolver,
                    onChange: (selected) => field.didChange(selected.value),
                    onSelect: onSelect,
                    onModalOpen: onModalOpen,
                    onModalClose: onModalClose,
                    onModalWillOpen: onModalWillOpen,
                    onModalWillClose: onModalWillClose,
                    validation:
                        fieldError ? (_) => field.errorText ?? '' : null,
                    modalValidation:
                        modalError ? (_) => field.errorText ?? '' : null,
                    choiceItems: choiceItems,
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
                    groupEnabled: groupEnabled,
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
  //     _ReactiveSmartSelectMultipleState<List<V>>();
}

// class _ReactiveSmartSelectMultipleState<List<V>>
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

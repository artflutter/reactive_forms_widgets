library reactive_awesome_select;

import 'package:awesome_select/awesome_select.dart';
import 'package:awesome_select/src/model/chosen.dart';
import 'package:awesome_select/src/model/choice_loader.dart';
import 'package:flutter/cupertino.dart';
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
class ReactiveSmartSelectSingle<T, V> extends ReactiveFormField<T, V> {
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
  /// and [new AwesomeSelect], the constructor.
  ReactiveSmartSelectSingle({
    Key? key,
    String? formControlName,
    FormControl<T>? formControl,
    ValidationMessagesFunction<T>? validationMessages,
    ControlValueAccessor<T, V>? valueAccessor,
    ShowErrorsFunction? showErrors,
    ////////////////////////////////////////////////////////////////////////////
    InputDecoration decoration = decorationInvisible,
    String? title,
    String placeholder = 'Select one',
    // V? selectedValue,
    S2Choice<V>? selectedChoice,
    S2SingleSelectedResolver<V?>? selectedResolver,
    // ValueChanged<S2SingleSelected<V>>? onChange,
    S2ChoiceSelect<S2SingleState<V>, S2Choice<V>>? onSelect,
    S2ModalOpen<S2SingleState<V>>? onModalOpen,
    S2ModalClose<S2SingleState<V>>? onModalClose,
    S2ModalWillOpen<S2SingleState<V>>? onModalWillOpen,
    S2ModalWillClose<S2SingleState<V>>? onModalWillClose,
    S2Validation<S2SingleChosen<V?>>? validation,
    S2Validation<S2SingleChosen<V>>? modalValidation,
    List<S2Choice<V>>? choiceItems,
    S2ChoiceLoader<V>? choiceLoader,
    S2SingleBuilder<V>? builder,
    S2WidgetBuilder<S2SingleState<V>>? tileBuilder,
    S2WidgetBuilder<S2SingleState<V>>? modalBuilder,
    S2WidgetBuilder<S2SingleState<V>>? modalHeaderBuilder,
    S2ListWidgetBuilder<S2SingleState<V>>? modalActionsBuilder,
    S2WidgetBuilder<S2SingleState<V>>? modalConfirmBuilder,
    S2WidgetBuilder<S2SingleState<V>>? modalDividerBuilder,
    S2WidgetBuilder<S2SingleState<V>>? modalFooterBuilder,
    S2WidgetBuilder<S2SingleState<V>>? modalFilterBuilder,
    S2WidgetBuilder<S2SingleState<V>>? modalFilterToggleBuilder,
    S2ComplexWidgetBuilder<S2SingleState<V>, S2Choice<V>>? choiceBuilder,
    S2ComplexWidgetBuilder<S2SingleState<V>, S2Choice<V>>? choiceTitleBuilder,
    S2ComplexWidgetBuilder<S2SingleState<V>, S2Choice<V>>?
        choiceSubtitleBuilder,
    S2ComplexWidgetBuilder<S2SingleState<V>, S2Choice<V>>?
        choiceSecondaryBuilder,
    IndexedWidgetBuilder? choiceDividerBuilder,
    S2WidgetBuilder<S2SingleState<V>>? choiceEmptyBuilder,
    S2ComplexWidgetBuilder<S2SingleState<V>, S2Group<V>>? groupBuilder,
    S2ComplexWidgetBuilder<S2SingleState<V>, S2Group<V>>? groupHeaderBuilder,
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
              child: SmartSelect<String>.single(
                title: title,
                /*placeholder: placeholder,*/
                selectedValue: null,
                // S2Choice<V>? selectedChoice,
                // S2SingleSelectedResolver<V?>? selectedResolver,
                onChange: (value) {
                  //   field.didChange(value.value);
                },
                // S2ChoiceSelect<S2SingleState<V>, S2Choice<V>>? onSelect,
                // S2ModalOpen<S2SingleState<V>>? onModalOpen,
                // S2ModalClose<S2SingleState<V>>? onModalClose,
                // S2ModalWillOpen<S2SingleState<V>>? onModalWillOpen,
                // S2ModalWillClose<S2SingleState<V>>? onModalWillClose,
                // S2Validation<S2SingleChosen<V?>>? validation,
                // S2Validation<S2SingleChosen<V>>? modalValidation,
                choiceItems: choiceItems as List<S2Choice<String>>,
                // S2ChoiceLoader<V>? choiceLoader,
                // S2SingleBuilder<V>? builder,
                // S2WidgetBuilder<S2SingleState<V>>? tileBuilder,
                // S2WidgetBuilder<S2SingleState<V>>? modalBuilder,
                // S2WidgetBuilder<S2SingleState<V>>? modalHeaderBuilder,
                // S2ListWidgetBuilder<S2SingleState<V>>? modalActionsBuilder,
                // S2WidgetBuilder<S2SingleState<V>>? modalConfirmBuilder,
                // S2WidgetBuilder<S2SingleState<V>>? modalDividerBuilder,
                // S2WidgetBuilder<S2SingleState<V>>? modalFooterBuilder,
                // S2WidgetBuilder<S2SingleState<V>>? modalFilterBuilder,
                // S2WidgetBuilder<S2SingleState<V>>? modalFilterToggleBuilder,
                // S2ComplexWidgetBuilder<S2SingleState<V>, S2Choice<V>>? choiceBuilder,
                // S2ComplexWidgetBuilder<S2SingleState<V>, S2Choice<V>>? choiceTitleBuilder,
                // S2ComplexWidgetBuilder<S2SingleState<V>, S2Choice<V>>?
                // choiceSubtitleBuilder,
                // S2ComplexWidgetBuilder<S2SingleState<V>, S2Choice<V>>?
                // choiceSecondaryBuilder,
                // IndexedWidgetBuilder? choiceDividerBuilder,
                // S2WidgetBuilder<S2SingleState<V>>? choiceEmptyBuilder,
                // S2ComplexWidgetBuilder<S2SingleState<V>, S2Group<V>>? groupBuilder,
                // S2ComplexWidgetBuilder<S2SingleState<V>, S2Group<V>>? groupHeaderBuilder,
                // S2ChoiceConfig? choiceConfig,
                // S2ChoiceStyle? choiceStyle,
                // S2ChoiceStyle? choiceActiveStyle,
                // S2ChoiceType? choiceType,
                // S2ChoiceLayout? choiceLayout,
                /*choiceDirection: choiceDirection,
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
                modalFilterHint: modalFilterHint,*/
              ),
            );
          },
        );

  // @override
  // ReactiveFormFieldState<T, bool> createState() =>
  //     _ReactiveSmartSelectSingleState<V>();
}

// class _ReactiveSmartSelectSingleState<V>
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

import 'package:reactive_material_ui/reactive_material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'reactive_material_radio_testing_widget.dart';

/// Gets the group value of the [RadioGroup] that wraps the radio.
bool? groupValueOf(WidgetTester tester) =>
    tester.widget<RadioGroup<bool>>(find.byType(RadioGroup<bool>)).groupValue;

void main() {
  group('ReactiveMaterialRadio Tests', () {
    testWidgets('Radio init with true if control init in true', (
      WidgetTester tester,
    ) async {
      // Given: a form with and a control with default true
      final form = FormGroup({
        reactiveRadioTestingName: FormControl<bool>(value: true),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveRadioTestingWidget(form: form));

      // Expect radio group value is true
      expect(groupValueOf(tester), true);
    });

    testWidgets('Radio init with false if control init in false', (
      WidgetTester tester,
    ) async {
      // Given: a form with and a control with default false
      final form = FormGroup({
        reactiveRadioTestingName: FormControl<bool>(value: false),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveRadioTestingWidget(form: form));

      // Expect radio group value is false
      expect(groupValueOf(tester), false);
    });

    testWidgets(
      'Radio changes value to true when control value changes to true',
      (WidgetTester tester) async {
        // Given: a form with and a control with default false
        final form = FormGroup({
          reactiveRadioTestingName: FormControl<bool>(value: false),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveRadioTestingWidget(form: form));

        // When: changes control to true
        form.control(reactiveRadioTestingName).value = true;
        await tester.pump();

        // Expect radio group value is true
        expect(groupValueOf(tester), true);
      },
    );

    testWidgets(
      'Radio changes value to false when control value changes to false',
      (WidgetTester tester) async {
        // Given: a form with and a control with default true
        final form = FormGroup({
          reactiveRadioTestingName: FormControl<bool>(value: true),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveRadioTestingWidget(form: form));

        // When: changes control to false
        form.control(reactiveRadioTestingName).value = false;
        await tester.pump();

        // Expect radio group value is true
        expect(groupValueOf(tester), false);
      },
    );

    testWidgets('Control disabled by default disable Radio', (
      WidgetTester tester,
    ) async {
      // Given: a form with and a control with default true
      final form = FormGroup({
        reactiveRadioTestingName: FormControl<bool>(disabled: true),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveRadioTestingWidget(form: form));

      // Then: the radio is disabled
      final radio = tester.firstWidget<Radio<bool>>(find.byType(Radio<bool>));
      expect(radio.enabled, false);
    });

    testWidgets('Disable a control disable Radio', (WidgetTester tester) async {
      // Given: a form
      final form = FormGroup({reactiveRadioTestingName: FormControl<bool>()});

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveRadioTestingWidget(form: form));

      // When: disable form
      form.markAsDisabled();
      await tester.pump();

      // Then: the radio is disabled
      final radio = tester.firstWidget<Radio<bool>>(find.byType(Radio<bool>));
      expect(radio.enabled, false);
    });

    testWidgets('Enable a control enable Radio', (WidgetTester tester) async {
      // Given: a form with disabled
      final form = FormGroup({
        reactiveRadioTestingName: FormControl<bool>(disabled: true),
      });

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveRadioTestingWidget(form: form));

      // When: enable form
      form.markAsEnabled();
      await tester.pump();

      // Then: the radio is enabled
      final radio = tester.firstWidget<Radio<bool>>(find.byType(Radio<bool>));
      expect(radio.enabled, true);
    });

    testWidgets('Call FormControl.focus() request focus on field', (
      WidgetTester tester,
    ) async {
      // Given: A group with a field
      final form = FormGroup({reactiveRadioTestingName: FormControl<bool>()});

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveRadioTestingWidget(form: form));

      // Expect: that the field has no focus
      var radioField = tester.firstWidget<Radio<bool>>(
        find.byType(Radio<bool>),
      );
      expect(radioField.focusNode?.hasFocus, false);

      // When: call FormControl.focus()
      (form.control(reactiveRadioTestingName) as FormControl).focus();
      await tester.pump();

      // Then: the reactive field is focused
      radioField = tester.firstWidget<Radio<bool>>(find.byType(Radio<bool>));
      expect(radioField.focusNode?.hasFocus, true);
    });

    testWidgets('Call FormControl.unfocus() remove focus on field', (
      WidgetTester tester,
    ) async {
      // Given: A group with a field
      final form = FormGroup({reactiveRadioTestingName: FormControl<bool>()});

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveRadioTestingWidget(form: form));

      // And: the field has focused
      var radioField = tester.firstWidget<Radio<bool>>(
        find.byType(Radio<bool>),
      );
      radioField.focusNode?.requestFocus();
      await tester.pump();
      expect(radioField.focusNode?.hasFocus, true);

      // When: call FormControl.unfocus()
      (form.control(reactiveRadioTestingName) as FormControl).unfocus();
      await tester.pump();

      // Then: the reactive field is unfocused
      radioField = tester.firstWidget<Radio<bool>>(find.byType(Radio<bool>));
      expect(radioField.focusNode?.hasFocus, false);
    });

    testWidgets('Remove focus on an invalid control show error messages', (
      WidgetTester tester,
    ) async {
      // Given: A group with an invalid control
      final form = FormGroup({reactiveRadioTestingName: FormControl<bool>()});

      // And: a widget that is bind to the form
      await tester.pumpWidget(ReactiveRadioTestingWidget(form: form));

      // And: the field has focused
      var radioField = tester.firstWidget<Radio<bool>>(
        find.byType(Radio<bool>),
      );
      radioField.focusNode?.requestFocus();
      await tester.pump();
      expect(radioField.focusNode?.hasFocus, true);

      // When: call FormControl.unfocus()
      (form.control(reactiveRadioTestingName) as FormControl).unfocus();
      await tester.pump();
    });

    testWidgets(
      'Remove focus, and mark a control as untouched does not show error messages',
      (WidgetTester tester) async {
        // Given: A group with an invalid control
        final form = FormGroup({
          reactiveRadioTestingName: FormControl<bool>(
            validators: [Validators.required],
          ),
        });

        // And: a widget that is bind to the form
        await tester.pumpWidget(ReactiveRadioTestingWidget(form: form));

        // And: the field has focused
        var textField = tester.firstWidget<Radio<bool>>(
          find.byType(Radio<bool>),
        );
        textField.focusNode?.requestFocus();
        await tester.pump();
        expect(textField.focusNode?.hasFocus, true);

        // When: call FormControl.unfocus(touched: false)
        form.control(reactiveRadioTestingName).unfocus(touched: false);
        await tester.pump();
      },
    );

    testWidgets('Provide a FocusNode to ReactiveMaterialRadio', (
      WidgetTester tester,
    ) async {
      // Given: A group with a field
      final form = FormGroup({reactiveRadioTestingName: FormControl<bool>()});

      // And: a focus node
      final focusNode = FocusNode();

      // And: a widget that is bind to the form
      await tester.pumpWidget(
        ReactiveRadioTestingWidget(form: form, focusNode: focusNode),
      );

      // Expect: field has the provided focus node
      final textField = tester.firstWidget<Radio<bool>>(
        find.byType(Radio<bool>),
      );
      expect(textField.focusNode, focusNode);
    });

    testWidgets(
      'Provide a FocusNode to ReactiveMaterialRadio and access it through focus controller',
      (WidgetTester tester) async {
        // Given: A group with a field
        final nameControl = FormControl<bool>();
        final form = FormGroup({reactiveRadioTestingName: nameControl});

        // And: a focus node
        final focusNode = FocusNode();

        // And: a widget that is bind to the form
        await tester.pumpWidget(
          ReactiveRadioTestingWidget(form: form, focusNode: focusNode),
        );

        // Expect: field has the provided focus node and is the same of the
        // focus controller
        final textField = tester.firstWidget<Radio<bool>>(
          find.byType(Radio<bool>),
        );
        expect(textField.focusNode, nameControl.focusController?.focusNode);
      },
    );

    testWidgets('ReactiveMaterialRadio onChanged callback is called', (
      WidgetTester tester,
    ) async {
      // Given: a form with and control with default value
      final form = FormGroup({
        reactiveRadioTestingName: FormControl<bool>(value: false),
      });

      var callbackCalled = false;
      FormControl<bool>? callbackArg;

      // And: a widget that is bind to the form
      await tester.pumpWidget(
        ReactiveRadioTestingWidget(
          form: form,
          onChanged: (control) {
            callbackCalled = true;
            callbackArg = control;
          },
        ),
      );

      // When: user change switch value
      await tester.tap(find.byType(Radio<bool>));
      await tester.pump();

      // Then: onChanged callback is called
      expect(callbackCalled, true);

      // And: callback argument is the control
      expect(callbackArg, form.control(reactiveRadioTestingName));

      // And: control has the right value
      expect(form.control(reactiveRadioTestingName).value, true);
    });
  });
}

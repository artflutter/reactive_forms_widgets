import 'dart:ui' show CheckedState;

import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_material_ui/reactive_material_ui.dart';

const _values = ['a', 'b', 'c'];

Widget _buildRadios(FormGroup form, {bool toggleable = false}) {
  return MaterialApp(
    home: Material(
      child: ReactiveForm(
        formGroup: form,
        child: Column(
          children: [
            for (final value in _values)
              ReactiveMaterialRadio<String>(
                key: Key('radio-$value'),
                formControlName: 'choice',
                value: value,
                toggleable: toggleable,
              ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildRadioListTiles(FormGroup form, {bool toggleable = false}) {
  return MaterialApp(
    home: Material(
      child: ReactiveForm(
        formGroup: form,
        child: Column(
          children: [
            for (final value in _values)
              ReactiveMaterialRadioListTile<String>(
                key: Key('tile-$value'),
                formControlName: 'choice',
                value: value,
                toggleable: toggleable,
                title: Text(value),
              ),
          ],
        ),
      ),
    ),
  );
}

/// Gets which of [_values] are rendered as checked.
List<String> _checkedValues(WidgetTester tester, String prefix) {
  bool isChecked(String value) {
    final radio = find.descendant(
      of: find.byKey(Key('$prefix-$value')),
      matching: find.byType(Radio<String>),
    );
    // Merged data, since a RadioListTile merges the Radio semantics up.
    final data = tester.getSemantics(radio).getSemanticsData();
    return data.flagsCollection.isChecked == CheckedState.isTrue;
  }

  return [
    for (final value in _values)
      if (isChecked(value)) value,
  ];
}

void main() {
  for (final (name, build, prefix) in [
    ('ReactiveMaterialRadio', _buildRadios, 'radio'),
    ('ReactiveMaterialRadioListTile', _buildRadioListTiles, 'tile'),
  ]) {
    group('$name bound to the same control', () {
      testWidgets('selecting a radio updates the control', (tester) async {
        final form = FormGroup({'choice': FormControl<String>(value: 'a')});
        await tester.pumpWidget(build(form));

        await tester.tap(find.byKey(Key('$prefix-b')));
        await tester.pump();

        expect(form.control('choice').value, 'b');
        expect(form.control('choice').dirty, true);
        expect(_checkedValues(tester, prefix), ['b']);
      });

      testWidgets('changing the control updates the radios', (tester) async {
        final form = FormGroup({'choice': FormControl<String>()});
        await tester.pumpWidget(build(form));
        expect(_checkedValues(tester, prefix), isEmpty);

        form.control('choice').value = 'c';
        await tester.pump();
        expect(_checkedValues(tester, prefix), ['c']);

        form.control('choice').value = null;
        await tester.pump();
        expect(_checkedValues(tester, prefix), isEmpty);
      });

      testWidgets('tapping the selected radio keeps the value', (tester) async {
        final form = FormGroup({'choice': FormControl<String>(value: 'a')});
        await tester.pumpWidget(build(form));

        await tester.tap(find.byKey(Key('$prefix-a')));
        await tester.pump();

        expect(form.control('choice').value, 'a');
      });

      testWidgets('toggleable radio clears the value when tapped again', (
        tester,
      ) async {
        final form = FormGroup({'choice': FormControl<String>(value: 'a')});
        await tester.pumpWidget(build(form, toggleable: true));

        await tester.tap(find.byKey(Key('$prefix-a')));
        await tester.pump();

        expect(form.control('choice').value, null);
        expect(_checkedValues(tester, prefix), isEmpty);
      });

      testWidgets('disabled control ignores taps', (tester) async {
        final form = FormGroup({
          'choice': FormControl<String>(value: 'a', disabled: true),
        });
        await tester.pumpWidget(build(form));

        await tester.tap(find.byKey(Key('$prefix-b')));
        await tester.pump();

        expect(form.control('choice').value, 'a');
      });
    });
  }
}

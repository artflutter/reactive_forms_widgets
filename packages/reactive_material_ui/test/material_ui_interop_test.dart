import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_material_ui/reactive_material_ui.dart';

// Regression tests for https://github.com/joanpablo/reactive_forms/issues/507:
// apps built on package:material_ui must be able to pass material_ui types
// (InputDecoration, TimeOfDay, ...) to the reactive widgets. material_ui is
// re-exported by package:reactive_material_ui.
void main() {
  group('material_ui interop Tests', () {
    testWidgets('Accepts an InputDecoration from material_ui', (
      WidgetTester tester,
    ) async {
      // Given: a form
      final form = FormGroup({
        'name': FormControl<String>(),
        'color': FormControl<String>(),
      });

      // And: widgets decorated with material_ui's InputDecoration
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: ReactiveForm(
              formGroup: form,
              child: Column(
                children: [
                  ReactiveMaterialTextField<String>(
                    formControlName: 'name',
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  ReactiveMaterialDropdownField<String>(
                    formControlName: 'color',
                    decoration: InputDecoration(labelText: 'Color'),
                    items: [DropdownMenuItem(value: 'red', child: Text('Red'))],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // Then: the decorations are rendered
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Color'), findsOneWidget);
    });

    testWidgets(
      'Binds a FormControl of material_ui TimeOfDay to a text field',
      (WidgetTester tester) async {
        // Given: a control holding a material_ui TimeOfDay
        final form = FormGroup({
          'time': FormControl<TimeOfDay>(
            value: const TimeOfDay(hour: 9, minute: 30),
          ),
        });

        // When: bind it to a text field without an explicit value accessor
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: ReactiveForm(
                formGroup: form,
                child: ReactiveMaterialTextField<TimeOfDay>(
                  formControlName: 'time',
                ),
              ),
            ),
          ),
        );

        // Then: the time is displayed
        expect(find.text('9:30'), findsOneWidget);
      },
    );
  });
}

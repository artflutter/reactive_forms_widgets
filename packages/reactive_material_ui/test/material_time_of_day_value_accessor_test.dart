import 'package:reactive_material_ui/reactive_material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('MaterialTimeOfDayValueAccessor Tests', () {
    test('MaterialTimeOfDayValueAccessor converts to view value', () {
      // Given: a control
      final control = fb.control(TimeOfDay.now());

      // And: an int value accessor
      final valueAccessor = MaterialTimeOfDayValueAccessor();

      // When: register control
      valueAccessor.registerControl(control);

      // And: set control value:
      control.value = const TimeOfDay(hour: 8, minute: 30);

      // Then: value is converted correctly
      expect(valueAccessor.modelToViewValue(control.value), '8:30');
    });

    test('MaterialTimeOfDayValueAccessor converts to model value', () {
      // Given: a control
      final control = fb.control(TimeOfDay.now());

      // And: an int value accessor
      final valueAccessor = MaterialTimeOfDayValueAccessor();

      // When: register control
      valueAccessor.registerControl(control);

      // And: update accessor model value:
      valueAccessor.updateModel('8:30');

      // Then: value is converted correctly
      expect(control.value, const TimeOfDay(hour: 8, minute: 30));
    });

    test(
      'MaterialTimeOfDayValueAccessor converts to empty string a null value',
      () {
        // Given: a control
        final control = fb.control(TimeOfDay.now());

        // And: an int value accessor
        final valueAccessor = MaterialTimeOfDayValueAccessor();

        // When: register control
        valueAccessor.registerControl(control);

        // And: set control value:
        control.value = null;

        // Then: value is converted correctly
        expect(valueAccessor.modelToViewValue(control.value), '');
      },
    );

    test('MaterialTimeOfDayValueAccessor converts to null an empty string', () {
      // Given: a control
      final control = fb.control(TimeOfDay.now());

      // And: an int value accessor
      final valueAccessor = MaterialTimeOfDayValueAccessor();

      // When: register control
      valueAccessor.registerControl(control);

      // And: update accessor model value:
      valueAccessor.updateModel('');

      // Then: value is converted correctly
      expect(control.value, null);
    });

    test('MaterialTimeOfDayValueAccessor converts to null a null value', () {
      // Given: a control
      final control = fb.control(TimeOfDay.now());

      // And: an int value accessor
      final valueAccessor = MaterialTimeOfDayValueAccessor();

      // When: register control
      valueAccessor.registerControl(control);

      // And: update accessor model value:
      valueAccessor.updateModel(null);

      // Then: value is converted correctly
      expect(control.value, null);
    });
  });
}

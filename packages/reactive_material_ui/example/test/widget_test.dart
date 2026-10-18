import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_material_ui/reactive_material_ui.dart';
import 'package:reactive_material_ui_example/main.dart';

void main() {
  testWidgets('Example renders every widget', (WidgetTester tester) async {
    // Tall enough for the whole ListView to be built.
    tester.view.physicalSize = const Size(800, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MyApp());

    expect(find.byType(ReactiveMaterialTextField<String>), findsOneWidget);
    expect(find.byType(ReactiveMaterialTextField<TimeOfDay>), findsOneWidget);
    expect(find.byType(ReactiveMaterialDropdownField<String>), findsOneWidget);
    expect(find.byType(ReactiveMaterialCheckbox), findsOneWidget);
    expect(find.byType(ReactiveMaterialCheckboxListTile), findsOneWidget);
    expect(find.byType(ReactiveMaterialRadio<String>), findsOneWidget);
    expect(find.byType(ReactiveMaterialRadioListTile<String>), findsOneWidget);
    expect(find.byType(ReactiveMaterialSwitch), findsOneWidget);
    expect(find.byType(ReactiveMaterialSwitchListTile), findsOneWidget);
    expect(find.byType(ReactiveMaterialSlider), findsOneWidget);
    expect(find.byType(ReactiveMaterialDatePicker<DateTime>), findsOneWidget);
    expect(find.byType(ReactiveMaterialTimePicker), findsOneWidget);
    expect(find.text('9:30'), findsOneWidget);
  });
}

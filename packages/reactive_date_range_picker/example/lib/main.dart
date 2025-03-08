import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:reactive_date_range_picker/reactive_date_range_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  FormGroup buildForm() => fb.group({
        'dateRange': FormControl<DateTimeRange>(),
        'dateRange2': FormControl<DateTimeRange>(
          disabled: true,
          value: DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(const Duration(days: 1)),
          ),
        ),
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: ReactiveFormBuilder(
              form: buildForm,
              builder: (context, form, child) {
                return Column(
                  children: [
                    ReactiveDateRangePicker(
                      formControlName: 'dateRange',
                      decoration: const InputDecoration(
                        labelText: 'Date range',
                        border: OutlineInputBorder(),
                        helperText: '',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ReactiveDateRangePicker(
                      formControlName: 'dateRange2',
                      decoration: const InputDecoration(
                        labelText: 'Date range',
                        border: OutlineInputBorder(),
                        helperText: '',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                    ReactiveDateRangePicker(
                      formControlName: 'dateRange',
                      decoration: const InputDecoration(
                        labelText: 'Date Range',
                        hintText: 'hintText',
                        border: OutlineInputBorder(),
                        helperText: 'helperText',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: (context, value) async {
                        return await showDateRangePicker(
                          context,
                          value: value,
                        );
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Sign Up'),
                      onPressed: () {
                        if (form.valid) {
                          // ignore: avoid_print
                          print(form.value);
                        } else {
                          form.markAllAsTouched();
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

Future<DateTimeRange?> showDateRangePicker(
  BuildContext context, {
  DateTime? firstDate,
  DateTime? lastDate,
  DateTime? currentDate,
  DateTimeRange? value,
}) async {
  final selectedDates = await _showCalendarDatePicker2Dialog(
    context,
    calendarType: CalendarDatePicker2Type.range,
    currentDate: currentDate,
    firstDate: firstDate,
    lastDate: lastDate,
    value: [value?.start, value?.end],
  );

  if (selectedDates == null || selectedDates.isEmpty) return value;

  return DateTimeRange(
    start: selectedDates[0] ?? DateTime.now(),
    end: selectedDates[selectedDates.length == 1 ? 0 : 1] ?? DateTime.now(),
  );
}

Future<List<DateTime?>?> _showCalendarDatePicker2Dialog(
  BuildContext context, {
  required CalendarDatePicker2Type calendarType,
  List<DateTime?> value = const [],
  DateTime? firstDate,
  DateTime? lastDate,
  DateTime? currentDate,
}) async {
  return showCalendarDatePicker2Dialog(
    value: value,
    context: context,
    config: getCalendarConfig(
      context,
      calendarType: calendarType,
      firstDate: firstDate,
      lastDate: lastDate,
      currentDate: currentDate,
    ),
    dialogSize: const Size(360, 400),
    borderRadius: BorderRadius.circular(16),
    dialogBackgroundColor: Colors.white,
  );
}

CalendarDatePicker2WithActionButtonsConfig getCalendarConfig(
  BuildContext context, {
  CalendarDatePicker2Type calendarType = CalendarDatePicker2Type.single,
  DateTime? firstDate,
  DateTime? lastDate,
  DateTime? currentDate,
}) {
  final primaryColor = Theme.of(context).primaryColor;

  const dayTextStyle = TextStyle(
    fontWeight: FontWeight.w700,
  );

  final firstDay = firstDate?.startOfDay();
  final lastDay = lastDate?.startOfDay();

  return CalendarDatePicker2WithActionButtonsConfig(
    firstDate: firstDate,
    lastDate: lastDate,
    dayTextStyle: dayTextStyle,
    calendarType: calendarType,
    selectedDayHighlightColor: primaryColor,
    closeDialogOnCancelTapped: true,
    firstDayOfWeek: 1,
    selectableDayPredicate: (day) =>
        (firstDay == null || !day.isBefore(firstDay)) &&
        (lastDay == null || !day.isAfter(lastDay)),
    currentDate: currentDate,
    weekdayLabelTextStyle: TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.w500,
    ),
    controlsTextStyle: TextStyle(
      color: primaryColor,
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    centerAlignModePicker: true,
    customModePickerIcon: const SizedBox(),
    selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),
    nextMonthIcon: Icon(
      Icons.arrow_right,
      size: 20,
      color: primaryColor,
    ),
    lastMonthIcon: Icon(
      Icons.arrow_left,
      size: 20,
      color: primaryColor,
    ),
    todayTextStyle: dayTextStyle.merge(TextStyle(color: primaryColor)),
  );
}

extension on DateTime {
  DateTime startOfDay() {
    return DateTime(year, month, day);
  }
}

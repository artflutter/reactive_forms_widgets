import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  FormGroup buildForm() => fb.group({
        'date': FormControl<DateTime>(value: DateTime.now(), disabled: true),
        'time': FormControl<DateTime>(value: DateTime.now()),
        'dateTime': FormControl<DateTime>(value: DateTime.now()),
        'dateTimeNullable': FormControl<DateTime>(value: null),
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
                    const SizedBox(height: 8),
                    ReactiveDateTimePicker(
                      formControlName: 'date',
                      decoration: const InputDecoration(
                        labelText: 'Date',
                        border: OutlineInputBorder(),
                        helperText: '',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Time',
                        border: OutlineInputBorder(),
                        helperText: '',
                        filled: true,
                        fillColor: Colors.green,
                        // hoverColor: Colors.yellow,
                        suffixIcon: Icon(Icons.watch_later_outlined),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ReactiveDateTimePicker(
                      formControlName: 'time',
                      type: ReactiveDatePickerFieldType.time,
                      decoration: const InputDecoration(
                        labelText: 'Time',
                        border: OutlineInputBorder(),
                        helperText: '',
                        filled: true,
                        fillColor: Colors.green,
                        // hoverColor: Colors.yellow,
                        suffixIcon: Icon(Icons.watch_later_outlined),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ReactiveDateTimePicker(
                            formControlName: 'dateTime',
                            type: ReactiveDatePickerFieldType.dateTime,
                            decoration: const InputDecoration(
                              labelText: 'Date & Time',
                              border: OutlineInputBorder(),
                              helperText: '',
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            valueBuilder: (_, value) => Text(
                              value ?? '',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                              decoration: const InputDecoration(
                            labelText: 'Date & Time',
                            border: OutlineInputBorder(),
                            helperText: '',
                            suffixIcon: Icon(Icons.calendar_today),
                          )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ReactiveDateTimePicker(
                      formControlName: 'dateTimeNullable',
                      type: ReactiveDatePickerFieldType.dateTime,
                      decoration: const InputDecoration(
                        labelText: 'Date & Time',
                        hintText: 'hintText',
                        border: OutlineInputBorder(),
                        helperText: 'helperText',
                        suffixIcon: Icon(Icons.calendar_today),
                        
                      ),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 1)),
                      
                    ),
                    const SizedBox(height: 8),
                    ReactiveDateTimePicker(
                      formControlName: 'dateTimeNullable',
                      type: ReactiveDatePickerFieldType.date,
                      decoration: const InputDecoration(
                        labelText: 'Date & Time',
                        hintText: 'hintText',
                        border: OutlineInputBorder(),
                        helperText: 'helperText',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: (context, value) async {
                        return await showDatePicker(context);
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      child: const Text('Sign Up'),
                      onPressed: () {
                        showTimePicker(
                            context: context,
                            initialTime:
                                TimeOfDay.fromDateTime(DateTime.now()));
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

Future<DateTime?> showDatePicker(
  BuildContext context, {
  DateTime? value,
  DateTime? firstDate,
  DateTime? lastDate,
  DateTime? currentDate,
}) async {
  final result = await _showCalendarDatePicker2Dialog(
    context,
    firstDate: firstDate,
    lastDate: lastDate,
    currentDate: currentDate,
    value: [value],
    calendarType: CalendarDatePicker2Type.single,
  );

  return result?.firstOrNull;
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
    config: calendarConfig(
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

CalendarDatePicker2WithActionButtonsConfig calendarConfig(
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
      Icons.arrow_circle_right,
      size: 20,
      color: primaryColor,
    ),
    lastMonthIcon: Icon(
      Icons.arrow_circle_left,
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

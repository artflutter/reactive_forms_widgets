import 'package:flutter/material.dart';
import 'package:reactive_animated_toggle_switch/reactive_animated_toggle_switch.dart';
import 'package:reactive_forms/reactive_forms.dart';

Widget rollingIconBuilder(int? value, bool foreground) {
  return Icon(iconDataByValue(value));
}

IconData iconDataByValue(int? value) => switch (value) {
      0 => Icons.access_time_rounded,
      1 => Icons.check_circle_outline_rounded,
      2 => Icons.power_settings_new_rounded,
      _ => Icons.lightbulb_outline_rounded,
    };

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  FormGroup buildForm() => fb.group({
        'rolling': FormControl<int>(value: 2),
        'size': FormControl<int>(value: 2),
        'dual': FormControl<bool>(value: false),
        'custom': FormControl<bool>(value: false),
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
                    ReactiveAnimatedToggleSwitchRolling<int, int>(
                      formControlName: 'rolling',
                      values: const [0, 1, 2, 3],
                      iconBuilder: rollingIconBuilder,
                    ),
                    ReactiveCustomAnimatedToggleSwitch<bool, bool>(
                      formControlName: 'custom',
                      values: const [false, true],
                      spacing: 0.0,
                      indicatorSize: const Size.square(30.0),
                      animationDuration: const Duration(milliseconds: 200),
                      animationCurve: Curves.linear,
                      iconBuilder: (context, local, global) {
                        return const SizedBox();
                      },
                      cursors: const ToggleCursors(
                        defaultCursor: SystemMouseCursors.click,
                      ),
                      iconsTappable: false,
                      wrapperBuilder: (context, global, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              left: 10.0,
                              right: 10.0,
                              height: 20.0,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Color.lerp(
                                    Colors.black26,
                                    Theme.of(context).colorScheme.surface,
                                    global.position,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(50.0),
                                  ),
                                ),
                              ),
                            ),
                            child,
                          ],
                        );
                      },
                      foregroundIndicatorBuilder: (context, global) {
                        return SizedBox.fromSize(
                          size: global.indicatorSize,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Color.lerp(
                                Colors.white,
                                Theme.of(context).primaryColor,
                                global.position,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black38,
                                  spreadRadius: 0.05,
                                  blurRadius: 1.1,
                                  offset: Offset(0.0, 0.8),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    ReactiveAnimatedToggleSwitchSize<int, int>(
                      formControlName: 'size',
                      style: ToggleStyle(
                        backgroundColor: const Color(0xFF919191),
                        indicatorColor: const Color(0xFFEC3345),
                        borderColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(10.0),
                        indicatorBorderRadius: BorderRadius.zero,
                      ),
                      values: const [0, 1, 2],
                      iconOpacity: 1.0,
                      selectedIconScale: 1.0,
                      indicatorSize: const Size.fromWidth(100),
                      iconAnimationType: AnimationType.onHover,
                      styleAnimationType: AnimationType.onHover,
                      spacing: 2.0,
                      customSeparatorBuilder: (context, local, global) {
                        final opacity =
                            ((global.position - local.position).abs() - 0.5)
                                .clamp(0.0, 1.0);
                        return VerticalDivider(
                            indent: 10.0,
                            endIndent: 10.0,
                            color: Colors.white38
                                .withAlpha((opacity * 255).toInt()));
                      },
                      customIconBuilder: (context, local, global) {
                        final text =
                            const ['not', 'only', 'icons'][local.index];
                        return Center(
                            child: Text(text,
                                style: TextStyle(
                                    color: Color.lerp(Colors.black,
                                        Colors.white, local.animationValue))));
                      },
                      borderWidth: 0.0,
                    ),
                    ReactiveAnimatedToggleSwitchDual<bool, bool>(
                      formControlName: 'dual',
                      first: false,
                      second: true,
                      spacing: 50.0,
                      style: const ToggleStyle(
                        borderColor: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1.5),
                          ),
                        ],
                      ),
                      borderWidth: 5.0,
                      height: 55,
                      styleBuilder: (b) => ToggleStyle(
                          indicatorColor: b ? Colors.red : Colors.green),
                      iconBuilder: (value) => value
                          ? const Icon(Icons.coronavirus_rounded)
                          : const Icon(Icons.tag_faces_rounded),
                      textBuilder: (value) => value
                          ? const Center(child: Text('Oh no...'))
                          : const Center(child: Text('Nice :)')),
                    ),
                    ElevatedButton(
                      child: const Text('Submit'),
                      onPressed: () {
                        if (form.valid) {
                          debugPrint(form.value.toString());
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

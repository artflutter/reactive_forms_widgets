import 'package:flutter/material.dart';
import 'package:reactive_fancy_password_field/reactive_fancy_password_field.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  FormGroup buildForm() => fb.group({
        'input': FormControl<String>(),
      });

  int getStep(double strength) {
    if (strength == 0) {
      return 0;
    } else if (strength < .1) {
      return 1;
    } else if (strength < .2) {
      return 2;
    } else if (strength < .3) {
      return 3;
    } else if (strength < .4) {
      return 4;
    } else if (strength < .5) {
      return 5;
    } else if (strength < .6) {
      return 6;
    } else if (strength < .7) {
      return 7;
    }
    return 8;
  }

  Color? getColor(double strength) {
    if (strength == 0) {
      return Colors.grey[300];
    } else if (strength < .1) {
      return Colors.red;
    } else if (strength < .2) {
      return Colors.red;
    } else if (strength < .3) {
      return Colors.yellow;
    } else if (strength < .4) {
      return Colors.yellow;
    } else if (strength < .5) {
      return Colors.yellow;
    } else if (strength < .6) {
      return Colors.green;
    } else if (strength < .7) {
      return Colors.green;
    }
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
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
                    ReactiveFancyPasswordField<String>(
                      formControlName: 'input',
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                      ),
                      validationRules: {
                        UppercaseValidationRule(),
                        LowercaseValidationRule(),
                        DigitValidationRule(),
                        SpecialCharacterValidationRule(),
                        MinCharactersValidationRule(6),
                      },
                      strengthIndicatorBuilder: (strength) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: StepProgressIndicator(
                            totalSteps: 8,
                            currentStep: getStep(strength),
                            selectedColor: getColor(strength)!,
                            unselectedColor: Colors.grey[300]!,
                          ),
                        );
                      },
                      validationRuleBuilder: (rules, value) {
                        return Wrap(
                          runSpacing: 8,
                          spacing: 4,
                          children: rules.map(
                            (rule) {
                              final ruleValidated = rule.validate(value);
                              return Chip(
                                label: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (ruleValidated) ...[
                                      const Icon(
                                        Icons.check,
                                        color: Color(0xFF0A9471),
                                      ),
                                      const SizedBox(width: 8),
                                    ],
                                    Text(
                                      rule.name,
                                      style: TextStyle(
                                        color: ruleValidated
                                            ? const Color(0xFF0A9471)
                                            : const Color(0xFF9A9FAF),
                                      ),
                                    ),
                                  ],
                                ),
                                backgroundColor: ruleValidated
                                    ? const Color(0xFFD0F7ED)
                                    : const Color(0xFFF4F5F6),
                              );
                            },
                          ).toList(),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
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

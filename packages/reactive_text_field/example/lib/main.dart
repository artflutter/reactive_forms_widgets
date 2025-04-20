import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart' hide ReactiveTextField;
import 'package:reactive_text_field/reactive_text_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController? _controller;
  final FocusNode _focusNode = FocusNode();

  FormGroup buildForm() => fb.group({
        'input': FormControl<String>(value: 'some value'),
      });

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller?.selection = TextSelection(
          baseOffset: 0,
          extentOffset: _controller?.text.length ?? 0,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
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
                    ReactiveTextField<String>(
                      formControlName: 'input',
                      onControllerInit: (controller) {
                        _controller = controller;
                      },
                      focusNode: _focusNode,
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
                    ElevatedButton(
                      child: const Text('Select all text'),
                      onPressed: () {
                        if (_controller != null) {
                          form.control('input').focus();

                          _controller?.selection = TextSelection(
                            baseOffset: 0,
                            extentOffset: _controller?.text.length ?? 0,
                          );
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

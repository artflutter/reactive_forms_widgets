import 'package:flutter/material.dart';
import 'package:reactive_file_selector/reactive_file_selector.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  FormGroup buildForm() => fb.group({
        'input': FormControl<MultiFile<String>>(
            value: const MultiFile(),
            validators: [
              Validators.required,
              FileSelectorValidators.limit(min: 5, max: 10),
            ]),
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ReactiveFormBuilder(
              form: buildForm,
              builder: (context, form, child) {
                return Column(
                  children: [
                    Expanded(
                      child: ReactiveFileSelector<String>(
                        formControlName: 'input',
                        allowMultiple: true,
                        distinctPickedFiles: true,
                        filePickerBuilder: (pickImage, files, onChange) {
                          final items = [
                            ...files.files
                                .asMap()
                                .map((key, value) => MapEntry(
                                    key,
                                    ListTile(
                                      onTap: () {
                                        onChange(files.copyWith(
                                            files:
                                                List<String>.from(files.files)
                                                  ..removeAt(key)));
                                      },
                                      leading: const Icon(Icons.delete),
                                      title: FileListItem(value).build(context),
                                    )))
                                .values,
                            ...files.platformFiles
                                .asMap()
                                .map((key, value) => MapEntry(
                                      key,
                                      ListTile(
                                        onTap: () {
                                          onChange(files.copyWith(
                                              platformFiles: List<XFile>.from(
                                                  files.platformFiles)
                                                ..removeAt(key)));
                                        },
                                        leading: const Icon(Icons.delete),
                                        title: PlatformFileListItem(value)
                                            .build(context),
                                      ),
                                      // InkWell(
                                      //   onTap: () => onChange(images.copyWith(
                                      //       platformFiles: List<PlatformFile>.from(
                                      //           images.platformFiles)
                                      //         ..removeAt(key))),
                                      //   child: Icon(
                                      //     Icons.delete,
                                      //     color: Colors.white,
                                      //   ),
                                      // ),
                                    ))
                                .values,
                          ];

                          return Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: items.length,
                                  itemBuilder: (_, i) {
                                    return items[i];
                                  },
                                ),

                                // GridView.count(
                                //   crossAxisCount: 3,
                                //   children: List.generate(items.length, (index) {
                                //     return items[index];
                                //   }),
                                // ),
                              ),
                              ElevatedButton(
                                onPressed: pickImage,
                                child: const Text("Pick images"),
                              ),
                            ],
                          );
                        },
                        validationMessages: {
                          ValidationMessage.min: (error) {
                            if (error is! Map<String, Object?>) {
                              return ValidationMessage.min;
                            }
                            return "Should have at least ${error['min']} files, got: ${error['actual']}";
                          },
                          ValidationMessage.max: (error) {
                            if (error is! Map<String, Object?>) {
                              return ValidationMessage.max;
                            }
                            return "Should have at most ${error['max']} files, got: ${error['actual']}";
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Multi image picker',
                          border: OutlineInputBorder(),
                          helperText: '',
                        ),
                      ),
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

abstract class ListItem {
  Widget build(BuildContext context);
}

class FileListItem extends ListItem {
  final String url;

  FileListItem(this.url);

  @override
  Widget build(context) {
    return Text(url);
  }
}

class PlatformFileListItem extends ListItem {
  final XFile platformFile;

  PlatformFileListItem(this.platformFile);

  @override
  Widget build(context) {
    return Text(platformFile.name);
  }
}

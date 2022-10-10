import 'package:flutter/material.dart';
import 'package:reactive_file_picker/reactive_file_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  FormGroup buildForm() => fb.group({
        'multiImage': FormControl<MultiFile<String>>(
          value: const MultiFile<String>(
            files: [
              'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg'
            ],
            platformFiles: [],
          ),
        ),
      });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
                    Container(
                      constraints:
                          const BoxConstraints(minHeight: 0, maxHeight: 300),
                      child: ReactiveFilePicker<String>(
                        formControlName: 'multiImage',
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
                                              platformFiles:
                                                  List<PlatformFile>.from(
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
                        decoration: const InputDecoration(
                          labelText: 'Multi image picker',
                          border: OutlineInputBorder(),
                          helperText: '',
                        ),
                      ),
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
  final PlatformFile platformFile;

  PlatformFileListItem(this.platformFile);

  @override
  Widget build(context) {
    return Text(platformFile.path ?? '');
  }
}

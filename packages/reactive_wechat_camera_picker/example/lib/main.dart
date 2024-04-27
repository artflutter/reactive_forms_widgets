import 'package:flutter/material.dart';
import 'package:reactive_wechat_camera_picker/reactive_wechat_camera_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_wechat_camera_picker_example/selected_asset_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  FormGroup buildForm() => fb.group({
        'input': FormControl<AssetEntity>(value: null),
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
                    ReactiveWechatCameraPicker<AssetEntity>(
                      formControlName: 'input',
                      imagePickerBuilder: (pick, image, _) {
                        return Column(
                          children: [
                            if (image != null)
                              SelectedAssetView(
                                asset: image,
                                isDisplayingDetail: ValueNotifier(true),
                                onRemoveAsset: () {},
                              ),
                            ElevatedButton(
                              onPressed: pick,
                              child: const Text('Pick'),
                            ),
                          ],
                        );
                      },
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

import 'package:flutter/material.dart';
import 'package:reactive_wechat_assets_picker/reactive_wechat_assets_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_wechat_assets_picker_example/selected_assets_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FormGroup buildForm() => fb.group({
        'input': FormControl<List<AssetEntity>>(value: []),
      });

  Function(int index) remove(List<AssetEntity> assets) {
    return (int index) {
      assets.removeAt(index);
      // if (assets.isEmpty) {
      //   isDisplayingDetail.value = false;
      // }
      setState(() {});
    };
  }

  void onResult(List<AssetEntity>? assets) {
    if (mounted) {
      setState(() {});
    }
  }

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
                    ReactiveWechatAssetsPicker<List<AssetEntity>>(
                      formControlName: 'input',
                      imagePickerBuilder: (pick, images, _) {
                        return Column(
                          children: [
                            SelectedAssetsListView(
                              assets: images,
                              isDisplayingDetail: ValueNotifier(true),
                              onResult: onResult,
                              onRemoveAsset: remove(images),
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

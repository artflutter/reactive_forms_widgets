If you want to contribute it's now easier than ever.
You can use `mason` to create template for a new widget binding.

1. Install mason
```shell
# 🎯 Activate from https://pub.dev
dart pub global activate mason_cli
```

2. Chose the package you want to add on https://pub.dev
3. Generate a template project in `packages` folder

- move to `packages` folder
```shell
cd packages
```

- to get all bricks registered in mason.yaml run:
```shell
mason get
```

- generate template
```shell
mason make reactive_forms_widget_package
```
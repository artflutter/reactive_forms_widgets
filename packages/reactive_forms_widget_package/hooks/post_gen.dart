import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) async {
  final originalPackageName = context.vars['originalPackageName'];
  final package = 'reactive_${originalPackageName}';
  final packageExample = '$package/example';

  context.logger.info('############### CREATE $package ###############');
  await Process.run('flutter', [
    'create',
    package,
    '--template=package',
  ]).then((value) {
    print(value.stdout);
    print(value.stderr);
    print(value.exitCode);
  });

  context.logger
      .info('############### CREATE $package/example ###############');
  await Process.run('flutter', ['create', '.'],
          workingDirectory: packageExample)
      .then((value) {
    print(value.stdout);
    print(value.stderr);
    print(value.exitCode);
  });

  context.logger.info('############### RUN flutter pub get ###############');
  await Process.run('flutter', ['pub', 'get'], workingDirectory: package)
      .then((value) {
    print(value.stdout);
    print(value.stderr);
    print(value.exitCode);
  });
}

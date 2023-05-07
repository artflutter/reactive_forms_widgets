import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) async {
  final originalPackageName = context.vars['originalPackageName'];
  final reactivePackageName = 'reactive_${originalPackageName}';
  final reactivePackageDir = Directory(reactivePackageName);
  context.logger
      .info('############### CREATE $reactivePackageName ###############');
  await _runProcess(
    'flutter',
    [
      'create',
      reactivePackageName,
      '--template=package',
    ],
    workingDirectory: reactivePackageDir.parent.path,
  );

  context.logger.info(
      '############### CREATE $reactivePackageName/example ###############');
  await _runProcess(
    'flutter',
    ['create', 'example', '--template=app', '-e', '--no-pub'],
    workingDirectory: reactivePackageDir.path,
  );

  context.logger
      .info('############### ADD latest dependencies ###############');
  await _runProcess(
    'flutter',
    [
      'pub',
      'add',
      'reactive_forms',
      'dev:flutter_lints',
      originalPackageName,
    ],
    workingDirectory: reactivePackageDir.path,
  );
  await _runProcess(
    'flutter',
    [
      'pub',
      'add',
      'reactive_forms',
      '$reactivePackageName:{"path":"../"}',
    ],
    workingDirectory: Directory('${reactivePackageDir.path}/example').path,
  );
}

// Modified version from https://github.com/flutter/packages/blob/main/packages/go_router/tool/run_tests.dart#L33-L51
Future<Process> _streamOutput(Future<Process> processFuture) async {
  final Process process = await processFuture;
  stdout.addStream(process.stdout);
  stderr.addStream(process.stderr);
  return process;
}

Future<int> _runProcess(
  String command,
  List<String> arguments, {
  String? workingDirectory,
}) async {
  final Process process = await _streamOutput(Process.start(
    command,
    arguments,
    workingDirectory: workingDirectory,
    runInShell: true,
  ));
  final exitCode = await process.exitCode;
  if (exitCode != 0) {
    exit(exitCode);
  }
  return process.exitCode;
}

part of './grind.dart';

@Task('打包Android项目')
buildApk() async {
  await runAsync(
    'flutter',
    arguments: [
      'build',
      'apk',
      '--target-platform=android-arm64',
      '--dart-define',
      'BUILD_TYPE=PRODUCT',
    ],
  );
}

@Task('打包iOS项目')
buildIos() async {
  await runAsync(
    'flutter',
    arguments: [
      'build',
      'ios',
      '--dart-define',
      'BUILD_TYPE=PRODUCT',
    ],
  );
}

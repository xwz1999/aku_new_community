import 'dart:io';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:grinder/grinder.dart';
import 'package:path/path.dart' hide context;
import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

import 'config.dart';
import 'version_tool.dart';

part '_build.dart';

part '_project_manage.dart';

main(args) => grind(args);

@Task('add minor version number')
void addVersion() async {
  String projectPath = Directory('.').absolute.path;
  String yamlPath = join(projectPath, 'pubspec.yaml');
  String yamlContent = await File(yamlPath).readAsString();
  dynamic content = loadYaml(yamlContent);
  String version = content['version'];
  //rename version

  Version resultVersion = VersionTool.fromText(version).nextMinorTag('dev');

  String result = yamlContent.replaceFirst(version, resultVersion.toString());
  await File(yamlPath).writeAsString(result);
  stdout.write('version has been add 👍\n');
  await uploadVersion();
}

@Task('add path version number')
void addVersionPatch() async {
  String projectPath = Directory('.').absolute.path;
  String yamlPath = join(projectPath, 'pubspec.yaml');
  String yamlContent = await File(yamlPath).readAsString();
  dynamic content = loadYaml(yamlContent);
  String version = content['version'];
  //rename version

  Version resultVersion = VersionTool.fromText(version).nextPatchTag('dev');

  String result = yamlContent.replaceFirst(version, resultVersion.toString());
  await File(yamlPath).writeAsString(result);
  stdout.write('version has been add 👍\n');
  await uploadVersion();
}

@Task('add major version number')
void addVersionMajor() async {
  String projectPath = Directory('.').absolute.path;
  String yamlPath = join(projectPath, 'pubspec.yaml');
  String yamlContent = await File(yamlPath).readAsString();
  dynamic content = loadYaml(yamlContent);
  String version = content['version'];
  //rename version

  Version resultVersion = VersionTool.fromText(version).nextMajorTag('dev');

  String result = yamlContent.replaceFirst(version, resultVersion.toString());
  await File(yamlPath).writeAsString(result);
  stdout.write('version has been add 👍\n');
  await uploadVersion();
}

@Task()
Future<String> getVersion() async {
  String projectPath = Directory('.').absolute.path;
  String yamlPath = join(projectPath, 'pubspec.yaml');
  String yamlContent = await File(yamlPath).readAsString();
  dynamic content = loadYaml(yamlContent);
  String version = content['version'];
  return version;
}

@Task()
Future uploadVersion() async {
  TaskArgs args = context.invocation.arguments;
  bool force = args.getFlag('f');
  var version = await getVersion();
  List<String> spVersion = version.split('+');
  stdout.write('版本号：' + spVersion[0] + '\n');
  stdout.write('构建号：' + spVersion[1] + '\n');
  stdout.write('强制更新：' + force.toString() + '\n');
  var response =
      await Dio().post('http://121.41.26.225:8006/app/version/insert', data: {
    'versionNumber': spVersion[0],
    'buildNo': spVersion[1],
    'forceUpdate': force ? 1 : 2
  });
  stdout.write(response.data.toString());
}

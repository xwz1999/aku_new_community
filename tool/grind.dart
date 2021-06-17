import 'dart:io';
import 'package:common_utils/common_utils.dart';
import 'package:grinder/grinder.dart';
import 'package:path/path.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

import 'config.dart';
import 'version_tool.dart';

part '_build.dart';
part '_project_manage.dart';

main(args) => grind(args);

@Task('add version number')
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
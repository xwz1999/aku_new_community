part of 'grind.dart';

@Task('import 排序')
void sort() {
  Pub.run('import_sorter:main');
}

@Task('格式化dart代码')
void format() {
  DartFmt.format(libDir);
}

@Task('自动提交修改')
@Depends(sort, format, gitPush)
void git() {
  log(' commit to git');
  run(
    'git',
    arguments: [
      'commit',
      '-a',
      '-m',
      '[auto task] sort & format',
    ],
  );
}

@Task('推送代码')
void gitPush() {
  log(' push to git');
  run(
    'git',
    arguments: ['push'],
  );
}

@Task('build runner')
void gen() async {
  await runAsync(
    'fvm',
    arguments: [
      'flutter',
      'pub',
      'run',
      'build_runner',
      'build',
    ],
  );
}

@Task('build runner clean')
void genClean() async {
  await runAsync(
    'fvm',
    arguments: [
      'flutter',
      'pub',
      'run',
      'build_runner',
      'build',
      '--delete-conflicting-outputs'
    ],
  );
}

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
@Depends(sort, format)
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

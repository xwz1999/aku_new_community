class NEWAPI {
  ///HOST
  static const String host = 'http://127.0.0.1:8006';

  ///接口基础地址
  static const String baseURL = '$host';
  //根分类
  static _Questionnaire questionnaire = _Questionnaire();
}
class _Questionnaire {
  ///查询所有的问卷调查
  String get list => '/app/user/questionnaire/list';
  ///根据问卷主键id查询问卷详情
  String get detail => '/app/user/questionnaire/findById';
  ///问卷调查提交
  String get submit => '/app/user/questionnaire/submit';
}
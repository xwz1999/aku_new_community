enum GoodTag {
  jdSelfSupport(1, '京东自营'),
  jdPop(2, '京东POP');

  final typeNum;
  final typeStr;

  static GoodTag getValue(int value) =>
      GoodTag.values.firstWhere((element) => element.typeNum == value);

  const GoodTag(this.typeNum, this.typeStr);
}

extension intExt on int {
  String get toChinese {
    String nubStr = this.toString();
    if (nubStr.length > 2) {
      return '';
    } else if (nubStr.length > 1) {
      var p1 = _getNum(nubStr, 1);
      var p2 = _getNum(nubStr, 2);
      if (p2 == '零') {
        p2 = '';
      }
      if (p1 == '一') {
        p1 = '';
      }
      return p1 + '十' + p2;
    } else {
      return _getNum(nubStr, 1);
    }
  }

  //取得某位上的数字转换为中文
  String _getNum(String dig, int index) {
    List<String> _chinese = ['零', '一', '二', '三', '四', '五', '六', '七', '八', '九'];
    if (index > dig.length) {
      return '';
    } else {
      return _chinese[int.parse(dig[index - 1])];
    }
  }
}

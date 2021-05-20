

class LinkTextParase {
  static List<String> stringParase(String text, {Pattern? pattern}) {
    List<String> _listString = [];
    List<String> _urls = []; //匹配到的url存入这个数组
    //使用正则表达式匹配url，将字符串中url前后的部分分割存储为字符串列表
    Pattern _pattern = pattern ??
        RegExp(
            r"(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]"); //url的正则表达式
    _listString = text.split(_pattern);
    var _matches = _pattern.allMatches(text);
    for (var item in _matches) {
      _urls.add(item[0]!);
      print(item[0]);
    }
    //将url插入字符串数组
    for (var i = 0; i < _urls.length; i++) {
      _listString.insert(2 * i + 1, _urls[i]);
    }
    return _listString;
  }
}

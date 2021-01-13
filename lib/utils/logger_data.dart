class LoggerData {
  static int maxCount = 100;
  static List<dynamic> _data = [];
  static List<dynamic> get data => _data;

  static addData(dynamic item) {
    if (_data.length < maxCount)
      _data.insert(0, item);
    else {
      _data.removeLast();
      _data.insert(item, 0);
    }
  }
}

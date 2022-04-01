class ActivityFunc {
  static String dateCheck(DateTime? date) {
    if (date == null) {
      return '';
    }
    var nowDate = DateTime.now();
    if (date.isBefore(nowDate)) {
      return '已结束';
    } else {
      var days = date.difference(nowDate).inDays;
      if (days > 0) {
        return '${days}天后结束';
      } else {
        var hours = date.difference(nowDate).inHours;
        if (hours > 0) {
          return '${hours}小时后结束';
        } else {
          var mins = date.difference(nowDate).inMinutes;
          return '$mins分钟后结束';
        }
      }
    }
  }
}

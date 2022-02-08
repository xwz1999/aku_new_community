import 'package:common_utils/common_utils.dart';

class BeeDateUtil {
  DateTime? date;

  BeeDateUtil(this.date);

  DateTime get _now => DateTime.now();

  bool get sameYear => _now.year == this.date!.year;

  bool get sameMonth => sameYear && _now.month == this.date!.month;

  bool get sameDay => sameMonth && _now.day == this.date!.day;

  bool get isYesterday =>
      (DateTime(_now.year, _now.month, _now.day - 1).compareTo(
              DateTime(this.date!.year, this.date!.month, this.date!.day)) ==
          0);

  bool get isDoubleYesterday =>
      (DateTime(_now.year, _now.month, _now.day - 2).compareTo(
              DateTime(this.date!.year, this.date!.month, this.date!.day)) ==
          0);

  String get timeAgo {
    Duration duration = _now.difference(date!);
    if (duration.inSeconds <= 60) return '${duration.inSeconds}秒前';
    if (duration.inMinutes <= 60) return '${duration.inMinutes}分钟前';
    if (duration.inHours <= 12) return '${duration.inHours}小时前';
    if (isYesterday) return '昨天';
    if (isDoubleYesterday) return '前天';
    if (duration.inDays <= 30)
      return '${duration.inDays}天前';
    else
      return DateUtil.formatDate(date, format: 'yyyy-MM-dd');
  }

  String get timeAgoWithHm {
    Duration duration = _now.difference(date!);
    if (duration.inSeconds <= 60) return '${duration.inSeconds}秒前';
    if (duration.inMinutes <= 60) return '${duration.inMinutes}分钟前';
    if (duration.inHours <= 12) return '${duration.inHours}小时前';
    if (isYesterday) return '昨天';
    if (isDoubleYesterday) return '前天';
    if (duration.inDays <= 30)
      return '${duration.inDays}天前';
    else
      return DateUtil.formatDate(date, format: 'yyyy-MM-dd HH-mm');
  }
}

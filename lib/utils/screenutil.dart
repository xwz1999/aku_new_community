import 'package:flutter_screenutil/flutter_screenutil.dart';

class Screenutil {
  static double length(double lengthNum) => ScreenUtil().setWidth(lengthNum);

  static double size(double sizeNum) => ScreenUtil().setSp(sizeNum);
}

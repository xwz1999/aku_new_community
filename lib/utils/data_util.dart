import 'package:sp_util/sp_util.dart';

import 'constants.dart';

class DataUtil {
  static saveCurrentTimeMillis(int timeStart) async {
    await SpUtil.getInstance();
    SpUtil.putInt(Constants.timeStart, timeStart);
  }
}

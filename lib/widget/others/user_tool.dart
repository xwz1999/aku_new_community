import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:aku_community/provider/app_provider.dart';
import 'package:aku_community/provider/user_provider.dart';

class UserTool {
  static UserProvider get userProvider =>
      Provider.of<UserProvider>(Get.context!, listen: false);
  static AppProvider get appProveider =>
      Provider.of<AppProvider>(Get.context!, listen: false);
}

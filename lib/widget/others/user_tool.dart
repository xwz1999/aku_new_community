import 'package:aku_new_community/provider/app_provider.dart';
import 'package:aku_new_community/provider/data_provider.dart';
import 'package:aku_new_community/provider/user_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class UserTool {
  static UserProvider get userProvider =>
      Provider.of<UserProvider>(Get.context!, listen: false);

  static AppProvider get appProvider =>
      Provider.of<AppProvider>(Get.context!, listen: false);
  static DataProvider get dataProvider =>
      Provider.of<DataProvider>(Get.context!, listen: false);
  UserTool();
}

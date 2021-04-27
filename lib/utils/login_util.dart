import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:aku_community/pages/sign/sign_in_page.dart';
import 'package:aku_community/provider/app_provider.dart';
import 'package:aku_community/provider/user_provider.dart';
import 'package:aku_community/ui/profile/house/add_house_page.dart';
import 'package:aku_community/ui/profile/house/house_owners_page.dart';

/// | 名称 | 函数 |
/// |-----|------|
/// | 验证登录（登录状态）| LoginnUtil.isLogin |
/// | 验证登录(未登陆状态) | LoginnUtil.isNotLogin |
class LoginUtil {
  /// 验证登录（登录状态）
  ///
  /// 未登陆状态用户跳转到登录页面
  static bool get isLogin {
    final userProvider = Provider.of<UserProvider>(Get.context, listen: false);
    if (userProvider.isNotLogin) {
      BotToast.showText(text: '请先登录');
      Get.to(() => SignInPage());
      return false;
    }
    return true;
  }

  /// 验证登录(未登陆状态)
  ///
  /// 未登陆状态用户跳转到登录页面
  static bool get isNotLogin => !isLogin;

  static bool haveRoom(String name) {
    if (!name.contains(RegExp('访客邀请|报事报修|建议咨询|生活缴费|物品出门|投诉表扬|我的访客|我的报修|我的缴费')))
      return true;
    final appProvider = Provider.of<AppProvider>(Get.context, listen: false);
    if (appProvider.selectedHouse == null) {
      BotToast.showText(text: '请先添加房屋');
      Get.to(() => AddHousePage());
      return false;
    }
    if (appProvider.selectedHouse.status != 4) {
      BotToast.showText(text: '房屋审核中或审核失败');
      Get.to(() => HouseOwnersPage());
      return false;
    }
    return true;
  }
}

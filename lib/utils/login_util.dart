import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:akuCommunity/pages/sign/sign_in_page.dart';
import 'package:akuCommunity/provider/user_provider.dart';

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
      Get.to(SignInPage());
      return false;
    }
    return true;
  }

  /// 验证登录(未登陆状态)
  ///
  /// 未登陆状态用户跳转到登录页面
  static bool get isNotLogin => !isLogin;
}

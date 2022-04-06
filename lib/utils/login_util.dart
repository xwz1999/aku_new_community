import 'package:aku_new_community/pages/sign/login/other_login_page.dart';
import 'package:aku_new_community/provider/user_provider.dart';
import 'package:aku_new_community/ui/profile/new_house/my_house_page.dart';
import 'package:aku_new_community/widget/dialog/certification_dialog.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

/// | 名称 | 函数 |
/// |-----|------|
/// | 验证登录（登录状态）| LoginnUtil.isLogin |
/// | 验证登录(未登陆状态) | LoginnUtil.isNotLogin |
class LoginUtil {
  /// 验证登录（登录状态）
  ///
  /// 未登陆状态用户跳转到登录页面
  static bool get isLogin {
    final userProvider = Provider.of<UserProvider>(Get.context!, listen: false);
    if (userProvider.isNotLogin) {
      BotToast.showText(text: '请先登录');
      //暂时隐去一键登录页
      Get.to(() => OtherLoginPage());
      return false;
    }
    return true;
  }

  /// 验证登录(未登陆状态)
  ///
  /// 未登陆状态用户跳转到登录页面
  static bool get isNotLogin => !isLogin;

  static bool haveRealName(String name) {
    // if (!name.contains(RegExp('访客邀请|报事报修|建议咨询|生活缴费|物品出门|投诉表扬|我的访客|我的报修|我的缴费')))
    //   return true;
    final userProvider = Provider.of<UserProvider>(Get.context!, listen: false);
    if (userProvider.userInfoModel!.name == null) {
      Get.dialog(CertificationDialog());
      return false;
    }
    return true;
  }

  static bool haveRoom(String name) {
    // if (!name.contains(RegExp('访客邀请|报事报修|建议咨询|生活缴费|物品出门|投诉表扬|我的访客|我的报修|我的缴费')))
    //   return true;
    final userProvider = Provider.of<UserProvider>(Get.context!, listen: false);
    if (userProvider.defaultHouse == null) {
      BotToast.showText(text: '请先选择默认房屋');
      Get.to(() => MyHousePage());
      return false;
    }
    return true;
  }
}

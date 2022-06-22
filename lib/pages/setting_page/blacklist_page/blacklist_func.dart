import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/model/user/blacklist_model.dart';
import 'package:aku_new_community/utils/network/base_list_model.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';

class BlackListFunc {
  ///获取黑名单列表
  static Future<List<BlacklistModel>> getBlackList() async {
    BaseListModel model = await NetUtil().getList(
      SAASAPI.user.blackList,
      params: {
        'pageNum': 1,
        'size': 9,
      },
    );
    if (model.rows.length == 0) return [];
    return model.rows.map((e) => BlacklistModel.fromJson(e)).toList();
  }

  ///取消拉黑用户
  static Future<bool> cancelBlock(int userId) async {
    var base = await NetUtil().get(SAASAPI.user.cancelBlock,
        params: {
          'userId': userId,
        },
        showMessage: true);
    return base.success;
  }

  ///拉黑用户
  static Future<bool> Block(int userId) async {
    var base = await NetUtil().get(SAASAPI.user.Block,
        params: {
          'userId': userId,
        },
        showMessage: true);
    return base.success;
  }
}

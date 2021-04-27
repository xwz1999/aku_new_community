import 'package:aku_community/constants/api.dart';
import 'package:aku_community/model/community/activity_item_model.dart';
import 'package:aku_community/model/community/board_model.dart';
import 'package:aku_community/utils/network/base_list_model.dart';
import 'package:aku_community/utils/network/net_util.dart';

class CommunityFunc {
  static Future<ActivityItemModel> activity() async {
    BaseListModel model = await NetUtil().getList(
      API.community.activityList,
      params: {'pageNum': 1, 'size': 1},
    );
    if (model.tableList.length == 0) return null;
    return ActivityItemModel.fromJson(model.tableList.first);
  }

  static Future<List<BoardItemModel>> board() async {
    BaseListModel model = await NetUtil().getList(
      API.community.boardList,
      params: {'pageNum': 1, 'size': 5},
    );
    if (model.tableList.length == 0) return [];
    return model.tableList.map((e) => BoardItemModel.fromJson(e)).toList();
  }
}

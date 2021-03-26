import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/user/house_model.dart';
import 'package:akuCommunity/utils/network/base_model.dart';
import 'package:akuCommunity/utils/network/net_util.dart';

class HouseFunc {
  static Future<List<HouseModel>> get houses async {
    BaseModel model = await NetUtil().get(API.user.houseList);
    if (!model.status) return [];
    return (model.data as List).map((e) => HouseModel.fromJson(e)).toList();
  }
}

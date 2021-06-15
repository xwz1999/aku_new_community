import 'package:aku_community/constants/api.dart';
import 'package:aku_community/model/user/house_model.dart';
import 'package:aku_community/models/user/passed_house_list_model.dart';
import 'package:aku_community/utils/network/base_model.dart';
import 'package:aku_community/utils/network/net_util.dart';

class HouseFunc {
  ///查询所有的房屋审核信息
  static Future<List<HouseModel>> get examineHouses async {
    BaseModel model = await NetUtil().get(API.user.examineHouseList);
    if (!model.status!) return [];
    return (model.data as List).map((e) => HouseModel.fromJson(e)).toList();
  }

  ///查询用户所拥有的房屋信息
  static Future<List<PassedHouseListModel>> get passedHouses async{
      BaseModel model = await NetUtil().get(API.user.passedHouseList);
    if (!model.status!) return [];
    return (model.data as List).map((e) => PassedHouseListModel.fromJson(e)).toList();
  }
  }

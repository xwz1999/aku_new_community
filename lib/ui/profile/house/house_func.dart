import 'dart:io';

import 'package:aku_community/constants/api.dart';
import 'package:aku_community/model/user/house_model.dart';
import 'package:aku_community/models/house/lease_detail_model.dart';
import 'package:aku_community/models/house/lease_echo_model.dart';
import 'package:aku_community/models/house/submit_model.dart';
import 'package:aku_community/models/user/passed_house_list_model.dart';
import 'package:aku_community/utils/network/base_file_model.dart';
import 'package:aku_community/utils/network/base_model.dart';
import 'package:aku_community/utils/network/net_util.dart';
import 'package:bot_toast/bot_toast.dart';

class HouseFunc {
  ///查询所有的房屋审核信息
  static Future<List<HouseModel>> get examineHouses async {
    BaseModel model = await NetUtil().get(API.user.examineHouseList);
    if (!model.status!) return [];
    return (model.data as List).map((e) => HouseModel.fromJson(e)).toList();
  }

  ///查询用户所拥有的房屋信息
  static Future<List<PassedHouseListModel>> get passedHouses async {
    BaseModel model = await NetUtil().get(API.user.passedHouseList);
    if (!model.status!) return [];
    return (model.data as List)
        .map((e) => PassedHouseListModel.fromJson(e))
        .toList();
  }

  ///我的房屋 租赁认证
  Future leaseCertification(
    String name,
    String sex,
    String tel,
    String idNumber,
  ) async {
    BaseModel baseModel =
        await NetUtil().post(API.house.leaseCertification, params: {
      "name": name,
      "sex": getSex[sex],
      "tel": tel,
      "idNumber": idNumber,
    });
    if (baseModel.status ?? false) {
      BotToast.showText(text: '提交成功');
      return true;
    }
    return false;
  }

  ///租赁认证信息回显
  static Future leaseEcho() async {
    BaseModel baseModel = await NetUtil().get(API.house.leaseEcho);
    if (baseModel.status ?? false) {
      return LeaseEchoModel.fromJson(baseModel.data);
    } else {
      return LeaseEchoModel.fail();
    }
  }

  ///获得租赁详情信息
  Future<LeaseDetailModel?> leaseDetail(int leaseId) async {
    BaseModel baseModel = await NetUtil().get(API.house.leaseFindByld, params: {
      "leaseId": leaseId,
    });
    if (baseModel.status ?? false) {
      return LeaseDetailModel.fromJson(baseModel.data);
    } else {
      return null;
    }
  }

  ///上传身份证照片正面
  Future<String> uploadIdCardFront(File file) async {
    BaseFileModel baseFileModel =
        await NetUtil().upload(API.upload.uploadCardFront, file);
    if (baseFileModel.status ?? false) {
      return baseFileModel.url!;
    } else {
      return '';
    }
  }

  ///上传身份证照片背面
  Future<String> uploadIdCardBack(File file) async {
    BaseFileModel baseFileModel =
        await NetUtil().upload(API.upload.uploadCardBack, file);
    if (baseFileModel.status ?? false) {
      return baseFileModel.url!;
    } else {
      return '';
    }
  }

  ///提交个人租赁信息
  Future<String> submitLeaseInfo(SubmitModel model) async {
    BaseModel baseModel =
        await NetUtil().get(API.house.submitLeaseInfo, params: {
      "id": model.id,
      "emergencyContact": model.emergencyContact,
      "emergencyContactNumber": model.emergencyContactNumber,
      "correspondenceAddress": model.correspondenceAddress,
      "workUnits": model.workUnits,
      "payBank": model.payBank,
      "bankAccountName": model.bankAccountName,
      "bankAccount": model.bankAccount,
      "idCardFrontImgUrl": model.idCardFrontImgUrl,
      "idCardBackImgUrl": model.idCardBackImgUrl,
    });
    if (baseModel.status ?? false) {
      return baseModel.data;
    } else {
      return '';
    }
  }

  ///上传合同签名
  Future<String> uploadSignName(File file) async {
    BaseFileModel baseFileModel =
        await NetUtil().upload(API.upload.uploadSignName, file);
    if (baseFileModel.status ?? false) {
      return baseFileModel.url!;
    } else {
      return '';
    }
  }

  static Map<String, int> getSex = {
    '男': 1,
    '女': 2,
  };

  static Map<int, String> toSex = {
    1: '男',
    2: '女',
  };

  static Map<int, String> toType = {1: '一类人才', 2: '二类人才', 3: '三类人才'};
}

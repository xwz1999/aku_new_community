import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/constants/sars_api.dart';
import 'package:aku_new_community/utils/network/net_util.dart';

class TaskFunc {
  ///确认发布
  static Future<bool> publish(
      {required String title,
      required int taskType,
      required int taskSex,
      required int serviceObject,
      required String taskContent,
      required String taskDate,
      required String taskAddress,
      required int rewardType,
      required String reward}) async {
    var base = await NetUtil().post(API.manager.task.publish, params: {
      'title': title,
      'taskType': taskType,
      'taskSex': taskSex,
      'serviceObject': serviceObject,
      'taskContent': taskContent,
      'taskDate': taskDate,
      'taskAddress': taskAddress,
      'rewardType': rewardType,
      'reward': int.parse(reward),
    });
    return base.success;
  }

  ///取消任务
  static Future<bool> cancel({
    required int taskId,
  }) async {
    var base = await NetUtil().get(SARSAPI.task.cancel, params: {
      'taskId': taskId,
    });
    return base.success;
  }

  ///接取任务

  static Future<bool> take({
    required int taskId,
  }) async {
    var base = await NetUtil().get(SARSAPI.task.receive,
        params: {
          'taskId': taskId,
        },
        showMessage: true);
    return base.success;
  }

  ///完成任务

  static Future<bool> finish({
    required int taskId,
  }) async {
    var base = await NetUtil().get(SARSAPI.task.finish, params: {
      'taskId': taskId,
    });
    return base.success;
  }

  /// 确认任务
  static Future<bool> confirm({
    required int taskId,
  }) async {
    var base = await NetUtil().get(SARSAPI.task.confirm, params: {
      'taskId': taskId,
    });
    return base.success;
  }

  ///开始服务
  static Future<bool> start({
    required int taskId,
  }) async {
    var base = await NetUtil().get(SARSAPI.task.startService, params: {
      'taskId': taskId,
    });
    return base.success;
  }

  ///任务评价
  static Future<bool> evaluate({
    required int taskId,
    required int star,
    required String evaluation,
  }) async {
    var base = await NetUtil().get(SARSAPI.task.evaluation,
        params: {'taskId': taskId, 'star': star, 'evaluation': evaluation});
    return base.success;
  }
}

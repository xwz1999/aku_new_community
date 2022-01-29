import 'package:aku_new_community/constants/api.dart';
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
    return base.status ?? false;
  }

  ///取消任务
  static Future<bool> cancel({
    required int taskId,
  }) async {
    var base = await NetUtil().post(API.manager.task.cancel, params: {
      'taskId': taskId,
    });
    return base.status ?? false;
  }

  ///接取任务

  static Future<bool> take({
    required int taskId,
  }) async {
    var base = await NetUtil().post(API.manager.task.take, params: {
      'taskId': taskId,
    });
    return base.status ?? false;
  }

  ///完成任务

  static Future<bool> finish({
    required int taskId,
  }) async {
    var base = await NetUtil().post(API.manager.task.finish, params: {
      'taskId': taskId,
    });
    return base.status ?? false;
  }
}

import 'package:akuCommunity/constants/api.dart';
import 'package:akuCommunity/model/user/user_detail_model.dart';
import 'package:akuCommunity/model/user/user_info_model.dart';
import 'package:akuCommunity/pages/sign/sign_func.dart';
import 'package:akuCommunity/utils/hive_store.dart';
import 'package:akuCommunity/utils/network/base_model.dart';
import 'package:akuCommunity/utils/network/net_util.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  //登录状态管理
  bool _isSigned = false;
  get isSigned => _isSigned;
  setisSigned(bool state) {
    _isSigned = state;
    notifyListeners();
  }

  bool _isLogin = false;
  bool get isLogin => _isLogin;
  Future setLogin(int token) async {
    _isLogin = true;
    NetUtil().dio.options.headers.putIfAbsent('App-Admin-Token', () => token);
    HiveStore.appBox.put('token', token);
    HiveStore.appBox.put('login', true);
    await updateProfile();
    await updateUserDetail();
    notifyListeners();
  }

  logout() {
    _isLogin = false;
    _token = null;
    _userInfoModel = null;
    _userDetailModel = null;
    NetUtil().get(API.user.logout, showMessage: true);
    NetUtil().dio.options.headers.remove('App-Admin-Token');
    HiveStore.appBox.delete('token');
    HiveStore.appBox.delete('login');
    notifyListeners();
  }

  Future updateProfile() async {
    _userInfoModel = await SignFunc.getUserInfo();
    notifyListeners();
  }

  Future updateUserDetail() async {
    _userDetailModel = await SignFunc.getUserDetail();
    notifyListeners();
  }

  String _token;
  String get token => _token ?? '';

  UserInfoModel _userInfoModel;
  UserInfoModel get userInfoModel => _userInfoModel;

  UserDetailModel _userDetailModel;
  UserDetailModel get userDetailModel => _userDetailModel;

  ///设置性别
  Future setSex(int sex) async {
    BaseModel baseModel = await NetUtil().post(
      API.user.setSex,
      params: {'sex': sex},
      showMessage: true,
    );
    if (baseModel.status) {
      _userInfoModel.sex = sex;
      notifyListeners();
    }
  }

  ///设置生日
  Future setBirthday(DateTime date) async {
    BaseModel baseModel = await NetUtil().post(
      API.user.setBirthday,
      params: {'birthday': DateUtil.formatDate(date,format: "yyyy-MM-dd HH:mm:ss")},
      showMessage: true,
    );
    if (baseModel.status) {
      _userInfoModel.birthday = DateUtil.formatDate(date,format: "yyyy-MM-dd HH:mm:ss");
      notifyListeners();
    }
  }

  //修改昵称
  Future setName(String name) async {
    BaseModel baseModel = await NetUtil().post(
      API.user.updateNickName,
      params: {'nickName': name},
      showMessage: true,
    );
    if (baseModel.status) {
      _userInfoModel.nickName = name;
      notifyListeners();
    }
  }

  //修改手机号
  Future updateTel(String oldTel, String newTel, String code) async {
    BaseModel baseModel = await NetUtil().post(
      API.user.updateTel,
      params: {'oldTel': oldTel, 'newTel': newTel, 'code': code},
      showMessage: true,
    );
    if (baseModel.status) {
      _userInfoModel.tel = newTel;
      notifyListeners();
    }
  }
}

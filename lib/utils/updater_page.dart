import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:dio/dio.dart';
import 'package:sp_util/sp_util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constants.dart';
import 'data_util.dart';

class UpdaterPage extends StatefulWidget {
  final Widget child;

  const UpdaterPage(this.child);

  @override
  UpdatePagerState createState() => UpdatePagerState();
}

class UpdatePagerState extends State<UpdaterPage> {
  var _serviceVersionCode,
      _serviceVersionName,
      _serviceVersionPlatform,
      _serviceVersionApp;

  @override
  void initState() {
    super.initState();
    //每次打开APP获取当前时间戳
    var timeEnd = DateTime.now().millisecondsSinceEpoch;
    _getNewVersionAPP();
    //获取"Later"保存的时间戳
    var timeStart = SpUtil.getInt(Constants.timeStart);
    if (timeStart == 0) {
      //第一次打开APP时执行"版本更新"的网络请求
      _getNewVersionAPP();
    } else if (timeStart != 0 && timeEnd - timeStart! >= 24 * 60 * 60 * 1000) {
      //如果新旧时间戳的差大于或等于一天，执行网络请求
      _getNewVersionAPP();
    }

  }

  //执行版本更新的网络请求
  _getNewVersionAPP() async {
    String url = "/appversions/latest"; //接口的URL，替换你的URL
    try {
      Response response = await Dio().get(url);
      setState(() {
        var data = response.data;
        _serviceVersionCode = data["versionCode"].toString(); //版本号
        _serviceVersionName = data["versionName"].toString(); //版本名称
        _serviceVersionPlatform = data["versionPlatform"].toString(); //版本平台
        _serviceVersionApp = data["versionApp"].toString(); //下载的URL
        _checkVersionCode();
      });
    } catch (e) {
      print(e);
    }
    _checkVersionCode();
  }

  //检查版本更新的版本号
  _checkVersionCode() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String _currentVersionCode = packageInfo.version;
    print('版本——————————————————————'+ '${_currentVersionCode}');
    int serviceVersionCode = int.parse(_serviceVersionCode);
    print(serviceVersionCode);
    int currentVersionCode = int.parse(_currentVersionCode);
    print(currentVersionCode);
    if (serviceVersionCode > currentVersionCode) {
      _showNewVersionAppDialog(); //弹出对话框
    }
  }

  //弹出"版本更新"对话框
  Future<void> _showNewVersionAppDialog() async {
    print('弹出框');
    if (_serviceVersionPlatform == "android") {
      return showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                children: <Widget>[
                  Image.asset("images/ic_launcher_icon.png",
                      height: 35.0, width: 35.0),
                  Padding(
                      padding: EdgeInsets.fromLTRB(30.0, 0.0, 10.0, 0.0),
                      child: Text('项目名称',
                          style: TextStyle(
                              color: Color(0xFF384F6F), fontSize: 20.0),),)
                ],
              ),
              content: Text('提示的内容',
                  style: TextStyle(
                      color: Color(0xFF384F6F), fontSize: 18.0),),
              actions: [
                OutlinedButton(
                  child: new Text('稍后再说',
                      style: TextStyle(
                          color: Color(0xFF384F6F), fontSize: 20.0),),
                  onPressed: () {
                    Navigator.of(context).pop();
                    var timeStart = DateTime.now().millisecondsSinceEpoch;
                    DataUtil.saveCurrentTimeMillis(timeStart); //保存当前的时间戳
                  },
                ),
                OutlinedButton(
                  child: new Text('下载',
                      style: TextStyle(
                          color: Color(0xFF384F6F), fontSize: 20.0)),
                  onPressed: () {
                    //https://play.google.com/store/apps/details?id=项目包名
                    launch(_serviceVersionApp); //到Google Play 官网下载
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    } else {
      //iOS
      return showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title:Row(
                children: <Widget>[
                  Image.asset("images/ic_launcher_icon.png",
                      height: 35.0, width: 35.0),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 0.0, 10.0, 0.0),
                    child: Text('项目名称',
                      style: TextStyle(
                          color: Color(0xFF384F6F), fontSize: 20.0),),)
                ],
              ),
              content: Text('提示的内容',
                style: TextStyle(
                    color: Color(0xFF384F6F), fontSize: 18.0),),

              actions: [
                OutlinedButton(
                  child: new Text('稍后再说',
                    style: TextStyle(
                        color: Color(0xFF384F6F), fontSize: 20.0),),
                  onPressed: () {
                    Navigator.of(context).pop();
                    var timeStart = DateTime.now().millisecondsSinceEpoch;
                    DataUtil.saveCurrentTimeMillis(timeStart); //保存当前的时间戳
                  },
                ),
                OutlinedButton(
                  child: new Text('下载',
                      style: TextStyle(
                          color: Color(0xFF384F6F), fontSize: 20.0)),
                  onPressed: () {
                    //https://play.google.com/store/apps/details?id=项目包名
                    launch(_serviceVersionApp); //到Google Play 官网下载
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

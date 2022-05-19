import 'package:flutter/material.dart';

class OldAgeProvider extends ChangeNotifier {
  String _imei='';

  String get imei => _imei;

  void changeImei(String value) {
    _imei = value;
    notifyListeners();
  }
}

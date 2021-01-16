import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  int _estateId;
  int get estateId => _estateId;
  int _type = 1;
  int get type => _type;
  String _nickName;
  String get nickName => _nickName;
  String _name;
  String get name => _name;
  String _tel;
  String get tel => _tel;
  int _idType;
  int get idType => _idType;
  String _idNumber;
  String get idNumber => _idNumber;

  setEstateId(int id) {
    _estateId = id;
    notifyListeners();
  }

  setType(int type) {
    _type = type;
    notifyListeners();
  }

  setName(String name) {
    _name = name;
    notifyListeners();
  }

  setTel(String tel) {
    _tel = tel;
    notifyListeners();
  }

  setidType(int idType) {
    _idType = idType;
    notifyListeners();
  }

  setIdNumber(String idNumber) {
    _idNumber = idNumber;
    notifyListeners();
  }

  clearAll() {
    _estateId = null;
    _type = 1;
    _nickName = null;
    _name = null;
    _tel = null;
    _idType = null;
    _idNumber = null;
    notifyListeners();
  }
}

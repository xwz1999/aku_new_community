import 'package:aku_new_community/models/bracelet/bracelet_list_model.dart';
import 'package:flutter/material.dart';

class OldAgeProvider extends ChangeNotifier {
  BraceletListModel? _bracelet;

  BraceletListModel? get bracelet => _bracelet ;

  void changeImei(BraceletListModel value) {
    _bracelet = value;
    notifyListeners();
  }
}

import 'package:aku_new_community/models/login/china_region_model.dart';
import 'package:aku_new_community/models/login/picked_city_model.dart';
import 'package:aku_new_community/utils/hive_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bee_picker_box.dart';

class BeeCityPicker extends StatefulWidget {
  static Future<PickedCityModel?> pick(BuildContext context) async {
    return await showModalBottomSheet(
      context: context,
      builder: (context) {
        return BeeCityPicker();
      },
    );
  }

  BeeCityPicker({Key? key}) : super(key: key);

  @override
  _BeeCityPickerState createState() => _BeeCityPickerState();
}

class _BeeCityPickerState extends State<BeeCityPicker> {
  List<ChinaRegionModel> get provinces =>
      HiveStore.chinaRegionBox!.values.cast<ChinaRegionModel>().toList();

  late int _pickedProvinceIndex;
  late int _pickedCityIndex;
  late int _pickedDistrictIndex;

  ChinaRegionModel get _pickedProvince => provinces[_pickedProvinceIndex];

  ChinaRegionModel get _pickedCity => cities[_pickedCityIndex];

  ChinaRegionModel get _pickedDistrict => districts.isEmpty
      ? ChinaRegionModel.empty(_pickedCity.id)
      : districts[_pickedDistrictIndex];

  List<ChinaRegionModel> get cities => _pickedProvince.cityList;

  List<ChinaRegionModel> get districts => _pickedCity.cityList;

  final FixedExtentScrollController _cityController =
      FixedExtentScrollController();
  final FixedExtentScrollController _districtController =
      FixedExtentScrollController();
  late PickedCityModel _pickedCityModel;

  void updatePickedCity() {
    pickCity();
    setState(() {});
  }

  void pickCity() {
    _pickedCityModel = PickedCityModel(
      province: _pickedProvince,
      city: _pickedCity,
      district: _pickedDistrict,
    );
  }

  @override
  void initState() {
    super.initState();
    _pickedProvinceIndex = 0;
    _pickedCityIndex = 0;
    _pickedDistrictIndex = 0;
    pickCity();
  }

  @override
  void dispose() {
    _cityController.dispose();
    _districtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeePickerBox(
      onPressed: () {
        Navigator.pop(context, _pickedCityModel);
      },
      child: Row(
        children: [
          Expanded(
            child: CupertinoPicker(
              itemExtent: 40.w,
              magnification: 1.1,
              offAxisFraction: -0.6,
              looping: true,
              onSelectedItemChanged: (index) {
                _pickedProvinceIndex = index;
                _cityController.jumpToItem(0);
                _districtController.jumpToItem(0);
                updatePickedCity();
              },
              children: provinces
                  .map((e) => Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 24.w, right: 8.w),
                          child: Text(e.name, textAlign: TextAlign.center),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Expanded(
            child: CupertinoPicker(
              itemExtent: 40.w,
              magnification: 1.1,
              looping: true,
              scrollController: _cityController,
              onSelectedItemChanged: (index) {
                _pickedCityIndex = index;
                _districtController.jumpToItem(0);
                updatePickedCity();
              },
              children: cities
                  .map((e) => Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: Text(e.name, textAlign: TextAlign.center),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Expanded(
            child: CupertinoPicker(
              itemExtent: 40.w,
              magnification: 1.1,
              offAxisFraction: 0.6,
              looping: true,
              scrollController: _districtController,
              onSelectedItemChanged: (index) {
                _pickedDistrictIndex = index;
                updatePickedCity();
              },
              children: districts.isEmpty
                  ? [Container()]
                  : districts
                      .map((e) => Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 4.w, right: 20.w),
                              child: Text(e.name, textAlign: TextAlign.center),
                            ),
                          ))
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

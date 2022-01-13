import 'package:aku_new_community/models/sars_model/my_house/estate_cascade_model.dart';
import 'package:aku_new_community/models/sars_model/my_house/picked_house.dart';
import 'package:aku_new_community/widget/picker/bee_picker_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BeeHouseCascadePicker extends StatefulWidget {
  final List<EstateCascadeModel> buildings;
  static Future<PickedHouseModel> pick(
      BuildContext context, List<EstateCascadeModel> buildings) async {
    var result = await showModalBottomSheet(
        context: context,
        builder: (context) {
          return BeeHouseCascadePicker(buildings: buildings);
        });
    return result;
  }

  const BeeHouseCascadePicker({Key? key, required this.buildings})
      : super(key: key);

  @override
  _BeeHouseCascadePickerState createState() => _BeeHouseCascadePickerState();
}

class _BeeHouseCascadePickerState extends State<BeeHouseCascadePicker> {
  List<EstateCascadeModel> _buildings = [];
  int _pickBuildingIndex = 0;

  EstateCascadeModel get _pickedBuilding => _buildings[_pickBuildingIndex];
  int _pickUnitIndex = 0;

  Unit get _pickedUnit => _pickedBuilding.childList[_pickUnitIndex];

  Floor get _pickedFloor => _pickedUnit.floors[_pickFloorIndex];
  int _pickFloorIndex = 0;

  House get _pickedHouse => _pickedFloor.houses[_pickHouseIndex];
  int _pickHouseIndex = 0;

  PickedHouseModel get pickedHouseModel => PickedHouseModel(
        building: _pickedBuilding,
        unit: _pickedUnit,
        floor: _pickedFloor,
        house: _pickedHouse,
      );
  FixedExtentScrollController _unitController = FixedExtentScrollController();
  FixedExtentScrollController _floorController = FixedExtentScrollController();
  FixedExtentScrollController _houseController = FixedExtentScrollController();

  @override
  void initState() {
    _buildings = widget.buildings;
    super.initState();
  }

  @override
  void dispose() {
    _unitController.dispose();
    _floorController.dispose();
    _houseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeePickerBox(
        onPressed: () {
          Get.back(result: pickedHouseModel);
        },
        child: Row(
          children: [
            Flexible(
              child: CupertinoPicker(
                onSelectedItemChanged: (int value) {
                  _pickBuildingIndex = value;
                  _unitController.jumpToItem(0);
                  _floorController.jumpToItem(0);
                  _houseController.jumpToItem(0);
                  setState(() {});
                },
                itemExtent: 80.w,
                children: _buildings
                    .map((e) => Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            child: Text(e.name, textAlign: TextAlign.center),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Flexible(
              child: CupertinoPicker(
                onSelectedItemChanged: (int value) {
                  _pickUnitIndex = value;
                  _floorController.jumpToItem(0);
                  _houseController.jumpToItem(0);
                  setState(() {});
                },
                itemExtent: 80.w,
                children: _pickedBuilding.childList
                    .map((e) => Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            child: Text(e.name, textAlign: TextAlign.center),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Flexible(
              child: CupertinoPicker(
                onSelectedItemChanged: (int value) {
                  _pickFloorIndex = value;
                  _houseController.jumpToItem(0);
                  setState(() {});
                },
                itemExtent: 80.w,
                children: _pickedUnit.floors
                    .map((e) => Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            child: Text(e.name, textAlign: TextAlign.center),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Flexible(
              child: CupertinoPicker(
                onSelectedItemChanged: (int value) {
                  _pickHouseIndex = value;
                  setState(() {});
                },
                itemExtent: 80.w,
                children: _pickedFloor.houses
                    .map((e) => Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            child: Text(e.name, textAlign: TextAlign.center),
                          ),
                        ))
                    .toList(),
              ),
            )
          ],
        ));
  }
}

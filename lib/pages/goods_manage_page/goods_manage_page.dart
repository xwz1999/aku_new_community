import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/bottom_button.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';

class GoodsManagePage extends StatefulWidget {
  GoodsManagePage({Key key}) : super(key: key);

  @override
  _GoodsManagePageState createState() => _GoodsManagePageState();
}

class _GoodsManagePageState extends State<GoodsManagePage> {
  List<Map<String, dynamic>> _listGoods = [
    {
      'imagePath':
          'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=409315131,2212208097&fm=26&gp=0.jpg',
      'title': '榔头',
      'goodsNum': 4
    },
    {
      'imagePath':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600315000206&di=d63920cce862ea3143b94f5efd9ee48f&imgtype=0&src=http%3A%2F%2Fimg009.hc360.cn%2Fy3%2FM06%2F97%2F52%2FwKhQh1T9gwqEG8-EAAAAADtr0hA725.jpg',
      'title': '梯子',
      'goodsNum': 2
    },
    {
      'imagePath':
          'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=742033541,898484766&fm=26&gp=0.jpg',
      'title': '电钻',
      'goodsNum': 10
    },
    {
      'imagePath':
          'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=655760492,2421981969&fm=26&gp=0.jpg',
      'title': '多功能螺丝刀',
      'goodsNum': 7
    },
    {
      'imagePath':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600315263467&di=87b7fa8cd8bc03f5bd320f29efd00418&imgtype=0&src=http%3A%2F%2Ftu.ossfiles.cn%3A9186%2Fgroup3%2FM00%2F08%2FB6%2FrBpVfl8H3XuAOUA-AAFkF36vtNY168.jpg',
      'title': '手电筒',
      'goodsNum': 5
    },
    {
      'imagePath':
          'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1922842359,3407397182&fm=26&gp=0.jpg',
      'title': '胶带',
      'goodsNum': 6
    }
  ];

  Container _goodsCard(String imagePath, title, int goodsNum) {
    return Container(
      margin: EdgeInsets.only(
        top: 20.w,
        left: 32.w,
        right: 32.w,
      ),
      padding: EdgeInsets.only(
        top: 12.w,
        left: 10.w,
        right: 10.w,
        bottom: 17.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 20.w),
            child: ClipRRect(
              child: CachedImageWrapper(
                url: imagePath,
                width: 160.w,
                height: 120.w,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '物品名称：$title',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: Color(0xff4a4b51),
                ),
              ),
              SizedBox(height: 20.w),
              Text(
                '数量剩余：$goodsNum个',
                style: TextStyle(
                  fontSize: 24.sp,
                  color: Color(0xff999999),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '借还管理',
          subtitle: '我的借还物品',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Stack(
        children: [
          Column(
            children: _listGoods
                .map((item) => _goodsCard(
                      item['imagePath'],
                      item['title'],
                      item['goodsNum'],
                    ))
                .toList(),
          ),
          Positioned(
            bottom: 0,
            child: BottomButton(
              title: '扫一扫出借',
              fun: () {
                scan();
              },
            ),
          ),
        ],
      ),
    );
  }
  ScanResult scanResult;

  final _flashOnController = TextEditingController(text: "打开闪光灯");
  final _flashOffController = TextEditingController(text: "关闭闪光灯");
  final _cancelController = TextEditingController(text: "关闭");

  var _aspectTolerance = 0.00;
  var numberOfCameras = 0;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      numberOfCameras = await BarcodeScanner.numberOfCameras;
      setState(() {});
    });
  }

  Future scan() async {
    try {
      var options = ScanOptions(
        strings: {
          "cancel": _cancelController.text,
          "flash_on": _flashOnController.text,
          "flash_off": _flashOffController.text,
        },
        restrictFormat: selectedFormats,
        useCamera: _selectedCamera,
        autoEnableFlash: _autoEnableFlash,
        android: AndroidOptions(
          aspectTolerance: _aspectTolerance,
          useAutoFocus: _useAutoFocus,
        ),
      );

      var result = await BarcodeScanner.scan(options: options);

      setState(() => scanResult = result);
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'The user did not grant the camera permission!';
        });
      } else {
        result.rawContent = 'Unknown error: $e';
      }
      setState(() {
        scanResult = result;
      });
    }
  }
}

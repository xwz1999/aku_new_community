import 'package:aku_new_community/base/base_style.dart';
import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/models/house/lease_fee_list_model.dart';
import 'package:aku_new_community/ui/profile/house/lease_pay_query/lease_pay_query_detail_page.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/base_list_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_divider.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/others/user_tool.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class LeasePayQueryPage extends StatefulWidget {
  final int id;

  LeasePayQueryPage({Key? key, required this.id}) : super(key: key);

  @override
  _LeasePayQueryPageState createState() => _LeasePayQueryPageState();
}

class _LeasePayQueryPageState extends State<LeasePayQueryPage> {
  int _page = 1;
  int _size = 10;
  int _years = DateTime.now().year;
  List<LeaseFeeListModel> _models = [];
  late EasyRefreshController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget header = Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.w),
      height: 200.w,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(R.ASSETS_STATIC_HOUSE_AUTH_FAIL_WEBP),
              fit: BoxFit.fitWidth)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MaterialButton(
            color: Colors.white,
            height: 60.w,
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Color(0xFFC4C4C4)),
                borderRadius: BorderRadius.circular(30.w)),
            onPressed: () async {
              Get.bottomSheet(_yearsPicker());
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _years.text.size(24.sp).color(ktextSubColor).make(),
                12.widthBox,
                Icon(
                  CupertinoIcons.arrowtriangle_down_fill,
                  size: 24.w,
                ),
              ],
            ),
          ),
          //暂时去掉总金额
          // 26.w.heightBox,
          // '  累计缴纳  ¥${_models.length}'
          //     .text
          //     .size(24.sp)
          //     .color(ktextSubColor)
          //     .make(),
        ],
      ),
    );
    return BeeScaffold(
      title: '缴费查询',
      body: Column(
        children: [
          header,
          EasyRefresh(
            header: MaterialHeader(),
            footer: MaterialFooter(),
            firstRefresh: true,
            controller: _controller,
            onRefresh: () async {
              _page = 1;
              BaseListModel baseListModel = await NetUtil()
                  .getList(API.house.leaseFeesQuery, params: {
                "pageNum": _page,
                "size": _size,
                "sysLeaseId": widget.id,
                "years": _years
              });
              _models.clear();
              _models = baseListModel.tableList!
                  .map((e) => LeaseFeeListModel.fromJson(e))
                  .toList();
              setState(() {});
            },
            onLoad: () async {
              _page++;
              BaseListModel baseListModel = await NetUtil()
                  .getList(API.house.leaseFeesQuery, params: {
                "pageNum": _page,
                "size": _size,
                "sysLeaseId": widget.id,
                "years": _years
              });
              if (baseListModel.pageCount! >= _page) {
                _models.addAll(baseListModel.tableList!
                    .map((e) => LeaseFeeListModel.fromJson(e))
                    .toList());
                setState(() {});
              }
            },
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 32.w,
              ),
              children: _models
                  .map((e) => _buildCard(e))
                  .toList()
                  .sepWidget(separate: 32.w.heightBox),
            ),
          ).expand(),
        ],
      ),
    );
  }

  Widget _yearsPicker() {
    int _nowYear = DateTime.now().year;
    List<int> years = [
      _nowYear,
      _nowYear - 1,
      _nowYear - 2,
      _nowYear - 3,
      _nowYear - 4,
      _nowYear - 5
    ];
    return CupertinoActionSheet(
      title: '选择年份'.text.size(32.sp).bold.isIntrinsic.black.make(),
      actions: years
          .map((e) => CupertinoActionSheetAction(
              onPressed: () {
                _years = e;
                Get.back();
                _controller.callRefresh();
                setState(() {});
              },
              child:
                  e.toString().text.size(28.sp).black.isIntrinsic.bold.make()))
          .toList(),
    );
  }

  Widget _buildCard(LeaseFeeListModel model) {
    return GestureDetector(
      onTap: () {
        Get.to(() => LeasePayQueryDetailPage(
              model: model,
            ));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              model.typeString.text.size(28.sp).black.bold.make(),
              Spacer(),
              '${S.of(context)!.tempPlotName} ${UserTool.appProveider.selectedHouse!.roomName}'
                  .text
                  .size(24.sp)
                  .color(ktextSubColor)
                  .bold
                  .make(),
            ],
          ),
          12.w.heightBox,
          Row(
            children: [
              '${DateUtil.formatDateStr(model.createDate, format: 'MM/dd HH:mm')}'
                  .text
                  .color(ktextSubColor)
                  .make(),
              Spacer(),
              model.payStatus == 0
                  ? '未缴纳'.text.size(26.sp).color(Colors.red).make()
                  : SizedBox(),
              12.w.widthBox,
              '¥ ${model.price.toStringAsFixed(2)}'
                  .text
                  .size(26.sp)
                  .black
                  .bold
                  .make(),
            ],
          ),
          32.w.heightBox,
          BeeDivider.horizontal(),
        ],
      ),
    );
  }
}

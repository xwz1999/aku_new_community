import 'package:akuCommunity/pages/things_page/things_evaluate_page/things_evaluate_page.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/horizontal_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/expandable_text.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'widget/goods_info_card.dart';
import 'package:velocity_x/velocity_x.dart';

class ThingsDetailPage extends StatefulWidget {
  final Bundle bundle;
  ThingsDetailPage({Key key, this.bundle}) : super(key: key);

  @override
  _ThingsDetailPageState createState() => _ThingsDetailPageState();
}

class _ThingsDetailPageState extends State<ThingsDetailPage> {
  void againRouter() {
    ThingsEvaluatePage(
      bundle: Bundle()..putMap('details', {'title': '继续提问', 'isShow': false}),
    ).to;
  }

  Widget _containerCard(
      String tag, String content, String time, List<String> imageList) {
    return Container(
      padding: EdgeInsets.only(
        top: 46.w,
        left: 33.w,
        right: 44.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tag,
            style: TextStyle(
              fontSize: 38.sp,
              color: Color(0xff333333),
            ),
          ),
          SizedBox(height: 30.w),
          ExpandableText(
            text: content,
            maxLines: 2,
            style: TextStyle(
              fontSize: 28.sp,
              color: Color(0xff666666),
            ),
            expand: false,
          ),
          SizedBox(height: 29.w),
          imageList.length != 0 ? HorizontalImageView(imageList) : SizedBox(),
          SizedBox(height: 24.w),
          Text(
            time,
            style: TextStyle(
              fontSize: 24.sp,
              color: Color(0xff999999),
            ),
          ),
        ],
      ),
    );
  }

  Widget _positionedButton() {
    return Positioned(
      bottom: 0,
      child: InkWell(
        onTap: () {
          switch (widget.bundle.getMap('things')['isRepair']) {
            case true:
              break;
            case false:
              againRouter();
              break;
            default:
          }
        },
        child: Container(
          alignment: Alignment.center,
          height: 98.w,
          width: 750.w,
          padding: EdgeInsets.symmetric(vertical: 26.5.w),
          color: Color(0xffffc40c),
          child: Text(
            widget.bundle.getMap('things')['isRepair'] ? '确认完成' : '继续提问',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32.sp,
              color: Color(0xff333333),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '查看详情',
      actions: [
        widget.bundle.getMap('things')['isRepair']
            ? SizedBox()
            : InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.fromLTRB(32.w, 28.w, 32.w, 20.w),
                  child: '评价'.text.black.size(28.sp).make(),
                  alignment: Alignment.center,
                ),
              )
      ],
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            widget.bundle.getMap('things')['isRepair']
                ? ListView(
                    padding: EdgeInsets.only(bottom: 108.w),
                    children: [
                      GoodsInfoCard(
                        status: widget.bundle.getMap('things')['time'],
                        listImage: widget.bundle.getMap('things')['imageList'],
                        infodetails: widget.bundle.getMap('things')['content'],
                        isShow: false,
                      ),
                      GoodsInfoCard(
                        status: widget.bundle.getMap('things')['time'],
                        detoInfoList: [
                          {'title': '订单编号', 'content': 'LC20200630064682'},
                          {'title': '下单时间', 'content': '2020-06-30  22:54:30'},
                          {'title': '派单类型', 'content': '无偿服务'},
                          {'title': '维修人员', 'content': '王珂'},
                          {'title': '分配人', 'content': '马泽鹏'},
                        ],
                        isShow: false,
                      ),
                      GoodsInfoCard(
                        status: widget.bundle.getMap('things')['time'],
                        detoInfoList: [
                          {'title': '报修时间', 'content': '2020-06-30 10:23'},
                          {'title': '管家分派', 'content': '2020-06-30 13:54'},
                          {'title': '师傅接单', 'content': '2020-06-30 14:30'},
                          {'title': '回访', 'content': '2020-06-31 12:30'},
                        ],
                        isShow: true,
                      ),
                    ],
                  )
                : ListView(
                    padding: EdgeInsets.only(bottom: 108.w),
                    children: [
                      _containerCard(
                        '您的建议',
                        widget.bundle.getMap('things')['content'],
                        widget.bundle.getMap('things')['time'],
                        widget.bundle.getMap('things')['imageList'],
                      ),
                      SizedBox(height: 3.w),
                      _containerCard(
                        '物业回复',
                        widget.bundle.getMap('things')['content'],
                        widget.bundle.getMap('things')['time'],
                        <String>[],
                      ),
                    ],
                  ),
            _positionedButton(),
          ],
        ),
      ),
    );
  }
}

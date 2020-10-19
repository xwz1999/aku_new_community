import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/widget/expandable_text.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
import '../widget/image_grid.dart';
import 'widget/goods_info_card.dart';

class ThingsDetailPage extends StatefulWidget {
  final Bundle bundle;
  ThingsDetailPage({Key key, this.bundle}) : super(key: key);

  @override
  _ThingsDetailPageState createState() => _ThingsDetailPageState();
}

class _ThingsDetailPageState extends State<ThingsDetailPage> {
  void againRouter() {
    Navigator.pushNamed(context, PageName.things_evaluate_page.toString(),
        arguments: Bundle()
          ..putMap('details', {'title': '继续提问', 'isShow': false}));
  }

  Widget _containerCard(
      String tag, String content, String time, List<String> imageList) {
    return Container(
      padding: EdgeInsets.only(
        top: Screenutil.length(46),
        left: Screenutil.length(33),
        right: Screenutil.length(44),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tag,
            style: TextStyle(
              fontSize: Screenutil.size(38),
              color: Color(0xff333333),
            ),
          ),
          SizedBox(height: Screenutil.length(30)),
          ExpandableText(
            text: content,
            maxLines: 2,
            style: TextStyle(
              fontSize: Screenutil.size(28),
              color: Color(0xff666666),
            ),
            expand: false,
          ),
          SizedBox(height: Screenutil.length(29)),
          imageList.length != 0 ? ImageGrid(imageList) : SizedBox(),
          SizedBox(height: Screenutil.length(24)),
          Text(
            time,
            style: TextStyle(
              fontSize: Screenutil.size(24),
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
        onTap: (){
          switch (widget.bundle.getMap('things')['isRepair'] ) {
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
          height: Screenutil.length(98),
          width: Screenutil.length(750),
          padding: EdgeInsets.symmetric(vertical: Screenutil.length(26.5)),
          color: Color(0xffffc40c),
          child: Text(
            widget.bundle.getMap('things')['isRepair'] ? '确认完成' : '继续提问',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Screenutil.size(32),
              color: Color(0xff333333),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '查看详情',
          subtitle: widget.bundle.getMap('things')['isRepair'] ? '' : '评价',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            widget.bundle.getMap('things')['isRepair']
                ? ListView(
                    padding: EdgeInsets.only(bottom: Screenutil.length(108)),
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
                    padding: EdgeInsets.only(bottom: Screenutil.length(108)),
                    children: [
                      _containerCard(
                        '您的建议',
                        widget.bundle.getMap('things')['content'],
                        widget.bundle.getMap('things')['time'],
                        widget.bundle.getMap('things')['imageList'],
                      ),
                      SizedBox(height: Screenutil.length(3)),
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

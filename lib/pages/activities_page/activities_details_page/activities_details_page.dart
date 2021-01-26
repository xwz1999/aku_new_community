// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:image_stack/image_stack.dart';

// Project imports:
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/pages/activities_page/member_list_page/member_list_page.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/bottom_button.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';

class ActivitiesDetailsPage extends StatefulWidget {
  final Bundle bundle;
  ActivitiesDetailsPage({Key key, this.bundle}) : super(key: key);

  @override
  _ActivitiesDetailsPageState createState() => _ActivitiesDetailsPageState();
}

const htmlData = '''
  <p>最近，“乘风破浪的姐姐”火了！那群自信、洒脱、勇
  敢的姐姐们，用过硬的专业素养和独特的人格魅力完
  美诠释了“乘风破浪”的涵义，不少小伙伴表示在南宁
  社区内，也有这样的人，他们不光有颜有才，对待己
  的工作和人生也有自己的态度和担当！<br /><br /><br />
  那么今天<br />
  咱家“乘风破浪的姐姐”来了！<br />
  前方我们园区绿化保卫员<br /><br /><br />
  这些保卫员不光有超高的颜值，<br />
  他们还凭借着自己的努力<br />
  和对工作认真负责的态度，<br />
  在自己的岗位上<br />
  奉献青春，绽放光芒。<br />
  截止至6月27日<br />
  喊上亲朋好友<br />
  快为你支持的保卫员投票吧！
 </p>
''';

const htmlData1 = '''
  <p>为丰富文化体育生活，不断增进小区凝聚力和人与人之
  间的协作能力，市委政法委机关党办、机关工会联合举
  办“我参与、我健康、我快乐”系列主题活动。 ！<br />
  鞋底擦地的沙沙声，拉绳时的呼号声，乘着悠悠暖风，
  奏成一曲夏的交响乐。汗水落地迸溅的瞬间，队员们奋
  力拼搏的身姿，与融融暖阳，绘成一幅夏的长卷。<br /><br />
  开始时间&nbsp;&nbsp;&nbsp;2020年04月12日12:00<br /><br />
  结束时间&nbsp;&nbsp;&nbsp;2020年04月15日12:00<br /><br />
  地&nbsp;&nbsp;&nbsp;&nbsp;点&nbsp;&nbsp;&nbsp;小区外围体育馆<br /><br />
  参与人数&nbsp;&nbsp;&nbsp;不限<br /><br />
  报名截止&nbsp;&nbsp;&nbsp;2020年04月13日 12:00<br /><br />
 </p>
''';

class _ActivitiesDetailsPageState extends State<ActivitiesDetailsPage> {
  List<Map<String, dynamic>> _listView = [
    {
      'imagePath':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600062939837&di=30a87dadf9bf465757d70928760f5bb6&imgtype=0&src=http%3A%2F%2Fwww.360changshi.com%2Fuploadfile%2F2015%2F0821%2F20150821020210299.jpg',
      'post': '西区绿化保卫员',
      'name': '马泽鹏',
      'isCheck': true,
    },
    {
      'imagePath':
          'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2079977064,85120418&fm=26&gp=0.jpg',
      'post': '东区绿化保卫员',
      'name': '王珂',
      'isCheck': false,
    },
    {
      'imagePath':
          'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1380335538,732392216&fm=26&gp=0.jpg',
      'post': '中央园区绿化保卫员',
      'name': '周玲慧',
      'isCheck': false,
    },
    {
      'imagePath':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600063061495&di=ad1a8818ba152ca1079ea761a34ec073&imgtype=0&src=http%3A%2F%2Fimg1.a.maoyia.com%2F201806%2F22%2F08%2F08-21-45-11-1441452.jpg',
      'post': '南区绿化保卫员',
      'name': '叶一样',
      'isCheck': false,
    }
  ];

  void _showDialog(String url) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            '是否确定投$url\一票',
            style: TextStyle(
              fontSize: 34.sp,
              color: Color(0xff030303),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                '取消',
                style: TextStyle(
                  fontSize: 34.sp,
                  color: Color(0xff333333),
                ),
              ),
              onPressed: () {
                Get.back();
              },
            ),
            CupertinoDialogAction(
              child: Text(
                '确定',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 34.sp,
                  color: Color(0xffff8200),
                ),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _inkWellVoteCard(
      String imagePath, post, name, int index, bool isOver) {
    return InkWell(
      onTap: isOver
          ? null
          : () {
              _listView.forEach((item) {
                item['isCheck'] = false;
              });
              _listView[index]['isCheck'] = true;
              _showDialog(_listView[index]['name']);
              setState(() {});
            },
      child: Container(
        margin: EdgeInsets.only(top: 39.w),
        padding: EdgeInsets.only(left: 41.w, bottom: 40.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: BaseStyle.colord8d8d8, width: 0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150.w,
              alignment: Alignment.center,
              child: Icon(
                isOver
                    ? Icons.radio_button_checked
                    : _listView[index]['isCheck']
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                color: isOver
                    ? BaseStyle.color979797
                    : _listView[index]['isCheck']
                        ? Colors.red
                        : BaseStyle.color979797,
                size: 36.w,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 17.w,
                right: 30.w,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                child: CachedImageWrapper(
                  url: imagePath,
                  width: 150.w,
                  height: 150.w,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post,
                  style: TextStyle(
                    fontSize: BaseStyle.fontSize32,
                    color: ktextPrimary,
                  ),
                ),
                SizedBox(height: 10.w),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: BaseStyle.fontSize32,
                    color: ktextPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _inkWellEnterMember(List<String> memberList) {
    return InkWell(
      onTap: () {
        MemberListPage().to();
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 24.w),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: BaseStyle.coloreeeeee, width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 80.w),
              child: ImageStack(
                imageList: memberList,
                imageRadius: 44.sp,
                imageCount: 3,
                imageBorderWidth: 1,
                totalCount: 3,
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 16.w),
                  child: Text(
                    '已有${320}人参加',
                    style: TextStyle(
                        fontSize: BaseStyle.fontSize28, color: ktextPrimary),
                  ),
                ),
                Icon(
                  AntDesign.right,
                  size: 36.sp,
                  color: BaseStyle.color999999,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '活动详情',
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.only(
                  bottom:
                      (widget.bundle.getMap('details')['isVote'] ? 0 : 170).w),
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: 26.w, left: 32.w, right: 32.w, bottom: 60.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.bundle.getMap('details')['title'],
                        style: TextStyle(
                            fontSize: BaseStyle.fontSize32,
                            color: ktextPrimary,
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 45.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          child: CachedImageWrapper(
                            url: widget.bundle.getMap('details')['imagePath'],
                            width: 686.w,
                            height: 228.w,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 44.w),
                        width: 647.w,
                        child: Html(
                            data: widget.bundle.getMap('details')['isVote']
                                ? htmlData
                                : htmlData1),
                      ),
                    ],
                  ),
                ),
                widget.bundle.getMap('details')['isVote']
                    ? SizedBox()
                    : SizedBox(
                        height: 24.w,
                        child: Container(color: BaseStyle.colorf9f9f9),
                      ),
                Container(
                  padding: EdgeInsets.only(
                      top: 26.w, left: 32.w, right: 32.w, bottom: 60.w),
                  child: widget.bundle.getMap('details')['isVote']
                      ? Container(
                          margin: EdgeInsets.only(top: 44.w),
                          padding: EdgeInsets.only(
                              top: 50.w, left: 32.w, right: 25.w),
                          width: 686.w,
                          decoration: BoxDecoration(
                            color: BaseStyle.colorf3f3f3,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            border: Border.all(
                                color: BaseStyle.colorfafafa, width: 0.5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '选出你心中乘风破浪的园区保卫员',
                                style: TextStyle(
                                    fontSize: BaseStyle.fontSize32,
                                    color: BaseStyle.color999999),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 3.w),
                                child: Column(
                                  children: _listView
                                      .asMap()
                                      .keys
                                      .map((index) => _inkWellVoteCard(
                                            _listView[index]['imagePath'],
                                            _listView[index]['post'],
                                            _listView[index]['name'],
                                            index,
                                            widget.bundle
                                                .getMap('details')['isOver'],
                                          ))
                                      .toList(),
                                ),
                              ),
                            ],
                          ))
                      : _inkWellEnterMember(
                          widget.bundle.getMap('details')['memberList']),
                ),
              ],
            ),
          ),
          widget.bundle.getMap('details')['isVote']
              ? SizedBox()
              : Positioned(
                  bottom: 0,
                  child: BottomButton(
                    title: widget.bundle.getMap('details')['isOver']
                        ? '该活动已结束'
                        : '我要报名',
                    fun: widget.bundle.getMap('details')['isOver']
                        ? null
                        : () {},
                  ),
                ),
        ],
      ),
    );
  }
}

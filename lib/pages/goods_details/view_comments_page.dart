import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/widget/sliver_app_bar_delegate.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'widget/goods_app_bar.dart';
import 'widget/goods_comments_card.dart';

final List<String> imageUrl = [
  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1599023251944&di=59dc4c919525b21567da91d7564b250b&imgtype=0&src=http%3A%2F%2Fku.90sjimg.com%2Felement_origin_min_pic%2F16%2F11%2F13%2Fd6882b6abd40c900655c87ebfc8dee0a.jpg',
  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1599023251944&di=114f065583b0fb949c2621df5eb2aeb0&imgtype=0&src=http%3A%2F%2Fwww.track-roller.com%2Fimg%2Ftk9912701.jpg',
  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1599023251943&di=2208befacee137736dced7bec5fc71a5&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20170921%2F0ebcc71a45f24904a0f89ae90d65787e.jpeg'
];

class ViewCommentsPage extends StatefulWidget {
  ViewCommentsPage({Key key}) : super(key: key);

  @override
  _ViewCommentsPageState createState() => _ViewCommentsPageState();
}

class _ViewCommentsPageState extends State<ViewCommentsPage> {
  List<Map<String, dynamic>> _commentsClassList = [
    {'title': "全部", 'isSelect': true},
    {'title': "好评(23)", 'isSelect': false},
    {'title': "差评(0)", 'isSelect': false},
    {'title': "中评(0)", 'isSelect': false},
    {'title': "追加(24)", 'isSelect': false},
  ];

  List<Map<String, dynamic>> _commentsCardList = [
    {
      'imagePath':
          "https://dss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1812993978,4158651947&fm=26&gp=0.jpg",
      'name': '就是安安啊',
      'subtitle': "4天前 尺码[170-185cm] 颜色分类：黑色",
      'content': '面料和版型都不错，会回购',
      'contentImageList': imageUrl,
      'viewNum': '5',
    },
    {
      'imagePath':
          "https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2690587153,2643787055&fm=26&gp=0.jpg",
      'name': '马泽鹏',
      'subtitle': "47天前 尺码[170-185cm] 颜色分类：黑色",
      'content': '太好蓝了，现在天气有点热，赶快到秋天',
      'contentImageList': [
        'https://img.alicdn.com/imgextra/i3/409405727/O1CN01yNXzbp1sB0pPy06vu_!!409405727.jpg',
        'https://img.alicdn.com/imgextra/i3/409405727/O1CN01yNXzbp1sB0pPy06vu_!!409405727.jpg',
        'https://img.alicdn.com/imgextra/i2/409405727/O1CN01oaedss1sB0pPDo1JB_!!409405727.jpg'
      ],
      'viewNum': '532',
    },
    {
      'imagePath':
          "https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3095823371,2737858048&fm=26&gp=0.jpg",
      'name': '王珂珂',
      'subtitle': "4天前 尺码[170-185cm] 颜色分类：黑色",
      'content': '面料和版型都不错，会回购',
      'contentImageList': [
        'https://img.alicdn.com/bao/uploaded/i4/O1CN01XIzuhk1FdADbW7Cwf_!!0-rate.jpg_400x400.jpg',
        'https://img.alicdn.com/bao/uploaded/i1/O1CN01KNMhVC242YySXXE4f_!!0-rate.jpg_400x400.jpg',
        'https://img.alicdn.com/bao/uploaded/i4/O1CN01A2q4Bb2LhBZJ5elrj_!!0-rate.jpg_400x400.jpg',
      ],
      'viewNum': '235',
    },
  ];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1500));

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1500));
    _commentsCardList.add({
      'imagePath':
          "https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3095823371,2737858048&fm=26&gp=0.jpg",
      'name': '王珂珂',
      'subtitle': "4天前 尺码[170-185cm] 颜色分类：黑色",
      'content': '面料和版型都不错，会回购',
      'contentImageList': imageUrl,
      'viewNum': '235',
    });
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  Container _commentsClass() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: Screenutil.length(29),
        left: Screenutil.length(32),
        bottom: Screenutil.length(40),
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: Screenutil.length(25)),
            child: Text(
              '按分类评价',
              style: TextStyle(
                fontSize: BaseStyle.fontSize28,
                color: BaseStyle.color999999,
              ),
            ),
          ),
          Wrap(
            spacing: Screenutil.length(10),
            runSpacing: Screenutil.length(20),
            children: _commentsClassList
                .map((item) => InkWell(
                      onTap: () {
                        _commentsClassList.forEach((item) {
                          item['isSelect'] = false;
                        });
                        setState(() {
                          item['isSelect'] = true;
                        });
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        child: Container(
                          padding: EdgeInsets.only(
                            left: Screenutil.length(24),
                            right: Screenutil.length(23),
                            top: Screenutil.length(9),
                            bottom: Screenutil.length(10),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            color: item['isSelect']
                                ? Color(0xfffff6da)
                                : Color(0xffededed),
                            border: Border.all(
                                color: item['isSelect']
                                    ? Color(0xffffc40c)
                                    : Colors.transparent,
                                width: 0.5),
                          ),
                          child: Text(
                            item['title'],
                            style: TextStyle(
                              fontSize: BaseStyle.fontSize24,
                              color: BaseStyle.color333333,
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: GoodsAppBar(),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Column(
        children: [
          _commentsClass(),
          Expanded(
            child: Container(
              child: RefreshConfiguration(
                hideFooterWhenNotFull: true,
                child: SmartRefresher(
                  controller: _refreshController,
                  header: WaterDropHeader(),
                  footer: ClassicFooter(),
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  enablePullUp: true,
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: Screenutil.length(30)),
                    itemBuilder: (BuildContext context, int index) => Container(
                      color: Colors.white,
                      child: GoodsCommentsCard(
                        imagePath: _commentsCardList[index]['imagePath'],
                        name: _commentsCardList[index]['name'],
                        subtitle: _commentsCardList[index]['subtitle'],
                        content: _commentsCardList[index]['content'],
                        contentImageList: _commentsCardList[index]
                            ['contentImageList'],
                        viewNum: _commentsCardList[index]['viewNum'],
                      ),
                    ),
                    itemCount: _commentsCardList.length,
                  ),
                ),
              ),
            ),
          )
        ],
      ),

      // NestedScrollView(
      //   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      //     return <Widget>[
      //       SliverPersistentHeader(
      //         pinned: true,
      //         delegate: SliverAppBarDelegate(
      //           minHeight: 200,
      //           maxHeight: 200,
      //           child: _commentsClass(),
      //         ),
      //       )
      //     ];
      //   },
      //   body: RefreshConfiguration(
      //     hideFooterWhenNotFull: true,
      //     child: SmartRefresher(
      //       controller: _refreshController,
      //       header: WaterDropHeader(),
      //       footer: ClassicFooter(),
      //       onRefresh: _onRefresh,
      //       onLoading: _onLoading,
      //       enablePullUp: true,
      //       child: ListView.builder(
      //         itemBuilder: (BuildContext context, int index) => Text('data'),
      //         itemCount: 6,
      //       ),
      //     ),
      //   ),
      // children: [
      //   Positioned(
      //     top: 0,
      //     left: 0,
      //     right: 0,
      //     child: _commentsClass(),
      //   ),

      // ],
      // ),
    );
  }
}

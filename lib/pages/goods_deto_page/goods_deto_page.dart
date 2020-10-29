import 'package:akuCommunity/utils/screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/widget/bottom_button.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
import 'widget/goods_info_card.dart';

class GoodsDetoPage extends StatefulWidget {
  GoodsDetoPage({Key key}) : super(key: key);

  @override
  _GoodsDetoPageState createState() => _GoodsDetoPageState();
}

class _GoodsDetoPageState extends State<GoodsDetoPage> {
  List<String> _listImage = [
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600160449547&di=21b73a9a117988683773490f1230dacf&imgtype=0&src=http%3A%2F%2Ffile3.youboy.com%2Fd%2F157%2F50%2F46%2F1%2F873561.jpg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600160548603&di=56a586397e8d4223f10a8912c011f46a&imgtype=0&src=http%3A%2F%2Fimages.paiming.net%2Fimages%2Fupload%2F20181025%2F20181025113249_2421.jpg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600160568752&di=dc5e904c452f8b59a6b0526861d67697&imgtype=0&src=http%3A%2F%2Fwww.llfbj.com%2Fuploads%2Fallimg%2F160218%2F1-16021R22K2V9.jpg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600160586384&di=28d8cd4a547baa87571e03a5e6ffda03&imgtype=0&src=http%3A%2F%2Fdownload.img.dns4.cn%2Fpic%2F209211%2Fp2%2F20171115151608_6648_zs.jpg%3F308*308',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600160602710&di=8c44c989c744c94bedf58d64f3db2abd&imgtype=0&src=http%3A%2F%2Ftu.ossfiles.cn%3A9186%2Fgroup3%2FM00%2F0F%2FFE%2FrBpVfl88i4mAARmAAACZsU16st0080.jpg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600160627146&di=3b38d04039273ef288f2fe8307c503bc&imgtype=0&src=http%3A%2F%2Ffile5.youboy.com%2Fd%2F158%2F85%2F68%2F1%2F237131s.jpg'
  ];

  List<Map<String, dynamic>> _listView = [
    {
      'status': '已提交',
      'details': <Map<String, dynamic>>[
        {'title': '物品重量', 'content': '< 50kg'},
        {'title': '出户时间', 'content': '2020-10-10  12:00'},
        {'title': '物品名称', 'content': '家具'},
        {'title': '搬运方式', 'content': '搬家公司'}
      ]
    },
    {
      'status': '已出户',
      'details': <Map<String, dynamic>>[
        {'title': '物品重量', 'content': '< 50kg'},
        {'title': '出户时间', 'content': '2020-10-10  12:00'},
        {'title': '实际出户时间', 'content': '2020-10-10  14:00'},
        {'title': '物品名称', 'content': '全部'},
        {'title': '搬运方式', 'content': '自己搬家'}
      ]
    },
    {
      'status': '已驳回',
      'details': <Map<String, dynamic>>[
        {'title': '物品重量', 'content': '< 50kg'},
        {'title': '出户时间', 'content': '2020-10-10  12:00'},
        {'title': '实际出户时间', 'content': '2020-10-10  14:00'},
        {'title': '物品名称', 'content': '全部'},
        {'title': '搬运方式', 'content': '自己搬家'}
      ]
    }
  ];

  List<Map<String, dynamic>> _listButton = [
    {'title': '查看二维码', 'icon': MaterialCommunityIcons.qrcode},
    {'title': '搬家公司', 'icon': SimpleLineIcons.phone}
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

    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  void createRouter() {
    Navigator.pushNamed(context, PageName.deto_create_page.toString());
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '物品出户',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 98.w),
            child: RefreshConfiguration(
              hideFooterWhenNotFull: true,
              child: SmartRefresher(
                controller: _refreshController,
                header: WaterDropHeader(),
                footer: ClassicFooter(),
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                enablePullUp: true,
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) => GoodsInfoCard(
                          listImage: _listImage,
                          status: _listView[index]['status'],
                          detoInfoList: _listView[index]['details'],
                        ),
                        childCount: _listView.length,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: BottomButton(
              title: '新增',
              fun: createRouter,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:akuCommunity/pages/things_page/things_create_page/things_create_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
import 'widget/things_app_bar.dart';
import 'widget/things_list.dart';

//TODO CLEAN BOTTOM CODES.
@Deprecated("sh*t page need to be cleaned.")
class ThingsPage extends StatefulWidget {
  final Bundle bundle;
  ThingsPage({Key key, this.bundle}) : super(key: key);

  @override
  _ThingsPageState createState() => _ThingsPageState();
}

class _ThingsPageState extends State<ThingsPage> with TickerProviderStateMixin {
  List<Map<String, dynamic>> _listCard = [
    {
      'time': '2020年10月13日',
      'tag': '已提交',
      'content': '我觉得我们小区的绿化可以再多一点',
      'imageList': <String>[
        'https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=111636878,534819054&fm=26&gp=0.jpg',
        'https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3834533673,769780989&fm=26&gp=0.jpg',
        'https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1683501076,3787404077&fm=26&gp=0.jpg',
        'https://dss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1040644610,2290865162&fm=26&gp=0.jpg',
      ]
    },
    {
      'time': '2020年09月23日',
      'tag': '已审阅',
      'content': '我觉得外面的小摊贩还是不要来了，毕竟为了环保，还有小区的孩子很多，大狗什么的希望主人能管好它',
      'imageList': <String>[]
    },
    {
      'time': '2020年08月12日',
      'tag': '已反馈',
      'content': '夏天蛇蚁虫属真多，希望小区能组队给整个小区保洁一下',
      'imageList': <String>[
        'https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1696975393,2205543181&fm=26&gp=0.jpg',
        'https://dss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3220834958,1457978756&fm=26&gp=0.jpg',
      ]
    },
  ];

  List<Map<String, dynamic>> _listRepair = [
    {
      'time': '公区报修',
      'tag': '已处理',
      'content': '小区花园的健身器材坏了请注意抓紧时间维修。还有一些健身器材年限到了麻烦注意更换，因为怕出现安全隐患。',
      'imageList': <String>[
        'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2390449629,3468003032&fm=26&gp=0.jpg',
        'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=123602716,1727529947&fm=26&gp=0.jpg',
        'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3789981542,2569571902&fm=26&gp=0.jpg',
      ]
    },
    {
      'time': '家庭维修',
      'tag': '待分配',
      'content': '家里的洗衣机坏了请师傅抓紧时间，赶快支援。',
      'imageList': <String>[
        'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1199114124,190063793&fm=26&gp=0.jpg',
        'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1009468563,227812083&fm=26&gp=0.jpg',
      ]
    },
    {
      'time': '家庭维修',
      'tag': '维修中',
      'content': '家里的空调坏了，热死人了，请师傅火速来修。',
      'imageList': <String>[
        'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1349979411,865756316&fm=26&gp=0.jpg',
        'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2162579969,1968776994&fm=26&gp=0.jpg',
      ]
    },
    {
      'time': '家庭维修',
      'tag': '已完成',
      'content': '家里的冰箱坏了，师傅赶紧来看看',
      'imageList': <String>[
        'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=466219337,2269488732&fm=15&gp=0.jpg',
        'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=907707978,1526051881&fm=26&gp=0.jpg',
      ]
    },
    {
      'time': '家庭维修',
      'tag': '已取消',
      'content': '家里的电饭煲坏了，师傅快上门修一下。',
      'imageList': <String>[
        'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=61782379,2829421550&fm=26&gp=0.jpg',
        'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=921027380,3023940375&fm=15&gp=0.jpg',
      ]
    },
  ];

  TabController _controller;

  @override
  void initState() {
    if (widget.bundle.getMap('things')['treeList'] != null) {
      _controller = TabController(
          length: widget.bundle.getMap('things')['treeList'].length,
          vsync: this);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.bundle.getMap('things')['treeList'] != null) {
      _controller.dispose();
    }
    super.dispose();
  }

  Widget _positionedButton() {
    return Positioned(
      bottom: 0,
      child: InkWell(
        onTap: () {
          bool isIdea;
          switch (widget.bundle.getMap('things')['title']) {
            case '建议咨询':
              isIdea = true;
              break;
            case '投诉表扬':
              isIdea = false;
              break;
            case '报事报修':
              break;
            default:
          }
          ThingsCreatePage(
            bundle: Bundle()
              ..putMap('create', {
                'title': widget.bundle.getMap('things')['title'],
                'isIdea': isIdea
              }),
          ).to;
        },
        child: Container(
          alignment: Alignment.center,
          height: 98.w,
          width: 750.w,
          padding: EdgeInsets.symmetric(vertical: 26.5.w),
          color: Color(0xffffc40c),
          child: Text(
            '新增',
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: widget.bundle.getMap('things')['title'] == '报事报修'
            ? CommonAppBar(
                title: '${widget.bundle.getMap('things')['title']}',
              )
            : ThingsAppBar(
                title: '${widget.bundle.getMap('things')['title']}',
                tabController: _controller,
                treeList: widget.bundle.getMap('things')['treeList'],
              ),
        preferredSize: Size.fromHeight(
            widget.bundle.getMap('things')['title'] == '报事报修'
                ? kToolbarHeight
                : kToolbarHeight * 1.8),
      ),
      body: Stack(
        children: [
          widget.bundle.getMap('things')['title'] == '报事报修'
              ? ThingsList(
                  listCard: _listRepair,
                  isRepair: true,
                )
              : TabBarView(
                  controller: _controller,
                  children: List.generate(
                    widget.bundle.getMap('things')['treeList'].length,
                    (index) => ThingsList(
                      listCard: _listCard,
                      isRepair: false,
                    ),
                  ),
                ),
          _positionedButton(),
        ],
      ),
    );
  }
}

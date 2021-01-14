import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';

class MemberListPage extends StatefulWidget {
  MemberListPage({Key key}) : super(key: key);

  @override
  _MemberListPageState createState() => _MemberListPageState();
}

class _MemberListPageState extends State<MemberListPage> {
  List<Map<String, dynamic>> _listMemberList = [
    {
      'imagePath':
          'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=251289958,1860898046&fm=26&gp=0.jpg',
      'name': '马泽鹏',
      'phone': '18844441879'
    },
    {
      'imagePath':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600336261085&di=ecdf0b044d86d52173b57f7ed01f3a9b&imgtype=0&src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201408%2F30%2F20140830180834_XuWYJ.png',
      'name': '王珂',
      'phone': '13844441179'
    },
    {
      'imagePath':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600336261085&di=0961159907966a47dfb3e1b5d82fa1d3&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn19%2F0%2Fw400h400%2F20180910%2F3391-hiycyfw5413589.jpg',
      'name': '叶一样',
      'phone': '13944443278'
    },
    {
      'imagePath':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600336261084&di=59a60839cdf3621cf48a7e5b41aabaa4&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201703%2F31%2F20170331090953_zUcaS.jpeg',
      'name': '周玲慧',
      'phone': '15844441899'
    },
    {
      'imagePath':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600336261083&di=53b0dead3e405ce275906ab94c86bde6&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fq_70%2Cc_zoom%2Cw_640%2Fimages%2F20190129%2F8478c326fa174158859b9ac093e36938.jpeg',
      'name': '马成泽',
      'phone': '13844444979'
    },
    {
      'imagePath':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600336261083&di=690a867c66de6517e04d51d7df8fc0ff&imgtype=0&src=http%3A%2F%2Fpic2.zhimg.com%2F50%2Fv2-dabd289dd21a5cf4967cb9b710cee36f_hd.jpg',
      'name': '王珂珂',
      'phone': '18844441879'
    },
    {
      'imagePath':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600336261082&di=a4ad6bab4fd4fdd736a9d4bab76d0bce&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201706%2F10%2F20170610192627_yhAMN.thumb.700_0.jpeg',
      'name': '王章程',
      'phone': '18844441879'
    },
    {
      'imagePath':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600336261079&di=34d4969e9e657de267a6df0bd60eb40c&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%3D580%2Fsign%3D09b795cc9e2f07085f052a08d925b865%2F75dffbf2b21193133e1f783365380cd790238d75.jpg',
      'name': '刘佳佳',
      'phone': '15844448879'
    },
    {
      'imagePath':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600336261078&di=76d0e5d8b4ad47d066a29803dfa4c175&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201902%2F17%2F20190217231515_ixMhS.thumb.700_0.jpeg',
      'name': '周建',
      'phone': '13844441879'
    },
    {
      'imagePath':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600336548534&di=eba96a077b96eac039d136587c5bb908&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201712%2F19%2F20171219234358_VRdrH.thumb.700_0.jpeg',
      'name': '静静',
      'phone': '16644441879'
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

    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  Container _memberCard(String imagePath, name, phone) {
    return Container(
      padding: EdgeInsets.only(
        top: 18.w,
        bottom: 18.w,
        left: 20.w,
        right: 10.w,
      ),
      margin: EdgeInsets.symmetric(horizontal: 32.w),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: BaseStyle.coloreeeeee, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 18.w),
                child: ClipOval(
                  child: CachedImageWrapper(
                    url: imagePath,
                    width: 60.w,
                    height: 60.w,
                  ),
                ),
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: BaseStyle.fontSize28,
                  color: ktextPrimary,
                ),
              ),
            ],
          ),
          Text(
            phone.replaceAllMapped(new RegExp(r'(\d{3})\d{4}(\d+)'),
                (Match m) => "${m[1]}****${m[2]}"),
            style: TextStyle(
              fontSize: BaseStyle.fontSize28,
              color: ktextPrimary,
            ),
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
          title: '参与人员',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Container(
        color: Colors.white,
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
                    (BuildContext context, int index) => _memberCard(
                      _listMemberList[index]['imagePath'],
                      _listMemberList[index]['name'],
                      _listMemberList[index]['phone'],
                    ),
                    childCount: _listMemberList.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

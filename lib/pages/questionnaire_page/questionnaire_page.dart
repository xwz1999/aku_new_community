import 'package:akuCommunity/pages/questionnaire_page/questionnaire_details_page/questionnaire_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/widget/community_card.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
import 'package:akuCommunity/utils/headers.dart';

class QuestionnairePage extends StatefulWidget {
  QuestionnairePage({Key key}) : super(key: key);

  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  List<String> images = [
    "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1151143562,4115642159&fm=26&gp=0.jpg",
    "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2551412680,857245643&fm=26&gp=0.jpg",
    "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3604827221,1047385274&fm=26&gp=0.jpg",
  ];
  List<Map<String, dynamic>> _listView = [
    {
      'imagePath':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600076026158&di=da8cffada3104f26e80cea2c7f54ce70&imgtype=0&src=http%3A%2F%2F0429.zxdyw.com%2FU_Image%2F2017%2F0925%2Fe%2F20170925104340_9160.jpg',
      'title': '狮子王画室课程满意程度',
      'subtitle': '亲爱的家长朋友，您好很高心为您的孩子选…',
      'timeZone': '06月17日 15:20至06月17日 18:00',
      'peopleNum': 37,
      'isOver': false,
      'isVote': true
    },
    {
      'imagePath':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600076048900&di=ac816ae35f05e5f1d959449d36efa6d3&imgtype=0&src=http%3A%2F%2Fimage.ludedc.com%2Fimage%2F20151125%2F251632264b19f55f136042.jpg',
      'title': '小区色绿环保，绿色种植比例调查问卷',
      'subtitle': '各位业主，您好，本着小区结合现代化发展…',
      'timeZone': '06月01日 13:20至06月01日 18:00',
      'peopleNum': 989,
      'isOver': false,
      'isVote': true
    },
    {
      'imagePath':
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1600076094434&di=8f88dc7dab7e716a0db1bde7dc55309b&imgtype=0&src=http%3A%2F%2Fqcloud.dpfile.com%2Fpc%2FceOXxAYp_7zhCWKRpYBCahIE_4Q5VlY5lWZsONVu0ahouI64PLnDNyiI08ZHM8ZfTYGVDmosZWTLal1WbWRW3A.jpg',
      'title': '美嘉舞蹈工作室问卷调查',
      'subtitle': '各位家长，应照舞蹈室的委托，开展一次问…',
      'timeZone': '06月01日 13:20至06月01日 18:00',
      'peopleNum': 989,
      'isOver': true,
      'isVote': false
    }
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

  void detailsRouter(String imagePath, title) {
   QuestionnaireDetailsPage(bundle: Bundle()
          ..putMap('details', {
            'title': title,
            'imagePath': imagePath,
          }),).to;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '问卷调查',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: RefreshConfiguration(
        hideFooterWhenNotFull: true,
        child: SmartRefresher(
          controller: _refreshController,
          header: WaterDropHeader(),
          footer: ClassicFooter(),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          enablePullUp: true,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) => CommunityCard(
              imagePath: _listView[index]['imagePath'],
              title: _listView[index]['title'],
              subtitle: _listView[index]['subtitle'],
              timeZone: _listView[index]['timeZone'],
              headList: images,
              isOver: _listView[index]['isOver'],
              peopleNum: _listView[index]['peopleNum'],
              fun: detailsRouter,
            ),
            itemCount: _listView.length,
          ),
        ),
      ),
    );
  }
}

import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:velocity_x/velocity_x.dart';

class CommentMessagePage extends StatefulWidget {
  CommentMessagePage({Key key}) : super(key: key);

  @override
  _CommentMessagePageState createState() => _CommentMessagePageState();
}

class _CommentMessagePageState extends State<CommentMessagePage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<Map<String, dynamic>> _listNotice = [
    {
      'name': '马泽鹏',
      'imageHeader': 'assets/example/touxiang1.png',
      'content': '教师节，我们为老师唱首歌吧，顺便给老师过生日。',
      'time': '1分钟前',
      'imagePath': 'assets/example/jiaoshijie.png'
    },
    {
      'name': '周玲慧',
      'imageHeader': 'assets/example/touxiang2.png',
      'content': '回复了马泽鹏: 小马好主意',
      'time': '10分钟前',
      'imagePath': 'assets/example/jiaoshijie.png'
    },
    {
      'name': '王珂',
      'imageHeader': 'assets/example/touxiang1.png',
      'content': '教师节，我们为老师唱首歌吧，顺便给老师过生日。',
      'time': '20分钟前',
      'imagePath': 'assets/example/jiaoshijie.png'
    },
    {
      'name': '王珂',
      'imageHeader': 'assets/example/touxiang1.png',
      'content': '回复了马泽鹏: 小马就是鬼主意多',
      'time': '昨天 20:23',
      'imagePath': 'assets/example/jiaoshijie.png'
    },
  ];
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

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  Container _containerCommentCard(
      String name, imageHeader, content, time, imagePath) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.w),
      padding: EdgeInsets.only(
        top: 32.w,
        bottom: 16.w,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(context,
              color: Color(0xffe5e5e5), width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Image.asset(
              imageHeader,
              height: 86.w,
              width: 86.w,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(width: 20.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 36.sp,
                  color: Color(0xff333333),
                ),
              ),
              SizedBox(height: 6.w),
              Container(
                width: 392.w,
                child: Text(
                  content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 28.sp,
                    color: Color(0xff333333),
                  ),
                ),
              ),
              SizedBox(height: 16.w),
              Text(
                time,
                style: TextStyle(
                  fontSize: 28.sp,
                  color: Color(0xff999999),
                ),
              ),
            ],
          ),
          SizedBox(width: 12.w),
          Image.asset(
            imagePath,
            height: 158.w,
            width: 158.w,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '评论通知',
      actions: [
        InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.fromLTRB(32.w, 28.w, 32.w, 20.w),
            child: '清空'.text.black.size(28.sp).make(),
            alignment: Alignment.center,
          ),
        )
      ],
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
            child: ListView.builder(
              itemBuilder: (context, index) => _containerCommentCard(
                _listNotice[index]['name'],
                _listNotice[index]['imageHeader'],
                _listNotice[index]['content'],
                _listNotice[index]['time'],
                _listNotice[index]['imagePath'],
              ),
              itemCount: _listNotice.length,
            ),
          ),
        ),
      ),
    );
  }
}

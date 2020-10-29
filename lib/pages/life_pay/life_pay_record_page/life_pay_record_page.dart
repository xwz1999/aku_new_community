import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
import 'widget/record_card.dart';

class LifePayRecordPage extends StatefulWidget {
  LifePayRecordPage({Key key}) : super(key: key);

  @override
  _LifePayRecordPageState createState() => _LifePayRecordPageState();
}

class _LifePayRecordPageState extends State<LifePayRecordPage> {
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

  void billRouter() {
    Navigator.pushNamed(context, PageName.life_pay_bill_page.toString());
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
          title: '缴费记录',
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
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 34.w,
                  left: 32.w,
                  right: 32.w,
                ),
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(fontSize: 24.sp),
                      children: <InlineSpan>[
                        TextSpan(
                            text: '如果有疑问，请联系物业客服',
                            style: TextStyle(color: Color(0xff666666))),
                        TextSpan(
                          text: '400-6754322',
                          style: TextStyle(color: Color(0xffff8200)),
                        ),
                      ]),
                ),
              ),
              RecordCard(fun: billRouter),
              RecordCard(fun: billRouter),
              RecordCard(fun: billRouter),
              RecordCard(fun: billRouter),
            ],
          ),
        ),
      ),
    );
  }
}

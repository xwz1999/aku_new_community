import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/widget/search_bar_delegate.dart';

// import 'visitor_invitation/visitor_invitation.dart';
// import 'visitor_invitation/visitor_record.dart';
// import 'visitor_invitation/visitor_pass.dart';

// import 'complaint_call/complaint_call.dart';

// import 'industry_committee/industry_committee.dart';

// import 'things/things_main.dart';
// import 'things/things_create.dart';
// import 'things/things_detail.dart';
// import 'things/things_evaluate.dart';

// import 'message_center/message_center.dart';
// import 'message_center/system_notice.dart';
// import 'message_center/system_notice_details.dart';
// import 'message_center/comment_notice.dart';
// import 'message_center/shop_notice.dart';
// import 'message_center/refund_details.dart';

// import 'house/house_main.dart';
// import 'house/house_authenticate.dart';

// import 'car/car_main.dart';
// import 'car/car_add.dart';
// import 'car/select_house.dart';

// import 'setting/setting.dart';
// import 'setting/about.dart';
// import 'setting/invite.dart';
// import 'setting/feedback.dart';

// import 'activity/activity_main.dart';
// import 'activity/activity_details.dart';
// import 'activity/activity_member_list.dart';

// import 'questionnaire/questionnaire_main.dart';
// import 'questionnaire/questionnaire_details.dart';

// import 'goods_out/goods_out_main.dart';
// import 'goods_out/goods_out_create.dart';

// import 'fitup_manage/fitup_manage_main.dart';

// import 'life_pay/life_pay_main.dart';
// import 'life_pay/life_pay_info.dart';
// import 'life_pay/life_pay_bill.dart';
// import 'life_pay/life_pay_record.dart';

// import 'goods_manage/goods_manage_main.dart';
// import 'goods_manage/mine_goods_manage.dart';

// import 'notice/notice_main.dart';

// import 'address/address_main.dart';
// import 'address/address_edit.dart';

// import 'order/confirm_order.dart';
// import 'order/pay_order.dart';

// import 'total_application/total_applications_main.dart';

// import 'shop_class/shop_class_main.dart';

// import 'one_alarm/one_alarm_main.dart';
// import 'one_alarm/explain_template.dart';

// import 'open_door/open_door_main.dart';

// import 'certification/certification_main.dart';

class CommonPage extends StatefulWidget {
  final Bundle bundle;
  CommonPage({Key key, this.bundle}) : super(key: key);

  @override
  _CommonPageState createState() => _CommonPageState();
}

class _CommonPageState extends State<CommonPage> {
  // void showExplain() {
  //   final popup = BeautifulPopup.customize(
  //     context: context,
  //     build: (options) => ExplainTemplate(options),
  //   );
  //   popup.show(
  //       title: Text(
  //         '功能说明',
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           fontSize: BaseStyle.fontSize32,
  //           color: Color(0xff15c0ec),
  //         ),
  //       ),
  //       content: Text(
  //         '点击“呼叫110”后,您可以直接拨打本地110。页面中提供了您当前所在位置,以便您与警方沟通。(GPS信号弱时，位置可能存在偏移)',
  //         style: TextStyle(
  //           fontSize: BaseStyle.fontSize28,
  //           color: BaseStyle.color666666,
  //         ),
  //       ),
  //       actions: [
  //         MaterialButton(
  //           color: Color(0xff15c0ec),
  //           textColor: Colors.white,
  //           shape: RoundedRectangleBorder(
  //               side: BorderSide.none,
  //               borderRadius: BorderRadius.all(Radius.circular(50))),
  //           child: Text('关闭'),
  //           onPressed: Navigator.of(context).pop,
  //         )
  //       ],
  //       close: SizedBox());
  // }

  void recordRouter() {
    Navigator.pushNamed(context, PageName.common_page.toString(),
        arguments: Bundle()
          ..putMap('commentMap', {'title': '访客记录', 'isActions': false}));
  }

  void evaluateRouter(bool isAlone, bool isPropose) {
    Navigator.pushNamed(context, PageName.common_page.toString(),
        arguments: Bundle()
          ..putMap('commentMap', {
            'title': '评价',
            'isActions': false,
            'isAlone': isAlone,
            'isPropose': isPropose
          }));
  }

  InkWell _inkWellSearch() {
    return InkWell(
      onTap: () {
        showSearch(context: context, delegate: searchBarDelegate());
      },
      child: Container(
        margin: EdgeInsets.only(right: 32.w),
        padding: EdgeInsets.only(
            left: 40.w,
            top: 15.w,
            bottom: 15.w),
        decoration: BoxDecoration(
          color: BaseStyle.colorf3f3f3,
          borderRadius: BorderRadius.all(Radius.circular(36)),
        ),
        child: Row(children: [
          Icon(
            AntDesign.search1,
            size: BaseStyle.fontSize28,
            color: BaseStyle.color999999,
          ),
          SizedBox(width: 5),
          Text(
            '搜索商品、活动、帖子、应用',
            style: TextStyle(
              fontSize: BaseStyle.fontSize28,
              color: BaseStyle.color999999,
            ),
          )
        ]),
      ),
    );
  }

  AppBar _commentAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Color(0xffffffff),
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: Icon(AntDesign.left, size: 40.sp),
      ),
      centerTitle: true,
      title: Builder(builder: (_) {
        switch (widget.bundle.getMap('commentMap')['title']) {
          case '全部应用':
          case '分类':
            return _inkWellSearch();
            break;
          default:
            return Text(
              widget.bundle.getMap('commentMap')['title'] == '更多活动'
                  ? '社区活动'
                  : widget.bundle.getMap('commentMap')['title'],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 32.sp,
                color: Color(0xff333333),
              ),
            );
            break;
        }
      }),
      actions: widget.bundle.getMap('commentMap')['isActions']
          ? [
              InkWell(
                onTap: () {
                  switch (widget.bundle.getMap('commentMap')['title']) {
                    case '访客通行':
                    case '我的访客':
                      recordRouter();
                      break;
                    case '查看详情':
                      evaluateRouter(
                        widget.bundle.getMap('commentMap')['isAlone'],
                        widget.bundle.getMap('commentMap')['isPropose'],
                      );
                      break;
                    case '生活缴费':
                      Navigator.pushNamed(
                          context, PageName.common_page.toString(),
                          arguments: Bundle()
                            ..putMap('commentMap',
                                {'title': '缴费记录', 'isActions': false}));
                      break;
                    case '借还管理':
                      Navigator.pushNamed(
                          context, PageName.common_page.toString(),
                          arguments: Bundle()
                            ..putMap('commentMap',
                                {'title': '我的借还物品', 'isActions': false}));
                      break;
                    case '我的地址':
                      Navigator.pushNamed(
                          context, PageName.common_page.toString(),
                          arguments: Bundle()
                            ..putMap('commentMap', {
                              'title': '添加新地址',
                              'isActions': true,
                              'isNew': true
                            }));
                      break;
                    case '一键报警':
                      // showExplain();
                      break;
                    default:
                      break;
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(right: 32.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Builder(builder: (_) {
                        String title = '';
                        switch (widget.bundle.getMap('commentMap')['title']) {
                          case '访客通行':
                          case '我的访客':
                            title = '访客记录';
                            break;
                          case '查看详情':
                            title = '评价';
                            break;
                          case '消息中心':
                            title = '全部已读';
                            break;
                          case '系统通知':
                          case '评论通知':
                          case '商城通知':
                            title = '清空';
                            break;
                          case '生活缴费':
                            title = '缴费记录';
                            break;
                          case '借还管理':
                            title = '我的借还物品';
                            break;
                          case '我的地址':
                            title = '添加新地址';
                            break;
                          case '添加新地址':
                          case '编辑地址':
                            title = '保存';
                            break;
                          case '一键报警':
                            title = '功能说明';
                            break;
                          default:
                            title = '编辑';
                            break;
                        }
                        return Text(
                          title,
                          style: TextStyle(
                            fontSize: 28.sp,
                            color: Color(0xff333333),
                          ),
                        );
                      })
                    ],
                  ),
                ),
              ),
            ]
          : [],
    );
  }

  @override
  Widget build(BuildContext context) {
    double _statusHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: PreferredSize(
        child: _commentAppBar(),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Builder(builder: (_) {
        switch (widget.bundle.getMap('commentMap')['title']) {
          // case '访客通行':
          // case '我的访客':
          //   return VisitorInvitation(statusHeight: _statusHeight);
          // case '访客记录':
          //   return VisitorRecord();
          // case '访客通行证':
          //   return VisitorPass();
          case '便民电话':
            // return ComplaintCall();
          case '业委会':
            // return IndustryCommittee();
          case '建议咨询':
          case '报事报修':
          // case '我的报修':
          //   return ThingsMain(
          //     isPropose: widget.bundle.getMap('commentMap')['isPropose'],
          //     isAlone: widget.bundle.getMap('commentMap')['isAlone'],
          //   );
          // case '新增':
          // case '新增报修':
          //   return ThingsCreate(
          //       statusHeight: _statusHeight,
          //       isPropose: widget.bundle.getMap('commentMap')['isPropose']);
          // case '查看详情':
          //   return ThingsDetail(
          //     content: widget.bundle.getMap('commentMap')['content'],
          //     time: widget.bundle.getMap('commentMap')['time'],
          //     imageList: widget.bundle.getMap('commentMap')['imageList'],
          //     isPropose: widget.bundle.getMap('commentMap')['isPropose'],
          //     isAlone: widget.bundle.getMap('commentMap')['isAlone'],
          //   );
          // case '评价':
          //   return ThingsEvaluate(
          //     isAlone: widget.bundle.getMap('commentMap')['isAlone'],
          //     isPropose: widget.bundle.getMap('commentMap')['isPropose'],
          //     statusHeight: _statusHeight,
          //   );
          // case '继续提问':
          //   return ThingsEvaluate(
          //     isAlone: false,
          //     isPropose: true,
          //     statusHeight: _statusHeight,
          //   );
          // case '消息中心':
          //   return MessageCenter(statusHeight: _statusHeight);
          // case '系统通知':
          //   return SystemNotice();
          // case '评论通知':
          //   return CommentNotice(statusHeight: _statusHeight);
          // case '商城通知':
          //   return ShopNotice();
          // case '退款详情':
          //   return RefundDetails(statusHeight: _statusHeight);
          // case '我的房屋':
          //   return HouseMain(statusHeight: _statusHeight);
          // case '房屋认证':
          //   return HouseAuthenticate(statusHeight: _statusHeight);
          // case '我的车位':
          //   return CarMain(
          //       statusHeight: _statusHeight, type: '车位', buttonName: '+新增车位');
          // case '我的车':
          //   return CarMain(
          //       statusHeight: _statusHeight, type: '车', buttonName: '+新增车辆');
          // case '选择小区':
          //   return CarMain(
          //       statusHeight: _statusHeight, type: '车', buttonName: '+新增车辆');
          // case '车位列表':
          //   return CarMain(
          //       statusHeight: _statusHeight, type: '车', buttonName: '+新增车辆');
          // case '添加车辆':
          //   return CarAdd(statusHeight: _statusHeight);
          // case '设置':
          //   return Setting();
          // case '关于小蜜蜂智慧社区':
          //   return About();
          // case '邀请注册':
          //   return Invite();
          // case '意见反馈':
          //   return FeedBack(statusHeight: _statusHeight);
          case '活动投票':
            // return ActivityMain(isVote: true);
          case '更多活动':
          case '社区活动':
            // return ActivityMain(isVote: false);
          case '活动详情':
            // return ActivityDetails(
            //   title: widget.bundle.getMap('commentMap')['name'],
            //   imagePath: widget.bundle.getMap('commentMap')['imagePath'],
            //   isVote: widget.bundle.getMap('commentMap')['isVote'],
            //   isOver: widget.bundle.getMap('commentMap')['isOver'],
            //   isVoteOver: widget.bundle.getMap('commentMap')['isVoteOver'],
            //   memberList: widget.bundle.getMap('commentMap')['memberList'],
            // );
          case '参与人员':
            // return ActivityMemberList();
          // case '问卷调查':
          //   return widget.bundle.getMap('commentMap')['imagePath'] != null
          //       ? QuestionnaireDetails(
          //           imagePath: widget.bundle.getMap('commentMap')['imagePath'],
          //           title: widget.bundle.getMap('commentMap')['name'],
          //         )
          //       : QuestionnaireMain();
          // case '物品出户':
          //   return GoodsOutMain();
          // case '新增物品出户':
          //   return GoodsOutCreate();
          // case '装修管理':
          //   return FitupManageMain();
          // case '生活缴费':
          // case '我的缴费':
          //   return LifePayMain();
          // case '明细':
          //   return LifePayInfo();
          // case '账单详情':
          //   return LifePayBill();
          // case '缴费记录':
          //   return LifePayRecord();
          // case '借还管理':
          //   return GoodsManageMain();
          // case '我的借还物品':
          //   return MineGoodsManage();
          // case '社区公告':
          //   return NoticeMain(
          //     title: widget.bundle.getMap('commentMap')['theme'],
          //     imagePath: widget.bundle.getMap('commentMap')['imagePath'],
          //   );
          // case '我的地址':
          //   return AddressMain();
          // case '添加新地址':
          // case '编辑地址':
          //   return AddressEdit(
          //       isNew: widget.bundle.getMap('commentMap')['isNew']);
          // case '确认订单':
          //   return ConfirmOrder();
          // case '付款方式':
          //   return PayOrder();
          case '全部应用':
            // return TotalApplicationsMain();
          case '分类':
            // return ShopClassMain(statusHeight: _statusHeight);
          case '一键报警':
            // return OneAlarmMain();
          // case '一键开门':
          //   return OpenDoorMain();
          case '实名认证':
            // return CertificationMain();
          // case '功能说明':
          //   return Explain();
          default:
            return Container();
        }
      }),
    );
  }
}

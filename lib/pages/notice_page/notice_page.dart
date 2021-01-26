// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_html/flutter_html.dart';

// Project imports:
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';

const htmlData = '''
  <p>今天，宁波市住房和城乡建设局、宁波市自然资源和规
  划局联合发布《关于进一步完善商品住房销售行为切实
  保障居民自住需求的通知》（以下简称《通知》）。该
  《通知》旨在保障居民自住需求，抑制投机投资行为，
  《通知》明确符合条件的“无房家庭”可在市六区优先认
  购1套商品住房，该套住房要求在取得不动产权属证书
  满5年后方可转让。该新政从发布之日起实施。<br /><br /><br />
  根据《通知》要求，我市海曙区、江北区、镇海区、北
  仑区、鄞州区、奉化区（以下简称“市六区”）行政区域
  内无住房且符合下列条件之一的家庭，可以按照本通知
  要求优先认购1套商品住房：<br />
  一是，家庭成员（配偶双方及未成年子女）之一具有市
  六区户籍的；<br />
  二是，近三年内在市六区已连续缴纳24个月及以上社会
  保险的；<br />
  三是，本人或配偶属于本市引进的顶尖人才、特优人才、
  领军人才、拔尖人才、高级人才的。以上三类家庭统称
  “无房家庭”。<br />
  “无房家庭”优先认购的商品住房，须取得不动产权属证
  书满5年后方可转让。<br /><br /><br />

  通知》要求，购房意向人通过市房产交易网或移动端
  APP登记购房意向，包括商品住宅项目名称、是否为“无
  房家庭”、购房人姓名及身份证明、户籍所在地、联系
  方式等，并上传相关资料。购房意向人在项目售楼处现
  场登记购房意向的，房地产开发企业应当协助其进行线
  上登记并上传相关资料。<br />
  申报“无房家庭”购房资格的，购房意向人应当提供家庭
  成员信息并上传相关证明，非本市户籍家庭还需上传社
  会保险缴纳证明或者人才证明。《通知》还明确，房地
  产开发企业不得擅自泄露、使用购房意向人提供的相关
  信息。<br />
  参加优先认购的“无房家庭”，自购房意向登记之日起至
  该项目优先认购活动结束当日止，不得参加其他任何项
  目的购房意向登记。<br />
  房地产开发企业应当通过宁波市房产交易监管服务平台
  对参加优先认购的“无房家庭”住房情况进行查询。经查
  询没有住房的，登记为“无房家庭”，并在市房产交易网
  公示；经查询有住房的，登记为有房家庭并告知购房意
  向人。<br />
  购房意向人对查询结果有异议的，可以向商品住宅项目
  所在地住建部门申请复查。经复查，符合“无房家庭”要
  求的，由当地住建部门出具相关证明，纳入公示名单。
  商品住宅项目所在地住建部门应当就“无房家庭”公示名
  单进行抽查，发现登记有误的，及时修正公示名单。<br />
 </p>
''';


class NoticePage extends StatelessWidget {
  final Bundle bundle;
  NoticePage({Key key,this.bundle}) : super(key: key);

  Widget _creater() {
    return Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 12.w),
            child: ClipOval(
              child: CachedImageWrapper(
                url:
                    'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1380335538,732392216&fm=26&gp=0.jpg',
                width: 45.w,
                height: 45.w,
              ),
            ),
          ),
          RichText(
            text: TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: '管理员 ',
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: Color(0xff999999),
                  ),
                ),
                TextSpan(
                  text: ' 发布于  ',
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: Color(0xff666666),
                  ),
                ),
                TextSpan(
                  text: '2020-08-12',
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: Color(0xff999999),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '社区公告',
      body: Stack(
      children: [
        Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.only(
                top: 26.w,
                left: 32.w,
                right: 32.w,
                bottom: 60.w),
            children: [
              Text(
                bundle.getMap('details')['title'],
                style: TextStyle(
                    fontSize: 32.sp,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w600,),
              ),
              Container(
                margin: EdgeInsets.only(top: 45.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  child: CachedImageWrapper(
                    url: bundle.getMap('details')['imagePath'],
                    width: 686.w,
                    height: 228.w,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 44.w),
                width: 647.w,
                child: Html(data: htmlData),
              ),
              _creater(),
            ],
          ),
        ),
      ],
    ),
    );
  }
}



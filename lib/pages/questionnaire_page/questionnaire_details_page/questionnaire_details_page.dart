import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:akuCommunity/utils/headers.dart';
import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/widget/cached_image_wrapper.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';
import 'package:akuCommunity/routers/page_routers.dart';

class QuestionnaireDetailsPage extends StatefulWidget {
  final Bundle bundle;
  QuestionnaireDetailsPage({Key key, this.bundle}) : super(key: key);

  @override
  _QuestionnaireDetailsPageState createState() =>
      _QuestionnaireDetailsPageState();
}

const htmlData = '''
    <p>亲爱的家长朋友，您好！很高兴您为孩子选择了狮子画
    室的课程。<br/>
    为了能够在上课中，更好的了解咱们孩子的学习情况和
    上课感受，更针对性的给孩子们提供更好的学习服务，
    现诚邀请您填写我们的课程满意度调查问卷。所有问卷
    信息严格保密，请放心填写。
  </p>
''';

class _QuestionnaireDetailsPageState extends State<QuestionnaireDetailsPage> {
  TextEditingController _ideaContent = new TextEditingController();

  String hintText = '您的宝贵意见是我们前进的明灯';

  List<Map<String, dynamic>> _listQuestion = [
    {
      'title': '您的身份是？',
      'option': <Map<String, dynamic>>[
        {'title': '学员', 'isCheck': false},
        {'title': '家长', 'isCheck': false}
      ]
    },
    {
      'title': '您所学习的课程是？',
      'option': <Map<String, dynamic>>[
        {'title': '儿童美术', 'isCheck': false},
        {'title': '素描', 'isCheck': false},
        {'title': '国画', 'isCheck': false},
        {'title': '漫画', 'isCheck': false},
        {'title': '书法', 'isCheck': false},
        {'title': '陶艺', 'isCheck': false}
      ]
    },
    {
      'title': '您选择我们的原因是？',
      'option': <Map<String, dynamic>>[
        {'title': '师资力量', 'isCheck': false},
        {'title': '教学口碑', 'isCheck': false},
        {'title': '地理位置', 'isCheck': false},
        {'title': '其他人介绍', 'isCheck': false}
      ]
    },
    {
      'title': '学习后孩子的成绩是否有所提升？',
      'option': <Map<String, dynamic>>[
        {'title': '有很大变化有很大变化有很大变化有很大变化有很大变化有很大变化', 'isCheck': false},
        {'title': '变化一般', 'isCheck': false},
        {'title': '没变化', 'isCheck': false}
      ]
    }
  ];

  Widget _questionCard(String title, List<Map<String, dynamic>> optionList) {
    return Container(
      margin: EdgeInsets.only(top:64.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: BaseStyle.fontSize32,
              color: BaseStyle.color4a4b51,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 64.w),
            child: Wrap(
              runSpacing: 48.w,
              children: optionList
                  .map((item) => InkWell(
                        onTap: () {
                          setState(() {
                            item['isCheck'] = !item['isCheck'];
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(left:15.w),
                          width: MediaQuery.of(context).size.width / 2.35,
                          child: Row(
                            children: [
                              Icon(
                                item['isCheck']
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_unchecked,
                                color: item['isCheck']
                                    ? BaseStyle.colorffc40c
                                    : BaseStyle.color979797,
                                size: 32.w,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 16.w),
                                width: MediaQuery.of(context).size.width / 3.2,
                                child: Text(
                                  item['title'],
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontWeight: item['isCheck']
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                    fontSize: BaseStyle.fontSize28,
                                    color: BaseStyle.color4a4b51,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _containerTextField() {
    return Container(
      padding: EdgeInsets.only(
          top: 24.w,
          left: 24.w,
          right: 32.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        border: Border.all(color: Color(0xffd4cfbe), width: 1.0),
      ),
      child: TextFormField(
        cursorColor: Color(0xffffc40c),
        style: TextStyle(
          fontSize: BaseStyle.fontSize28,
          fontWeight: FontWeight.w600,
        ),
        controller: _ideaContent,
        onChanged: (String value) {},
        maxLines: 10,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(
            top: 0,
            bottom: 0,
          ),
          hintText: hintText,
          border: InputBorder.none, //去掉输入框的下滑线
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
            color: BaseStyle.color999999,
            fontSize: BaseStyle.fontSize28,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _positionedBottomBar() {
    return Positioned(
      bottom: 0,
      child: Container(
        alignment: Alignment.center,
        height: 98.w,
        width: MediaQuery.of(context).size.width,
        child: InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            color: BaseStyle.colorffc40c,
            padding: EdgeInsets.symmetric(
              vertical: 26.5.w,
            ),
            child: Text(
              '确认提交',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: BaseStyle.fontSize32,
                color: ktextPrimary,
              ),
            ),
          ),
        ),
      ),
    );
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
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 32.w,
                right: 32.w,
                bottom: 155.w,
              ),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 24.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(4.w)),
                      child: CachedImageWrapper(
                        url: widget.bundle.getMap('details')['imagePath'],
                        width: 686.w,
                        height: 228.w,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40.w),
                    alignment: Alignment.center,
                    child: Text(
                      widget.bundle.getMap('details')['title'],
                      style: TextStyle(
                        fontSize: BaseStyle.fontSize32,
                        color: BaseStyle.color4a4b51,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35.w),
                    alignment: Alignment.center,
                    width: 672.w,
                    child: Html(data: htmlData),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 129.w),
                    child: Column(
                      children: _listQuestion
                          .map((item) => _questionCard(
                                item['title'],
                                item['option'],
                              ))
                          .toList(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 80.w,
                        bottom: 24.w),
                    child: Text(
                      '您的觉得我们需要改进的地方',
                      style: TextStyle(
                          fontSize: BaseStyle.fontSize28,
                          color: ktextPrimary),
                    ),
                  ),
                  _containerTextField(),
                ],
              ),
            ),
            _positionedBottomBar(),
          ],
        ),
      ),
    );
  }
}

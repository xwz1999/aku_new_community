import 'package:akuCommunity/base/base_style.dart';
import 'package:akuCommunity/pages/things_page/widget/image_grid.dart';
import 'package:akuCommunity/utils/bee_map.dart';
import 'package:akuCommunity/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:akuCommunity/extensions/num_ext.dart';
import 'package:akuCommunity/extensions/widget_list_ext.dart';

class FixedSubmitPage extends StatefulWidget {
  FixedSubmitPage({Key key}) : super(key: key);

  @override
  _FixedSubmitPageState createState() => _FixedSubmitPageState();
}

class FixedSubmitMode {
  int tag;
  int state;
  String text;
  List<String> images;
  FixedSubmitMode(this.tag, this.state, this.text, this.images);
}

class _FixedSubmitPageState extends State<FixedSubmitPage> {
  List<FixedSubmitMode> _model = [
    FixedSubmitMode(1, 0, '家里的冰箱坏了，师傅赶紧来看看', <String>[
      'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=466219337,2269488732&fm=15&gp=0.jpg',
      'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=907707978,1526051881&fm=26&gp=0.jpg',
    ]),
    FixedSubmitMode(0, 3, '我觉得我们小区的绿化可以再多一点', <String>[
      'https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=111636878,534819054&fm=26&gp=0.jpg',
      'https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3834533673,769780989&fm=26&gp=0.jpg',
      'https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1683501076,3787404077&fm=26&gp=0.jpg',
      'https://dss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1040644610,2290865162&fm=26&gp=0.jpg',
    ]),
  ];
  Color _getColor(int state) {
    switch (state) {
      case 0:
      case 1:
        return kDarkPrimaryColor;
      case 2:
      case 3:
      case 4:
        return ktextSubColor;
      default:
        return kPrimaryColor;
    }
  }

  Widget _buildCard(int fixedTag, int state, String text, List<String> images) {
    return Container(
      decoration: BoxDecoration(
          color: kForeGroundColor, borderRadius: BorderRadius.circular(8.w)),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              BeeMap()
                  .fixTag[fixedTag]
                  .text
                  .color(ktextPrimary)
                  .bold
                  .size(32.sp)
                  .make(),
              Spacer(),
              BeeMap()
                  .fixState[state]
                  .text
                  .color(_getColor(state))
                  .size(24.sp)
                  .make(),
            ],
          ),
          24.hb,
          Divider(
            thickness: 1.w,
            height: 0,
          ),
          24.hb,
          text.text.color(ktextSubColor).size(28.sp).ellipsis.make(),
          16.hb,
          images.length != 0 ? ImageGrid(images) : SizedBox(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '报事报修',
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(32.w),
              children: [
                ..._model
                    .map((e) => _buildCard(e.tag, e.state, e.text, e.images))
                    .toList()
              ].sepWidget(separate: 24.hb),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: MaterialButton(
              color: kPrimaryColor,
              onPressed: () {},
              child: '新增'.text.bold.color(ktextPrimary).size(32.sp).make(),
              minWidth: double.infinity,
              height: 98.w,
              elevation: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.zero,
            ),
          )
        ],
      ),
    );
  }
}

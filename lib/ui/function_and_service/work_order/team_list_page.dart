import 'package:aku_new_community/extensions/num_ext.dart';
import 'package:aku_new_community/gen/assets.gen.dart';
import 'package:aku_new_community/models/work_order/team_list_model.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

class TeamListPage extends StatefulWidget {
  const TeamListPage({Key? key}) : super(key: key);

  @override
  _TeamListPageState createState() => _TeamListPageState();
}

class _TeamListPageState extends State<TeamListPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '服务团队名单',
      body: ListView(
        children: [
          _PositionTile('主负责人'),
          ...[].map((e) => _personTile(e)).toList()
        ],
      ),
    );
  }

  Widget _personTile(TeamListModel model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.w),
      width: double.infinity,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.red,
          ),
          16.wb,
          Column(
            children: [
              model.name.text
                  .size(28.sp)
                  .color(Colors.black.withOpacity(0.85))
                  .make(),
              8.hb,
              model.position.text
                  .size(24.sp)
                  .color(Colors.black.withOpacity(0.45))
                  .make(),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () async {
              await launch('tel:${model.tel}');
            },
            child: Assets.icons.phone.image(width: 40.w, height: 40.w),
          )
        ],
      ),
    );
  }

  Widget _PositionTile(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.w),
      width: double.infinity,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 26.sp,
          color: Colors.black.withOpacity(0.45),
        ),
      ),
    );
  }
}

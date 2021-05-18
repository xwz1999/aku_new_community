import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:aku_community/const/resource.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class CommunityIntroducePage extends StatefulWidget {
  CommunityIntroducePage({Key? key}) : super(key: key);

  @override
  _CommunityIntroducePageState createState() => _CommunityIntroducePageState();
}

class _CommunityIntroducePageState extends State<CommunityIntroducePage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      bodyColor: Colors.white,
      title: '社区介绍',
      body: ListView(
        children: [
          SizedBox(
            child: Image.asset(
              R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
              fit: BoxFit.cover,
            ),
            width: double.infinity,
            height: 424.w,
          ),
          24.w.heightBox,
          '''      小区内部环境典雅幽静，绿化多，通过小区道路的合理组织，休闲设施的精心安排，提供自然、舒适的居住环境。周边配套齐全，设施完备，物业管理完善，保安24小时值班，住户素质高。社区主流健康向上，社区风气良好，邻里关系和谐。
      基础设施健全，周围商圈多，购物，就医，娱乐等方便快捷。为一个集生态环境、人文环境、信息化和管理控制自动化等优质服务为一体的高档个性化住宅小区。
      环境优美，丽水成天的风景给予了回归家庭、回归私域的生活体验。房屋楼层分布均匀，室内装修豪华气派，视眼非常宽广，采光较好。
      坐北朝南，整体体现现代简约风格，建筑设计线条明朗，色彩大气简约，采用中间高、东西低的建筑高度，使小区建筑形态层次分明，富有强烈韵律感。
      居于此，拥城市繁华、享离尘静谧，自由掌控生活，占核心享未来 。'''
              .text
              .size(28.sp)
              .color(ktextPrimary)
              .make(),
        ],
      ),
    );
  }
}

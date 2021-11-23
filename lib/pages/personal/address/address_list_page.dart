import 'dart:ui';

import 'package:aku_community/model/user/adress_model.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import 'package:aku_community/constants/api.dart';
import 'package:aku_community/model/common/img_model.dart';
import 'package:aku_community/model/community/community_topic_model.dart';
import 'package:aku_community/pages/things_page/widget/bee_list_view.dart';
import 'package:aku_community/ui/community/community_views/topic/topic_detail_page.dart';
import 'package:aku_community/utils/headers.dart';

import '../item_my_address.dart';
import '../user_func.dart';
import 'new_address_page.dart';

class AddressListPage extends StatefulWidget {
  AddressListPage({Key? key}) : super(key: key);

  @override
  AddressListPageState createState() => AddressListPageState();
}

class AddressListPageState extends State<AddressListPage>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _refreshController = EasyRefreshController();
  bool _onload = true;
  List<AddressModel> _addressModels = [];
  refresh() {
    _refreshController.callRefresh();
  }

  _buildItem(CommunityTopicModel model) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 53.w, vertical: 20.w),
      onPressed: () {
        Get.to(() => TopicDetailPage(model: model));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            // tag: "${model.firstImg}_${model.id}",
            tag: model.hashCode.toString(),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.w),
                color: Colors.black12,
              ),
              child: Stack(
                children: [
                  FadeInImage.assetNetwork(
                    placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                    image: API.image(ImgModel.first(model.imgUrl)),
                    height: 160.w,
                    width: 250.w,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(8.w),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: ('#${model.summary}')
                            .text
                            .center
                            .size(28.sp)
                            .white
                            .make()
                            .material(color: Colors.black26),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          12.wb,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (model.title ?? '')
                  .text
                  .maxLines(2)
                  .size(28.sp)
                  .bold
                  .overflow(TextOverflow.ellipsis)
                  .make(),
              (model.content ?? '')
                  .text
                  .maxLines(1)
                  .size(22.sp)
                  .color(Color(0xFF666666))
                  .overflow(TextOverflow.ellipsis)
                  .make(),
              21.hb,
              [
                Spacer(),
                Image.asset(
                  R.ASSETS_ICONS_HOT_FIRE_PNG,
                  height: 24.w,
                  width: 24.w,
                ),
                12.wb,
                '${model.activityNum}'
                    .text
                    .maxLines(1)
                    .size(22.sp)
                    .overflow(TextOverflow.ellipsis)
                    .make()
              ].row(),
            ],
          ).box.make().expand(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return  BeeScaffold(
      title: '我的收货地址',
      bottomNavi: GestureDetector(
        onTap: ()async{
          bool? result =  await  Get.to(() => NewAddressPage(isFirstAdd: _addressModels.isEmpty? true:false,));
          if(result!=null){
            if(result) _refreshController.callRefresh();
          }
        },
        child: Container(
          margin: EdgeInsets.only(left: 100.w,right: 100.w,bottom: 100.w),
          alignment: Alignment.center,
          child: '新增收货地址'.text.size(28.sp).white.make(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(left:  Radius.circular(49.w),right:  Radius.circular(49.w)),
            color: Color(0xFFE52E2E),
          ),
          width: 522.w,
          height: 98.w,

        ),
      ),
      body:EasyRefresh(
        firstRefresh: true,
        header: MaterialHeader(),
        controller: _refreshController,
        onRefresh: () async {
          _addressModels = await Userfunc.getMyAddress();
          _onload =false;
          setState(() {});
        },
        child: _onload
            ? SizedBox()
            : ListView(
          padding: EdgeInsets.all(20.w),
          children: [
            ..._addressModels.map((e) => MyAddressItem(addressModel: e,refreshController: _refreshController,
      )).toList(),
            //
            // ..._newItems.map((e) => ChatCard(
            //   model: e,
            //
            // )).toList()
          ],
        ),
      ),

    );


  }

  @override
  bool get wantKeepAlive => true;
}

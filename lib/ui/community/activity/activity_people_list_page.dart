
import 'package:aku_new_community/constants/saas_api.dart';
import 'package:aku_new_community/model/common/img_model.dart';

import 'package:aku_new_community/models/home/activity_detail_model.dart';

import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:flutter/material.dart';


class ActivityPeopleListPage extends StatefulWidget {
  final List<Registration>? registrationList;

  ActivityPeopleListPage({Key? key, required this.registrationList}) : super(key: key);

  @override
  _ActivityPeopleListPageState createState() => _ActivityPeopleListPageState();
}

class _ActivityPeopleListPageState extends State<ActivityPeopleListPage> {


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '报名人员列表',
      body:
          Column(

            children: [
              Container(
                color: Colors.black.withOpacity(0.06),
                height: 75.w,
                width: double.infinity,
                alignment: Alignment.center,
                child:   '已有'.richText.color(Colors.black.withOpacity(0.65)).size(28.sp).withTextSpanChildren([
                  widget.registrationList==null?''.textSpan
                      .size(28.sp)
                      .color(Color(0xFFFA5858))
                      .make(): '${widget.registrationList!.length}'
                      .textSpan
                      .size(28.sp)
                      .color(Color(0xFFFA5858))
                      .make(),
                  '人报名参加本次活动'.textSpan.size(28.sp).color(Colors.black.withOpacity(0.65)).make(),
                ]).make(),
              ),


              widget.registrationList!=null?
              ListView.separated(
                padding: EdgeInsets.all(32.w),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      132.hb,
                      20.wb,
                      Material(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(40.w),
                        clipBehavior: Clip.antiAlias,
                        child: FadeInImage.assetNetwork(
                          placeholder: R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                          image: SAASAPI.image(ImgModel.first(widget.registrationList![index].avatarImgList)),
                          height: 80.w,
                          width: 80.w,
                          fit: BoxFit.fill,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
                              width: 80.w,
                              height: 80.w,
                            );
                          },
                        ),
                      ),
                      18.wb,
                      '${getName(widget.registrationList![index].name) }'.text.size(28.sp).make(),
                    ],
                  );
                },
                separatorBuilder: (_, __) => Divider(height: 1.w),
                itemCount: widget.registrationList!.length,
              ):SizedBox(),
            ],
          )

    );
  }


  getName(String name){
    for(int i=0;i<name.length;i++){
      if(i>0){
        name = name.replaceRange(i, i+1, '*') ;
      }

    }


    return name;
  }
}

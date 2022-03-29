import 'package:aku_new_community/saas_model/login/community_model.dart';
import 'package:aku_new_community/widget/others/bee_search_text_field.dart';
import 'package:aku_new_community/widget/picker/bee_picker_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeeCommunityPicker extends StatefulWidget {
  static Future<CommunityModel?> pick(
      BuildContext context, List<CommunityModel> communities) async {
    return await showModalBottomSheet(
      context: context,
      builder: (context) {
        return BeeCommunityPicker(
          communities: communities,
        );
      },
    );
  }

  final List<CommunityModel> communities;

  const BeeCommunityPicker({Key? key, required this.communities})
      : super(key: key);

  @override
  _BeeCommunityPickerState createState() => _BeeCommunityPickerState();
}

class _BeeCommunityPickerState extends State<BeeCommunityPicker> {
  TextEditingController _searchController = TextEditingController();
  CommunityModel? _pickedCommunity;
  List<CommunityModel> _communities = [];

  List<CommunityModel> screenList(String text) {
    var list = <CommunityModel>[];
    widget.communities.forEach((element) {
      if (element.name.contains(text)) {
        list.add(element);
      }
    });
    return list;
  }

  @override
  void initState() {
    _communities = widget.communities;
    if (widget.communities.isNotEmpty) {
      _pickedCommunity = widget.communities[0];
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeePickerBox(
      title: '选择小区',
      confirmString: '确定',
      onPressed: () {
        Navigator.pop(context, _pickedCommunity);
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            BeeSearchTextField(
              controller: _searchController,
              hintText: '请输入小区名称搜索',
              onChanged: (text) {
                _communities = screenList(text);
                setState(() {});
              },
            ),
            Expanded(
              child: CupertinoPicker(
                itemExtent: 80.w,
                looping: false,
                onSelectedItemChanged: (index) {
                  _pickedCommunity = _communities[index];
                },
                children: _communities.isEmpty
                    ? [Container()]
                    : _communities
                        .map((e) => Center(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 8.w, right: 40.w),
                                child:
                                    Text(e.name, textAlign: TextAlign.center),
                              ),
                            ))
                        .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

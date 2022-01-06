import 'package:aku_new_community/constants/api.dart';
import 'package:aku_new_community/utils/headers.dart';
import 'package:aku_new_community/utils/network/base_model.dart';
import 'package:aku_new_community/utils/network/net_util.dart';
import 'package:aku_new_community/widget/bee_scaffold.dart';
import 'package:aku_new_community/widget/buttons/bottom_button.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AdviceAddCommentPage extends StatefulWidget {
  final int? id;

  AdviceAddCommentPage({Key? key, required this.id}) : super(key: key);

  @override
  _AdviceAddCommentPageState createState() => _AdviceAddCommentPageState();
}

class _AdviceAddCommentPageState extends State<AdviceAddCommentPage> {
  TextEditingController _textEditingController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '继续回复',
      body: ListView(
        padding: EdgeInsets.all(32.w),
        children: [
          '请输入内容'.text.size(28.sp).make(),
          24.hb,
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _textEditingController,
              validator: (text) {
                if (TextUtil.isEmpty(text)) return '内容不能为空';
                return null;
              },
              minLines: 7,
              maxLines: 99,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFD4CFBE),
                    width: 1.w,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 32.w,
                  horizontal: 22.w,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavi: BottomButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            BaseModel baseModel = await NetUtil().post(
              API.manager.adviceQuestion,
              params: {
                'adviceId': widget.id,
                'content': _textEditingController.text,
                'parentId': 0,
              },
              showMessage: true,
            );
            if (baseModel.success) {
              Get.back(result: true);
            }
          }
        },
        child: '提交'.text.bold.make(),
      ),
    );
  }
}

import 'package:aku_community/base/base_style.dart';
import 'package:aku_community/ui/profile/house/upload_contracts_page.dart';
import 'package:aku_community/widget/bee_scaffold.dart';
import 'package:aku_community/widget/others/finish_result_image.dart';
import 'package:aku_community/widget/views/%20bee_download_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:velocity_x/velocity_x.dart';

class DownLoadContractPage extends StatefulWidget {
  final String path;
  final int id;
  DownLoadContractPage({
    Key? key,
    required this.path,
    required this.id,
  }) : super(key: key);

  @override
  _DownLoadContractPageState createState() => _DownLoadContractPageState();
}

class _DownLoadContractPageState extends State<DownLoadContractPage> {
  @override
  Widget build(BuildContext context) {
    return BeeScaffold(
      title: '合同信息',
      body: Center(
        child: Column(
          children: [
            80.w.heightBox,
            FinishResultImage(status: true),
            48.w.heightBox,
            '${'生成成功'}'.text.size(36.sp).color(ktextPrimary).make(),
            24.w.heightBox,
            '请下载合同'.text.size(26.sp).color(ktextSubColor).make(),
            '完善信息并盖章后再上传合同'.text.size(26.sp).color(ktextSubColor).make(),
            126.w.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: Colors.white,
                    elevation: 0,
                    minWidth: 280.w,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFF666666), width: 1.w)),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.w, horizontal: 78.w),
                    onPressed: () async {
                      String? result = await Get.dialog(BeeDownloadView(
                        file: widget.path,
                      ));
                      if (result != null) OpenFile.open(result);
                    },
                    child:
                        '下载合同'.text.size(32.sp).bold.color(ktextPrimary).make(),
                  ),
                  62.w.widthBox,
                  MaterialButton(
                    minWidth: 280.w,
                    padding:
                        EdgeInsets.symmetric(vertical: 16.w, horizontal: 78.w),
                    elevation: 0,
                    color: kPrimaryColor,
                    onPressed: () {
                      Get.to(() => UploadContractsPage(
                            id: widget.id,
                          ));
                    },
                    child:
                        '上传文件'.text.size(32.sp).bold.color(ktextPrimary).make(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

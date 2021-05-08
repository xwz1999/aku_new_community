import 'package:flutter/material.dart';

import 'package:aku_community/ui/home/public_infomation/public_infomation_card.dart';
import 'package:aku_community/utils/headers.dart';

class PublicInfomationView extends StatefulWidget {
  PublicInfomationView({Key? key}) : super(key: key);

  @override
  _PublicInfomationViewState createState() => _PublicInfomationViewState();
}

class _PublicInfomationViewState extends State<PublicInfomationView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 24.w),
      itemBuilder: (context, index) {
        return PublicInfomationCard();
      },
      separatorBuilder: (_, __) => 24.hb,
      itemCount: 100,
    );
  }
}

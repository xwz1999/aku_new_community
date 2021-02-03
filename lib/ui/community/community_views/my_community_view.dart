import 'package:flutter/material.dart';

class MyCommunityView extends StatefulWidget {
  MyCommunityView({Key key}) : super(key: key);

  @override
  _MyCommunityViewState createState() => _MyCommunityViewState();
}

class _MyCommunityViewState extends State<MyCommunityView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container();
  }

  @override
  bool get wantKeepAlive => true;
}

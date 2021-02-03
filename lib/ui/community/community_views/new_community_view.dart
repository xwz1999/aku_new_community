import 'package:flutter/material.dart';

class NewCommunityView extends StatefulWidget {
  NewCommunityView({Key key}) : super(key: key);

  @override
  _NewCommunityViewState createState() => _NewCommunityViewState();
}

class _NewCommunityViewState extends State<NewCommunityView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container();
  }

  @override
  bool get wantKeepAlive => true;
}

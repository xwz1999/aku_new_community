import 'dart:async';
import 'package:akuCommunity/utils/screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:akuCommunity/routers/page_routers.dart';
import 'package:akuCommunity/widget/common_app_bar.dart';

class AgreementPage extends StatefulWidget {
  final Bundle bundle;
  AgreementPage({this.bundle});
  @override
  _AgreementPageState createState() => _AgreementPageState();
}

class _AgreementPageState extends State<AgreementPage> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int pages = 0;
  int currentPage = 0;
  int totalPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppBar(
          title: '用户协议和隐私政策',
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: Screenutil.length(16),
            left: Screenutil.length(32),
            child: Text(
              '页面:$currentPage/$totalPage',
              style: TextStyle(
                fontSize: Screenutil.size(32),
                fontWeight: FontWeight.w600,
                color: Color(0xff333333),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: Screenutil.length(64),
              left: Screenutil.length(32),
              right: Screenutil.length(32),
              bottom: Screenutil.length(32),
            ),
            child: PDFView(
              filePath: widget.bundle.getString('path'),
              enableSwipe: true,
              autoSpacing: false,
              defaultPage: currentPage,
              // fitPolicy: FitPolicy.HEIGHT,
              onRender: (_pages) {
                setState(() {
                  pages = _pages;
                  isReady = true;
                });
              },
              onError: (error) {
                setState(() {
                  errorMessage = error.toString();
                });
                print(error.toString());
              },
              onPageError: (page, error) {
                setState(() {
                  errorMessage = '$page: ${error.toString()}';
                });
                print('$page: ${error.toString()}');
              },
              onViewCreated: (PDFViewController pdfViewController) {
                _controller.complete(pdfViewController);
              },
              onLinkHandler: (String uri) {
                print('goto uri: $uri');
              },
              onPageChanged: (int page, int total) {
                print('page change: $page/$total');
                setState(() {
                  currentPage = page;
                  totalPage = total;
                });
              },
            ),
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                )
        ],
      ),
    );
  }
}

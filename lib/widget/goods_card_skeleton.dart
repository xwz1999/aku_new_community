import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:akuCommunity/utils/screenutil.dart';

class GoodsCardSkeleton extends StatelessWidget {
  const GoodsCardSkeleton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              enabled: true,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      width: Screenutil.length(333),
                      height: Screenutil.length(344),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Screenutil.length(12),
                        right: Screenutil.length(12),
                        top: Screenutil.length(22),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            margin:
                                EdgeInsets.only(bottom: Screenutil.length(6)),
                            height: Screenutil.length(30),
                            width: double.infinity,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            margin:
                                EdgeInsets.only(bottom: Screenutil.length(20)),
                            height: Screenutil.length(30),
                            width: double.infinity,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            height: Screenutil.length(32),
                            width: Screenutil.length(61),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: Screenutil.length(20),
            crossAxisSpacing: Screenutil.length(20),
            childAspectRatio: Screenutil.length(333) / Screenutil.length(509)),
      ),
    );
  }
}

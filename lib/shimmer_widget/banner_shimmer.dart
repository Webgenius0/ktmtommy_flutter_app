import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ShimmerBanner extends StatelessWidget {
  const ShimmerBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 1,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return CardLoading(
            height: 171.h,
            width: 364.h,
            borderRadius:
            BorderRadius.all(Radius.circular(10)),
            margin: EdgeInsets.only(bottom: 12),
          );
        }
    );
  }
}

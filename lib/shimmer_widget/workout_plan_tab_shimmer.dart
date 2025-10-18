import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ShimmerWorkoutTab extends StatelessWidget {
  const ShimmerWorkoutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 8,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(left: 16.0.h, right: 16.0.h, top: 16.0.h),
            child: CardLoading(
              height: 65.h,
              borderRadius:
              BorderRadius.all(Radius.circular(10)),
              // margin: EdgeInsets.only(bottom: 12),
            ),
          );
        }
    );
  }
}

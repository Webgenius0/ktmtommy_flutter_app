import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helpers/ui_helpers.dart';

class ShimmerUserProfile extends StatelessWidget {
  final String? noData;
  const ShimmerUserProfile({super.key,  this.noData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Color(0xffE8E8E8),
          child: noData!= null? Text(noData!, style: TextStyle(fontSize: 11),): SizedBox(),
        ),
        UIHelper.horizontalSpace(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CardLoading(
              height: 15.h,
              width: 90.w,
            ),
            UIHelper.verticalSpace(6),
            CardLoading(
              height: 15.h,
              width: 160.w,
            ),
          ],
        ),
      ],
    );
  }
}

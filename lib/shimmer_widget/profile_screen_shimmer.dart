import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helpers/ui_helpers.dart';

class ShimmerProfileScreen extends StatelessWidget {
  const ShimmerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Color(0xffE8E8E8),
        ),
        UIHelper.verticalSpace(16),
        CardLoading(
          height: 17.h,
          width: 90.w,
        ),
        UIHelper.verticalSpace(8),
        CardLoading(
          height: 17.h,
          width: 180.w,
        ),
        UIHelper.verticalSpace(16),
      ],
    );
  }
}

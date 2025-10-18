import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helpers/ui_helpers.dart';

class ShimmerWorkoutPlan extends StatelessWidget {
  const ShimmerWorkoutPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xffE8E8E8),
              ),
              UIHelper.verticalSpace(5),
              CardLoading(
                height: 15.h,
              ),
              UIHelper.verticalSpace(6),
              CardLoading(
                height: 15.h,
              ),
            ],
          ),
        ),
        UIHelper.horizontalSpace(5),
        Expanded(
          child: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xffE8E8E8),
              ),
              UIHelper.verticalSpace(5),
              CardLoading(
                height: 15.h,
              ),
              UIHelper.verticalSpace(6),
              CardLoading(
                height: 15.h,
              ),
            ],
          ),
        ),
        UIHelper.horizontalSpace(5),
        Expanded(
          child: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xffE8E8E8),
              ),
              UIHelper.verticalSpace(5),
              CardLoading(
                height: 15.h,
              ),
              UIHelper.verticalSpace(6),
              CardLoading(
                height: 15.h,
              ),
            ],
          ),
        ),
        UIHelper.horizontalSpace(5),
        Expanded(
          child: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xffE8E8E8),
              ),
              UIHelper.verticalSpace(5),
              CardLoading(
                height: 15.h,
              ),
              UIHelper.verticalSpace(6),
              CardLoading(
                height: 15.h,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

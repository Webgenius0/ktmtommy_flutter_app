import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helpers/ui_helpers.dart';

class ShimmerGuidance extends StatelessWidget {
  const ShimmerGuidance({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CardLoading(
            height: 107.h,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            margin: EdgeInsets.only(bottom: 10),
          ),
        ),
        UIHelper.horizontalSpace(16),
        Expanded(
          child: CardLoading(
            height: 107.h,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            margin: EdgeInsets.only(bottom: 10),
          ),
        ),
      ],
    );
  }
}




/*
CircleAvatar(
child: Center(
child: Image.asset(
Assets.icons.fiPlay.path,
width: 20,
)),
)*/

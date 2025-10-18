import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helpers/ui_helpers.dart';

class ShimmerCommunityScreen extends StatelessWidget {
  const ShimmerCommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 3,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xffE8E8E8),
                      ),
                      UIHelper.horizontalSpace(12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CardLoading(
                            height: 15.h,
                            width: 150.w,
                          ),
                          UIHelper.verticalSpace(6),
                          CardLoading(
                            height: 15.h,
                            width: 70.w,
                          ),
                        ],
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(20),
                  CardLoading(
                    height: 180.h,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    margin: EdgeInsets.only(bottom: 12),
                  ),
                  UIHelper.verticalSpace(5),
                  CardLoading(
                    height: 10.h,
                    margin: EdgeInsets.only(bottom: 7),
                  ),
                  CardLoading(
                    height: 10.h,
                    margin: EdgeInsets.only(bottom: 7),
                  ),
                  CardLoading(
                    height: 10.h,
                    margin: EdgeInsets.only(bottom: 7),
                  ),
                  UIHelper.verticalSpace(8),
                  Row(
                    children: [
                      CardLoading(
                        height: 40.h,
                        width: 40.w,
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                        margin: EdgeInsets.only(bottom: 12),
                      ),
                      UIHelper.horizontalSpace(8),
                      CardLoading(
                        height: 40.h,
                        width: 40.w,
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                        margin: EdgeInsets.only(bottom: 12),
                      ),
                      UIHelper.horizontalSpace(8),
                      CardLoading(
                        height: 40.h,
                        width: 40.w,
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                        margin: EdgeInsets.only(bottom: 12),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}

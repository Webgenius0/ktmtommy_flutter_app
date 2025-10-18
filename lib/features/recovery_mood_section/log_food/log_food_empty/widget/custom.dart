
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';


class Custom extends StatefulWidget {
  const Custom({super.key});

  @override
  State<Custom> createState() => _CustomState();
}

class _CustomState extends State<Custom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            UIHelper.verticalSpace(300),

            Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: const Color(0xFF181818),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),child: Padding(
                    padding:  EdgeInsets.symmetric(vertical: 16.h,horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(

                                      children: [
                                        SvgPicture.asset(AppIcons.whaticon,height: 20.h),
                                        UIHelper.horizontalSpace(8.w),
                                        Text(
                                          'Nutritional Insights',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 1.50,
                                          ),
                                        ),

                                      ],
                                    ),


                                    UIHelper.verticalSpace(16.h),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 2.w,
                                          height: 55.w,
                                          decoration: BoxDecoration(
                                            color: AppColors.c87B842,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(12.r),
                                              bottomLeft: Radius.circular(12.r),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 12.w,),
                                          child: Column(
                                            // crossAxisAlignment: CrossAxisAlignment.center,
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            children: [

                                              Text(
                                                'Good protein source - helps with muscle\nrecovery',
                                                style: TextStyle(
                                                  color: const Color(0xFFBABABA),
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.50,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    UIHelper.verticalSpace(16.h),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 2.w,
                                          height: 55.w,
                                          decoration: BoxDecoration(
                                            color: AppColors.c87B842,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(12.r),
                                              bottomLeft: Radius.circular(12.r),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 12.w,),
                                          child: Column(
                                            // crossAxisAlignment: CrossAxisAlignment.center,
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            children: [

                                              Text(
                                                'Good protein source - helps with muscle\nrecovery',
                                                style: TextStyle(
                                                  color: const Color(0xFFBABABA),
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.50,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),



                                  ],
                                ),
                  ),
            ),



          ],
        )



    );
  }
}

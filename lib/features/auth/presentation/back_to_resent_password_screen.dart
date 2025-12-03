import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';





class BackToResentPasswordScreen extends StatefulWidget {
  const BackToResentPasswordScreen({super.key});

  @override
  State<BackToResentPasswordScreen> createState() => _BackToResentPasswordScreenState();
}

class _BackToResentPasswordScreenState extends State<BackToResentPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.restbacroundimage),fit: BoxFit.cover
          ),
        ),child:  Column(
        children: [
          UIHelper.verticalSpace(534),

          Text(
            'Password Changed',
            textAlign: TextAlign.center,
            style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                fontSize: 20.sp
            ),
          ),
          UIHelper.verticalSpace(2.h),
          Text(
            'Your password has been changed\nsuccessfully.',
            textAlign: TextAlign.center,
            style: TextFontStyle.textStyle20w700cEEE6DApoppins.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
            ),
          ),
          UIHelper.verticalSpace(24.h),

          CustomButtonWidget(
              textStyle: TextFontStyle.textStyle20w700c000000poppins,
              image: DecorationImage(
                image: AssetImage(AppImages.withbacrounbutton),
              ),
              onTap: ()
              {
                NavigationService.navigateTo(Routes.logInRecoveryModeScreen);
              },

              text: 'BACK TO LOGIN'),



        ],
      ),
      ) ,


    );
  }
}





















//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ktmtommy_app/assets_helper/app_fonts.dart';
// import 'package:ktmtommy_app/assets_helper/app_image.dart';
// import 'package:ktmtommy_app/helpers/ui_helpers.dart';
//
// class BackToResentPasswordScreen extends StatefulWidget {
//   const BackToResentPasswordScreen({super.key});
//
//   @override
//   State<BackToResentPasswordScreen> createState() => _BackToResentPasswordScreenState();
// }
//
// class _BackToResentPasswordScreenState extends State<BackToResentPasswordScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(AppImages.bacroundimage),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 24.w),
//             child: Column(
//               children: [
//                // const Spacer(), // Push content to bottom
//
//                 Text(
//                   'Password Changed',
//                   textAlign: TextAlign.center,
//                   style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
//                     fontSize: 20.sp,
//                   ),
//                 ),
//                 UIHelper.verticalSpace(2.h),
//                 Text(
//                   'Your password has been changed successfully.',
//                   textAlign: TextAlign.center,
//                   style: TextFontStyle.textStyle20w700cEEE6DApoppins.copyWith(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 14.sp,
//                   ),
//                 ),
//
//                 UIHelper.verticalSpace(40.h), // Bottom padding
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

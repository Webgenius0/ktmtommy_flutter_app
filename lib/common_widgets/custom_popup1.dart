// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../assets_helper/app_colors.dart';
// import '../assets_helper/app_fonts.dart';
// import '../assets_helper/app_image.dart';
// import '../helpers/ui_helpers.dart';
// import 'custom_button.dart';
//
// void customPopup1(
//   BuildContext context,
//   String title,
//   String buttonName,
//   VoidCallback ontap,
// ) {
//   showDialog(
//     context: context,
//     barrierDismissible: true,
//     builder: (BuildContext context) {
//       return Dialog(
//         elevation: 12,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16.r),
//         ),
//         child: Container(
//           height: 484.h,
//           padding: EdgeInsets.all(16.sp),
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16.r),
//           ),
//           child: Column(
//             children: [
//               SizedBox(
//                   width: 233.30.w,
//                   height: 230.65.h,
//                   child: Image.asset(AppImages.alertLogo)),
//               UIHelper.verticalSpace(20.h),
//               Text(
//                 title,
//                 textAlign: TextAlign.center,
//                 style:
//                     TextFontStyle.textStyle20w600primaryColor2PlusJakartaSans,
//               ),
//               UIHelper.verticalSpace(8.h),
//               Text(
//                 buttonName,
//                 textAlign: TextAlign.center,
//                 style: TextFontStyle
//                     .textStyle14w500SecondaryColorPlusJakartaSans
//                     .copyWith(
//                   color: AppColors.c797979,
//                 ),
//               ),
//               UIHelper.verticalSpace(14.h),
//               Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     CustomButton(
//                       minWidth: 130.w,
//                       height: 50.h,
//                       color: AppColors.cEEF2FA,
//                       borderColor: AppColors.cEEF2FA,
//                       borderRadius: 12.r,
//                       name: 'Cancel',
//                       textStyle: TextFontStyle
//                           .textStyle16w700primaryColor2PlusJakartaSans,
//                       onCallBack: () {
//                         Navigator.pop(context);
//                       },
//                       context: context,
//                     ),
//                     UIHelper.verticalSpaceSmall,
//                     CustomButton(
//                       minWidth: 130.w,
//                       height: 50.h,
//                       borderRadius: 12.r,
//                       name: 'Start',
//                       color: AppColors.primaryColor,
//                       textStyle: TextFontStyle
//                           .textStyle16w700primaryColor2PlusJakartaSans
//                           .copyWith(
//                         color: AppColors.primaryColor,
//                       ),
//                       onCallBack: () {},
//                       context: context,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

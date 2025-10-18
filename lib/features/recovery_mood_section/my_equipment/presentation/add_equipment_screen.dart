//
// import 'dart:io' show File;
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get_core/src/get_main.dart' show Get;
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
// import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
// import 'package:ktmtommy_apps/assets_helper/app_image.dart';
// import 'package:ktmtommy_apps/bottom_nav_screen.dart';
// import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
// import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
// import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
// import 'package:ktmtommy_apps/features/athlet_flow/althelete_home/widget/custom_dropdown.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/presentation/my_equipment_two_screen.dart';
// import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/widget/custom_dotted.dart';
// import 'package:ktmtommy_apps/helpers/navigation_service.dart';
// import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
//
//
//
// class AddEquipmentScreen extends StatefulWidget {
//   const AddEquipmentScreen({super.key});
//
//   @override
//   State<AddEquipmentScreen> createState() => _AddEquipmentScreenState();
// }
//
// class _AddEquipmentScreenState extends State<AddEquipmentScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController notesController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   File? pickedImageFile;
//
//   List<String> durationList = ['1', '2', '3', '4'];
//   String selectedUnit = 'Select equipment type';
//
//   @override
//   void dispose() {
//     nameController.dispose();
//     notesController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.bacroundColorBlack,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 24.w),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//
//                 ///========================   CustomAppbarWidget =================================//
//                 CustomAppbarWidget(
//                   onTap: () {
//                     NavigationService.goBack;
//                   },
//                   text: 'Add Equipment',
//                 ),
//                 UIHelper.verticalSpace(24.h),
//
//                 ///==============================  Equipment  =========================================///
//                 Container(
//                   width: double.infinity,
//                   decoration: ShapeDecoration(
//                     color: AppColors.c181818,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.r),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//
//                         ///=================================     Equipment ============================//
//                         Text('Equipment Name',
//                             style: TextFontStyle.textStyle14w400cA3A3A3poppins),
//                         UIHelper.verticalSpace(4.h),
//                         CustomTextfield(
//                           controller: nameController,
//                           textAlign: TextAlign.start,
//                           borderRadius: 20,
//                           fillColor: AppColors.c2A2A2A,
//                           hintText: 'Enter equipment name',
//                           hintTextSyle: TextFontStyle.textStyle14w400cA3A3A3poppins,
//                           style: const TextStyle(color: Colors.white),
//                           validator: (value) {
//                             if (value == null || value.trim().isEmpty) {
//                               return "Please enter your name";
//                             }
//                             if (value.trim().length < 3) {
//                               return "Name must be at least 3 characters";
//                             }
//                             return null;
//                           },
//                         ),
//                         UIHelper.verticalSpace(18.h),
//
//                         //==============================  Equipment ==========================//
//                         Text('Equipment Type',
//                             style: TextFontStyle.textStyle14w400cA3A3A3poppins),
//                         UIHelper.verticalSpace(4.h),
//
//                         ///============================   CustomDropdown =========================================//
//
//                         CustomDropdown(
//                           items: durationList,
//                           selectedValue: selectedUnit,
//                           hintText: 'Select equipment type',
//                           onChanged: (value) {
//                             setState(() {
//                               selectedUnit = value;
//                             });
//                           },
//                         ),
//
//                         UIHelper.verticalSpace(18.h),
//
//                         //================================ Notes ==================================//
//                         Text('Notes', style: TextFontStyle.textStyle14w400cA3A3A3poppins),
//                         UIHelper.verticalSpace(4.h),
//                         CustomTextfield(
//                           maxline: 4,
//                           controller: notesController,
//                           textAlign: TextAlign.start,
//                           borderRadius: 20,
//                           fillColor: AppColors.c2A2A2A,
//                           hintText: 'Add notes here',
//                           hintTextSyle: TextFontStyle.textStyle14w400cA3A3A3poppins,
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                         UIHelper.verticalSpace(18.h),
//
//                         ///=============================== Add Photo ==================================//
//                         Text('Add Photo (Optional)',
//                             style: TextFontStyle.textStyle14w400cA3A3A3poppins),
//                         UIHelper.verticalSpace(4.h),
//                         CustomDotteds(
//                           text: 'Click to Upload Back Side of Card',
//                           textmb: '(Max. File size: 25 MB)',
//                           icon: SvgPicture.asset(AppImages.camera),
//                           onImagePicked: (File? file) {
//                             setState(() {
//                               pickedImageFile = file;
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 UIHelper.verticalSpace(42.h),
//
//                 ///============================== CustomButtonWidget ============================///
//                 CustomButtonWidget(
//                   onTap: () {
//                     if (_formKey.currentState!.validate()) {
//
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => MyEquipmentTwoScreen(
//                             savedImageFile: pickedImageFile,
//                           ),
//                         ),
//                       );
//                       Get.offAll(() => BottomNavScreen(
//                         initialIndex: 2,
//                         savedImageFile: pickedImageFile,
//                       ));
//                     }
//                   },
//                   text: 'Save Equipment',
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/custom_camera.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/custom_chiken.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/custom_edit.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/log_food/log_food_empty/widget/custom_hold_steady.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';






class LogFoodScanTwoScreen extends StatefulWidget {
  final String imagePath;
  const LogFoodScanTwoScreen({super.key, required this.imagePath});

  @override
  State<LogFoodScanTwoScreen> createState() => _LogFoodScanTwoScreenState();
}

class _LogFoodScanTwoScreenState extends State<LogFoodScanTwoScreen> {
  late String _currentImagePath;
  final TextEditingController _noteController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _currentImagePath = widget.imagePath;
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _updateImagePath(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? photo = await picker.pickImage(source: source);
      if (photo != null && mounted) {
        setState(() {
          _currentImagePath = photo.path;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking photo: $e')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppbarWidget(
                  onTap: () => NavigationService.goBack,
                  text: 'Log Food',
                  subtitle: 'Snap your meal, get calorie estimates',
                ),
                UIHelper.verticalSpace(24.h),
                Container(
                  padding: EdgeInsets.all(12.sp),
                  decoration: BoxDecoration(
                    color: AppColors.c181818,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppIcons.tipholdicon, height: 20.w),
                      UIHelper.horizontalSpace(8.w),
                      Text(
                        'Pro Tip: Hold steady for clearer images',
                        style: TextFontStyle.textStyle14w400cA3A3A3poppins,
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpace(24.h),



                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        CustomCamera(
                          imagePath: _currentImagePath,
                          onRetake: _updateImagePath,
                        ),



                        UIHelper.verticalSpace(24.h),

                        CustomHoldSteady(
                          imagePath: _currentImagePath,
                          onRetake: _updateImagePath,
                        ),



                        UIHelper.verticalSpace(18.h),

                        CustomChiken(
                          text: 'Chicken Rice Bowl',
                          imagePath: _currentImagePath,
                        ),
                        UIHelper.verticalSpace(18.h),

                        CustomEditPic(),
                        UIHelper.verticalSpace(24.h),

                        Text(
                          'Notes',
                          style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        UIHelper.verticalSpace(12.h),
                        CustomTextfield(
                          controller: _noteController,
                          textAlign: TextAlign.start,
                          fillColor: AppColors.c181818,
                          maxline: 4,
                          hintTextSyle: TextFontStyle.textStyle16w400c757575poppins
                              .copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          hintText: 'Add notes',
                          style: const TextStyle(color: Colors.white),
                          borderRadius: 12.r,
                        ),
                        UIHelper.verticalSpace(24.h),

                        CustomButtonWidget(
                          text: 'Save Log',
                          onTap: () {
                            NavigationService.navigateTo(Routes.logFoodEmptyScreen);
                          },
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

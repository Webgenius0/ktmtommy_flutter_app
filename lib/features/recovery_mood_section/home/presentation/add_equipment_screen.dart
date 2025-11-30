import 'dart:developer';
import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/bottom_nav_screen.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/widget/custom_dotted.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/widget/custom_dropdown.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';
import '../../my_equipment/presentation/my_equipment_two_screen.dart';

class AddEquipmentScreen extends StatefulWidget {
  const AddEquipmentScreen({super.key});

  @override
  State<AddEquipmentScreen> createState() => _AddEquipmentScreenState();
}

class _AddEquipmentScreenState extends State<AddEquipmentScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSaving = false;
  File? pickedImageFile;

  List<String> durationList = ['Strength', 'Cardio', 'Flexibility'];
  String selectedUnit = 'Select equipment type';

  @override
  void dispose() {
    nameController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ///========================   CustomAppbarWidget =================================//
                CustomAppbarWidget(
                  onTap: () {
                    NavigationService.goBack;
                  },
                  text: 'Add Equipment',
                ),
                UIHelper.verticalSpace(24.h),

                ///==============================  Equipment  =========================================///
                Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    color: AppColors.c181818,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///=================================     Equipment ============================//
                        Text('Equipment Name',
                            style: TextFontStyle.textStylePoppins.copyWith(
                              color: AppColors.cA3A3A3,
                              fontSize: 14.sp,
                            )),
                        UIHelper.verticalSpace(4.h),
                        CustomTextfield(
                          controller: nameController,
                          textAlign: TextAlign.start,
                          borderRadius: 20,
                          fillColor: AppColors.c2A2A2A,
                          hintText: 'Enter equipment name',
                          hintTextSyle: TextFontStyle.textStylePoppins.copyWith(
                              fontSize: 14.sp, color: AppColors.cA3A3A3),
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter your name";
                            }
                            if (value.trim().length < 3) {
                              return "Name must be at least 3 characters";
                            }
                            return null;
                          },
                        ),
                        UIHelper.verticalSpace(18.h),

                        //==============================  Equipment ==========================//
                        Text('Equipment Type',
                            style: TextFontStyle.textStylePoppins.copyWith(
                                fontSize: 14.sp, color: AppColors.cA3A3A3)),
                        UIHelper.verticalSpace(4.h),

                        ///============================   CustomDropdown =========================================//

                        CustomDropdown(
                          items: durationList,
                          selectedValue: selectedUnit,
                          hintText: 'Select equipment type',
                          onChanged: (value) {
                            setState(() {
                              selectedUnit = value;
                            });
                          },
                        ),

                        UIHelper.verticalSpace(18.h),

                        //================================ Notes ==================================//
                        Text('Notes',
                            style: TextFontStyle.textStylePoppins.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.cA3A3A3,
                            )),
                        UIHelper.verticalSpace(4.h),
                        CustomTextfield(
                          maxline: 4,
                          controller: notesController,
                          textAlign: TextAlign.start,
                          borderRadius: 20,
                          fillColor: AppColors.c2A2A2A,
                          hintText: 'Add notes here',
                          hintTextSyle: TextFontStyle.textStylePoppins.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.cA3A3A3,
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                        UIHelper.verticalSpace(18.h),

                        ///=============================== Add Photo ==================================//
                        Text('Add Photo (Optional)',
                            style: TextFontStyle.textStylePoppins.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.cA3A3A3,
                            )),
                        UIHelper.verticalSpace(4.h),
                        CustomDotted(
                          text: 'Click to Upload Back Side of Card',
                          textmb: '(Max. File size: 25 MB)',
                          icon: SvgPicture.asset(AppImages.camera),
                          onImagePicked: (File? file) {
                            setState(() {
                              pickedImageFile = file;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                UIHelper.verticalSpace(42.h),

                ///============================== CustomButtonWidget ============================///
                if (_isSaving)
                  const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.c87B842,
                      strokeWidth: 5,
                    ),
                  )
                else
                  CustomButtonWidget(
                    onTap: () async {
                      if (_isSaving) return;

                      if (!_formKey.currentState!.validate()) return;

                      setState(() {
                        _isSaving = true;
                      });

                      log("=============>>>>>>>>>> Equipment Name: ${nameController.text.trim()}");
                      log("================>>>>>>>>>> Equipment Type: $selectedUnit");
                      log("===========>>>>>>>> Notes: ${notesController.text.trim()}");
                      log("===========>>>>> Image File: ${pickedImageFile?.path ?? 'No image selected'}");

                      try {
                        bool isSuccess =
                            await addEquipmentsRxObj.storeEquipmentsApi(
                          image: pickedImageFile!,
                          name: nameController.text.trim(),
                          type: selectedUnit,
                          note: notesController.text.trim(),
                        );

                        if (!mounted) return;

                        if (isSuccess) {
                          log("Equipment saved successfully!");

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MyEquipmentTwoScreen(

                              ),
                            ),
                          );

                          Get.offAll(() => BottomNavScreen(
                                initialIndex: 2,

                              ));
                        } else {}
                      } catch (e, stack) {
                        log("============>>>>Error saving equipment: $e");
                        log(stack.toString());

                        if (mounted) {}
                      } finally {
                        if (mounted) {
                          setState(() {
                            _isSaving = false;
                          });
                        }
                      }
                    },
                    text: 'Save Equipment',
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

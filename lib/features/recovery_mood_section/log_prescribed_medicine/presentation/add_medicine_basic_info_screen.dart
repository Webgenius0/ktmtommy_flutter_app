import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class AddMedicineBasicInfoScreen extends StatefulWidget {
  final String? name;
  final String? dosage;
  final String? type;
  final bool isEdit;

  const AddMedicineBasicInfoScreen({
    super.key,
    this.name,
    this.dosage,
    this.type,
    this.isEdit = false,
  });

  @override
  State<AddMedicineBasicInfoScreen> createState() => _AddMedicineBasicInfoScreenState();
}

class _AddMedicineBasicInfoScreenState extends State<AddMedicineBasicInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  String selectedUnit = 'mg';
  String selectedType = 'Tablet';

  final List<String> types = ['Tablet', 'Capsule', 'Syrup', 'Injection'];

  @override
  void initState() {
    super.initState();
    if (widget.name != null) nameController.text = widget.name!;
    if (widget.dosage != null) dosageController.text = widget.dosage!;
    if (widget.type != null && types.contains(widget.type)) {
      selectedType = widget.type!;
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
            padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(20.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => NavigationService.goBack(),
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  UIHelper.horizontalSpace(16.w),
                  Text(
                    widget.isEdit ? 'Edit Medicine' : 'Add Medicine',
                    style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(24.h),
              
              // Progress bar
              Row(
                children: [
                  Expanded(child: Container(height: 4.h, color: const Color(0xffA6FF00))),
                  UIHelper.horizontalSpace(8.w),
                  Expanded(child: Container(height: 4.h, color: Colors.white24)),
                  UIHelper.horizontalSpace(8.w),
                  Expanded(child: Container(height: 4.h, color: Colors.white24)),
                  UIHelper.horizontalSpace(8.w),
                  Expanded(child: Container(height: 4.h, color: Colors.white24)),
                ],
              ),
              UIHelper.verticalSpace(24.h),
              
              Text(
                'Basic Information',
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 18.sp,
                ),
              ),
              UIHelper.verticalSpace(4.h),
              Text(
                'Tell us about your medicine',
                style: TextFontStyle.textStyle14w500c242424.copyWith(
                  color: Colors.white54,
                  fontSize: 14.sp,
                ),
              ),
              UIHelper.verticalSpace(24.h),
              
              Text(
                'Medicine Name',
                style: TextFontStyle.textStyle14w500c242424.copyWith(
                  color: Colors.white,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              CustomTextfield(
                controller: nameController,
                hintText: 'e.g., Napa Extra',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter medicine name';
                  }
                  return null;
                },
                fillColor: AppColors.c181818,
                borderColor: Colors.transparent,
                hintTextSyle: TextFontStyle.textStyle14w500c242424.copyWith(color: Colors.white54),
                style: const TextStyle(color: Colors.white),
              ),
              UIHelper.verticalSpace(20.h),
              
              Text(
                'Dosage',
                style: TextFontStyle.textStyle14w500c242424.copyWith(
                  color: Colors.white,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomTextfield(
                      controller: dosageController,
                      hintText: '500',
                      inputType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      fillColor: AppColors.c181818,
                      borderColor: Colors.transparent,
                      hintTextSyle: TextFontStyle.textStyle14w500c242424.copyWith(color: Colors.white54),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  UIHelper.horizontalSpace(16.w),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.c181818,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedUnit,
                          dropdownColor: AppColors.c181818,
                          icon: Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 20.sp),
                          style: TextFontStyle.textStyle14w500c242424.copyWith(color: Colors.white),
                          items: ['mg', 'ml', 'IU', 'pill'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            if (newValue != null) {
                              setState(() {
                                selectedUnit = newValue;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(20.h),
              
              Text(
                'Medicine Type',
                style: TextFontStyle.textStyle14w500c242424.copyWith(
                  color: Colors.white,
                ),
              ),
              UIHelper.verticalSpace(12.h),
              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: types.map((type) {
                  bool isSelected = type == selectedType;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedType = type;
                      });
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 48.w - 12.w) / 2,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: AppColors.c181818,
                        borderRadius: BorderRadius.circular(24.r),
                        border: Border.all(
                          color: isSelected ? const Color(0xffA6FF00) : Colors.transparent,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          type,
                          style: TextFontStyle.textStyle14w500c242424.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              
              const Spacer(),
              CustomButtonWidget(
                text: 'Next',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    NavigationService.navigateToWithArgs(
                      Routes.addMedicineTakingScheduleScreen,
                      {'isEdit': widget.isEdit},
                    );
                  }
                },
              ),
              UIHelper.verticalSpace(30.h),
            ],
          ),
        ),
        ),
      ),
    );
  }
}

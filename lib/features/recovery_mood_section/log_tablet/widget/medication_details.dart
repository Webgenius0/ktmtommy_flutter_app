import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/common_widgets/custom_textfeild.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class MedicationDetails extends StatefulWidget {
  final String title;
  final String hintText;
  final String dosage;
  final TextEditingController nameController;
  final TextEditingController dosageController;
  final GlobalKey<FormState> formKey;

  const MedicationDetails({
    super.key,
    required this.title,
    required this.hintText,
    required this.dosage,
    required this.nameController,
    required this.dosageController,
    required this.formKey,
  });

  @override
  State<MedicationDetails> createState() => _MedicationDetailsState();
}

class _MedicationDetailsState extends State<MedicationDetails> {
  List<String> durationList = ['mg', 'g', 'mcg', 'mL', 'IU'];
  String selectedUnit = 'mg';
  bool isOn = false;

  List<String> ionList = ['1', '2', '3', '4'];

  String selected = 'Walking';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
            decoration: ShapeDecoration(
              color: AppColors.c181818,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextFontStyle.textStyle14w400cA3A3A3poppins,
                ),
                UIHelper.verticalSpace(4.h),

                // Medication Name Field
                CustomTextfield(
                  controller: widget.nameController,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                  borderRadius: 20.r,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  fillColor: AppColors.c2A2A2A,
                  hintText: widget.hintText,
                  hintTextSyle:
                      TextFontStyle.textStyle24w400cA3A3A3poppins.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Medication name is required';
                    }
                    if (value.length < 3) {
                      return 'Name too short';
                    }
                    return null;
                  },
                ),
                UIHelper.verticalSpace(16.h),

                Text(
                  'Dosage',
                  style: TextFontStyle.textStyle14w400cA3A3A3poppins,
                ),
                UIHelper.verticalSpace(4.h),

                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomTextfield(
                        inputType: TextInputType.number,
                        controller: widget.dosageController,
                        textAlign: TextAlign.start,
                        borderRadius: 20.r,
                        fillColor: AppColors.c2A2A2A,
                        hintText: widget.dosage,
                        hintTextSyle: TextFontStyle
                            .textStyle24w400cA3A3A3poppins
                            .copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        style: const TextStyle(color: Colors.white),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter dosage amount';
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'Only numbers are allowed';
                          }
                          return null;
                        },
                      ),
                    ),
                    UIHelper.horizontalSpace(16.w),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 11.h),
                        decoration: ShapeDecoration(
                          color: AppColors.c2A2A2A,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        child: PopupMenuButton<String>(
                          color: const Color(0xFF2A2A2A),
                          padding: EdgeInsets.zero,
                          onSelected: (String value) {
                            setState(() {
                              selectedUnit = value;
                            });
                          },
                          itemBuilder: (BuildContext context) {
                            return durationList.map((String value) {
                              return PopupMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextFontStyle
                                      .textStyle24w600cFFFFFFpoppins
                                      .copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            }).toList();
                          },
                          offset: const Offset(0, 40),
                          elevation: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  selectedUnit,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextFontStyle
                                      .textStyle24w600cFFFFFFpoppins
                                      .copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SvgPicture.asset(AppIcons.bottomdrodwonicon,
                                  height: 18.h, color: AppColors.cFFFFFF),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(16.h),

                // Prescribed Switch
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Prescribed',
                      style:
                          TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Transform.scale(
                      scale: 0.90,
                      child: Switch(
                        activeColor: AppColors.cFFFFFF,
                        activeTrackColor: AppColors.cCC1F28,
                        inactiveTrackColor: Colors.white,
                        inactiveThumbColor: AppColors.c87B842,
                        value: isOn,
                        onChanged: (bool value) {
                          setState(() {
                            isOn = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';






class HydroTherapy extends StatefulWidget {
  const HydroTherapy({super.key});

  @override
  State<HydroTherapy> createState() => _HydroTherapyState();
}

class _HydroTherapyState extends State<HydroTherapy> {
  List<String> durationList = ['Once', 'Everyday', 'Weekends', 'Custom'];
  List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri','Sat'];

  late String selectedUnit = durationList[0];

  Future<void> _showCustomDialog() async {
    List<String> tempSelectedDays = [];
    String? validationMessage;

    String? confirmedDays = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: StatefulBuilder(
            builder: (context, setStateDialog) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: AppColors.c181818,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.c454545, width: 1),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Repeat Custom',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: SvgPicture.asset(
                              AppIcons.crossiconBox,
                              height: 24.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(16.h),
                    Text(
                      'Custom reminder cycle',
                      style: TextStyle(
                        color: const Color(0xFF757575),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    UIHelper.verticalSpace(24.h),

                    // Row of weekdays
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildDayContainer('Sun', tempSelectedDays, (day) {
                          if (tempSelectedDays.contains(day)) {
                            tempSelectedDays.remove(day);
                          } else {
                            tempSelectedDays.add(day);
                          }
                          validationMessage = null;
                          setStateDialog(() {});
                        }),
                        ...weekdays.map((day) => Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: _buildDayContainer(day, tempSelectedDays, (day) {
                            if (tempSelectedDays.contains(day)) {
                              tempSelectedDays.remove(day);
                            } else {
                              tempSelectedDays.add(day);
                            }
                            validationMessage = null;
                            setStateDialog(() {});
                          }),
                        )).toList(),
                      ],
                    ),

                    UIHelper.verticalSpace(24.h),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 10.h),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1, color: AppColors.c87B842),
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: TextFontStyle.textStyle14w400c87B842poppins,
                              ),
                            ),
                          ),
                        ),
                        UIHelper.horizontalSpace(10.w),
                        // Confirm Button
                        GestureDetector(
                          onTap: () {
                            if (tempSelectedDays.isEmpty) {
                              setStateDialog(() {
                                validationMessage = "Please select at least one day";
                              });
                            } else {
                              Navigator.pop(context, tempSelectedDays.join(', '));
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 10.h),
                            decoration: ShapeDecoration(
                              color: AppColors.c87B842,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Confirm',
                                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    if (validationMessage != null) ...[
                      UIHelper.verticalSpace(12.h),
                      Text(
                        validationMessage!,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        );
      },
    );

    if (confirmedDays != null) {
      setState(() {
        selectedUnit = confirmedDays;
      });
    }
  }

  Widget _buildDayContainer(String day, List<String> tempSelectedDays, Function(String) onTap) {
    bool isSelected = tempSelectedDays.contains(day);
    return GestureDetector(
      onTap: () => onTap(day),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Color(0xFF87B842) : AppColors.c2F2F2F,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          day,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
      decoration: ShapeDecoration(
        color: AppColors.c2A2A2A,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child: PopupMenuButton<String>(
        color: const Color(0xFF2A2A2A),
        onSelected: (String value) async {
          if (value == 'Custom') {
            await _showCustomDialog();
          } else {
            setState(() {
              selectedUnit = value;
            });
          }
        },
        itemBuilder: (BuildContext context) {
          return durationList.map((String value) {
            return PopupMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList();
        },
        offset: const Offset(30, 40),
        elevation: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                selectedUnit,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SvgPicture.asset(AppIcons.bottomdrodwonicon, height: 18.h),
          ],
        ),
      ),
    );
  }
}

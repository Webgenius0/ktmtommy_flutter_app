import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/features/athlet_flow/althelete_home/presentation/althelete_home_screen.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_section/presentation/athelete_shedule_screen.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_section/presentation/athlet_progress_screen.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_setting/presentation/athlet_setting_screen.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/presentation/athlet_trainer_screen.dart';



class AthletBottomNavigationBar extends StatefulWidget {
  final int initialIndex;

  const AthletBottomNavigationBar({super.key, this.initialIndex = 0});

  @override
  State<AthletBottomNavigationBar> createState() =>
      _AthletBottomNavigationBarState();
}

class _AthletBottomNavigationBarState extends State<AthletBottomNavigationBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Widget> _screens = [
    AltheleteHomeScreen(),
    AtheleteSheduleScreen(),
    AthletProgressScreen(),
    AthletTrainerScreen(),
    AthletSettingScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: AppColors.c0B0A0B,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 15.h, left: 15.w, right: 15.w),
        child: Container(
          height: 70.h,
          decoration: BoxDecoration(
            color: AppColors.c0B0A0B,
            borderRadius: BorderRadius.circular(80.r),
            border: Border.all(color: AppColors.cD1D1D1,width: 0.8.w),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, AppIcons.athlethomeactive, AppIcons.athlethomunactive, "My Day"),
              _buildNavItem(1, AppIcons.shedulactiveicon, AppIcons.athletsedulunactive, "My Schedule"),
              _buildNavItem(2, AppIcons.activeprogress, AppIcons.unactiveprogress, "My Progress"),
              _buildNavItem(3, AppIcons.athletactivetrainer, AppIcons.athletunactivetrainer, "225 Trainer"),
              _buildNavItem(4, AppIcons.athletactiveprofile, AppIcons.unactiveprofile, "Profile"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String activeIcon, String inactiveIcon, String label) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: isSelected ? 12.w : 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              isSelected ? activeIcon : inactiveIcon,
              width: isSelected ? 24.w : 24.w,
              height: isSelected ? 24.h : 24.h,
              color: isSelected ? AppColors.cFFFFFF : AppColors.c5E5E5E,
            ),
            if (isSelected)
              Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Text(
                  label,
                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                    fontSize: 14.sp,fontWeight: FontWeight.w500
                  )
                ),
              ),
          ],
        ),
      ),
    );
  }
}


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/home/presentation/home_screen.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/presentation/my_equipment_two_screen.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/presentation/my_story_screen.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/presentation/schedule_screen.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/presentation/trainer_screen.dart';



class BottomNavScreen extends StatefulWidget {
  final int initialIndex;
  final File? savedImageFile;

  const BottomNavScreen({
    Key? key,
    this.initialIndex = 0,
    this.savedImageFile,
  }) : super(key: key);

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  /// Build screens dynamically so MyEquipmentTwoScreen always gets latest file
  List<Widget> get _screens => [
    HomeScreen(),
    ScheduleScreen(),
    MyEquipmentTwoScreen(savedImageFile: widget.savedImageFile),
    TrainerScreen(),
    MyStoryScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.c090809,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.c12150D,
                blurRadius: 4,
                offset: Offset(0, -3),
                spreadRadius: 0,
              )
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: onItemTapped,
            selectedItemColor: AppColors.c87B842,
            unselectedItemColor: AppColors.cBABABA,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  transform: Matrix4.translationValues(0, _selectedIndex == 0 ? -20 : 0, 0),
                  child: SvgPicture.asset(
                    _selectedIndex == 0 ? AppIcons.homeactiveicon : AppIcons.homeunactive,
                    width: _selectedIndex == 0 ? 56.w : 24.w,
                    height: _selectedIndex == 0 ? 56.h : 24.h,
                  ),
                ),
                label: _selectedIndex == 0 ? 'My Day' : "",
              ),
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  transform: Matrix4.translationValues(0, _selectedIndex == 1 ? -20 : 0, 0),
                  child: SvgPicture.asset(
                    _selectedIndex == 1 ? AppIcons.activeschedule : AppIcons.unactiveschedul,
                    width: _selectedIndex == 1 ? 56.w : 24.w,
                    height: _selectedIndex == 1 ? 56.h : 24.h,
                  ),
                ),
                label: _selectedIndex == 1 ? 'Schedule' : "",
              ),
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  transform: Matrix4.translationValues(0, _selectedIndex == 2 ? -20 : 0, 0),
                  child: SvgPicture.asset(
                    _selectedIndex == 2 ? AppIcons.activeequipment : AppIcons.unactiveequipment,
                    width: _selectedIndex == 2 ? 56.w : 24.w,
                    height: _selectedIndex == 2 ? 56.h : 24.h,
                  ),
                ),
                label: _selectedIndex == 2 ? 'My Equipment' : "",
              ),
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  transform: Matrix4.translationValues(0, _selectedIndex == 3 ? -20 : 0, 0),
                  child: SvgPicture.asset(
                    _selectedIndex == 3 ? AppIcons.activetrainer : AppIcons.unactivetrainergry,
                    width: _selectedIndex == 3 ? 56.w : 24.w,
                    height: _selectedIndex == 3 ? 56.h : 24.h,
                  ),
                ),
                label: _selectedIndex == 3 ? '225 Trainer' : "",
              ),
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  transform: Matrix4.translationValues(0, _selectedIndex == 4 ? -20 : 0, 0),
                  child: SvgPicture.asset(
                    _selectedIndex == 4 ? AppIcons.activestory : AppIcons.unactivestroyicon,
                    width: _selectedIndex == 4 ? 56.w : 24.w,
                    height: _selectedIndex == 4 ? 56.h : 24.h,
                  ),
                ),
                label: _selectedIndex == 4 ? 'My Story' : "",
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/widget/items_widget.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/recovery_journey/widget/tbi_recovery.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';




class MyEquipmentTwoScreen extends StatefulWidget {
  final File? savedImageFile;

  const MyEquipmentTwoScreen({Key? key, this.savedImageFile}) : super(key: key);

  @override
  State<MyEquipmentTwoScreen> createState() => _MyEquipmentTwoScreenState();
}

class _MyEquipmentTwoScreenState extends State<MyEquipmentTwoScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> categories = ['All', 'Strength', 'Cardio', 'Flexibility'];

  final List<String> image = [
    'assets/images/dumbbleimage.png',
    'assets/images/dumbbleimage.png',
    'assets/images/dumbbleimage.png',
    'assets/images/dumbbleimage.png',
  ];

  final List<String> title = [
    'Dumbbells (5kg)',
    'Stationary Bike',
    'Yoga Mat',
    'Dumbbells (5kg)',
  ];

  final List<String> subtitle = [
    'Strength',
    'Cardio',
    'Flexibility',
    'Strength',
  ];

  final List<String> icon = [
    'assets/icons/strengthicon.svg',
    'assets/icons/cardioicon.svg',
    'assets/icons/flexibilityicon.svg',
    'assets/icons/strengthicon.svg',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              child: Column(
                children: [
                  TBIRecovery(title: 'My Equipment'),
                ],
              ),
            ),
            UIHelper.verticalSpace(16.h),
            Container(
              color: AppColors.c181818,
              child: TabBar(
                dividerColor: Colors.transparent,
                controller: _tabController,
                indicatorColor: AppColors.c87B842,
                indicatorWeight: 1.h,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                labelStyle: TextFontStyle.textStyle14w400c87B842poppins,
                unselectedLabelStyle: TextFontStyle.textStyle14w400c87B842poppins,
                tabs: categories.map((category) => Tab(text: category)).toList(),
                isScrollable: false,
              ),
            ),
            UIHelper.verticalSpace(35.h),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    ItemsWidget(),
                    UIHelper.verticalSpace(35.h),
                    ListView.builder(
                      itemCount: title.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 16.h),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.c181818,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(color: AppColors.c454545, width: 1.w),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 140.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.r),
                                      topRight: Radius.circular(20.r),
                                    ),
                                    image: DecorationImage(
                                      image: widget.savedImageFile != null
                                          ? FileImage(widget.savedImageFile!) as ImageProvider
                                          : AssetImage(image[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                UIHelper.verticalSpace(12.h),
                                Text(
                                  title[index],
                                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                UIHelper.verticalSpace(8.h),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      icon[index],
                                      height: 24.h,
                                    ),
                                    UIHelper.horizontalSpace(8.w),
                                    Text(
                                      subtitle[index],
                                      style: TextFontStyle.textStyle14w400c87B842poppins.copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    UIHelper.verticalSpace(22.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: AppColors.c87B842,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(Icons.add, color: AppColors.c181818),
          onPressed: () {
            NavigationService.navigateTo(Routes.addEquipmentScreen);
          },
        ),
      ),
    );
  }
}

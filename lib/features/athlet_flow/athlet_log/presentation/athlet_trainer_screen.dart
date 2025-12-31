
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/widget/custom_coming_soon.dart';
import 'package:ktmtommy_apps/features/athlet_flow/athlet_log/widget/widget_motivations.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';
import '../../../recovery_mood_section/recovery_journey/widget/custom_trainer.dart';


class AthletTrainerScreen extends StatefulWidget {
  const AthletTrainerScreen({super.key});

  @override
  State<AthletTrainerScreen> createState() => _AthletTrainerScreenState();
}

class _AthletTrainerScreenState extends State<AthletTrainerScreen> {

  int selectedIndex = -1;
  bool _dontShowAgain = false;

  late final List<Map<String, String>> allTrainers;

  final List<Map<String, String>> trainers = [
    {
      'image': 'assets/images/chillimage.png',
      'text': 'Chill',
      'title': 'Calm, supportive feedback, relaxed tone',
      'subtitle': '"Lets take it easy but stay consistent!"',
    },
  ];

  final List<Map<String, String>> neutral = [
    {
      'image': 'assets/images/standardimage.png',
      'text': 'Standard',
      'title': 'Neutral, instructional and straightforward',
      'subtitle': '"Focus on form and progress steadily."',
    },
  ];

  final List<Map<String, String>> humorous = [
    {
      'image': 'assets/images/tomimage.png',
      'text': 'Outrageous Tom',
      'title': 'Over-the-top, humorous, loud, eccentric',
      'subtitle':
      'This trainer just tells you what to do - no options, no excuses!',
    },
  ];

  @override
  void initState() {
    super.initState();
    allTrainers = [...trainers, ...neutral, ...humorous];
  }
  void _showHumorousDialog(BuildContext context, Map<String, String> trainer) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            backgroundColor: AppColors.c181818,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: AppColors.orangeColor, width: 1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppIcons.disclamericon, height: 24.h),
                UIHelper.horizontalSpace(16.w),
                Text(
                  'Disclaimer',
                  textAlign: TextAlign.center,
                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                      .copyWith(fontSize: 20.sp),
                ),
                UIHelper.horizontalSpace(25.w),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(AppIcons.crossicon, height: 24.h),
                ),
              ],
            ),
            content: Text(
              trainer['subtitle'] ?? '',
              style: TextFontStyle.textStyle14w400cE8E8E8poppins
                  .copyWith(fontSize: 18.sp),
            ),
            actions: [
              Row(
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      checkboxTheme: CheckboxThemeData(
                        side: MaterialStateBorderSide.resolveWith((states) {
                          if (states.contains(MaterialState.selected)) {
                            return const BorderSide(
                                color: AppColors.orangeColor, width: 1);
                          }
                          return const BorderSide(
                              color: AppColors.c181818, width: 1);
                        }),
                        fillColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.selected)) {
                            return AppColors.c181818;
                          }
                          return Colors.transparent;
                        }),
                        checkColor:
                        MaterialStateProperty.all(AppColors.orangeColor),
                      ),
                    ),
                    child: Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.r)),
                      checkColor: AppColors.orangeColor,
                      activeColor: AppColors.c181818,
                      side: BorderSide(color: AppColors.orangeColor, width: 1),
                      value: _dontShowAgain,
                      onChanged: (bool? newValue) {
                        setStateDialog(() {
                          _dontShowAgain = newValue ?? false;
                        });
                      },
                    ),
                  ),
                  UIHelper.horizontalSpace(8.w),
                  Text(
                    'Don’t show again!',
                    style: TextFontStyle.textStyle16w400c757575poppins,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:  Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(AppImages.tarinaimage),fit: BoxFit.cover)
          ),child:  SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
      //============================== text =============================//

                Text(
                  'My Trainer',
                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                UIHelper.verticalSpace(8.h),


      //=========================== text ===========================//
                Text(
                  'Choose your training companion to guide and motivate you!',
                  style: TextFontStyle.textStyle24w400cA3A3A3poppins.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
                UIHelper.verticalSpace(18.h),

//====================================== Listview ===========================//

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: allTrainers.length,
                          itemBuilder: (context, index) {
                            final trainer = allTrainers[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 18.h),
                              child: CustomComingSoon(
                                imagePath: trainer['image'] ?? '',
                                text: trainer['text'] ?? '',
                                title: trainer['title'] ?? '',
                                subtitle: trainer['subtitle'] ?? '',
                                isSelected: selectedIndex == index,
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });

                                  // Show popup ONLY for humorous trainers
                                  if (trainer['text'] == "Outrageous Tom") {
                                    _showHumorousDialog(context, trainer);
                                  }
                                },
                              ),
                            );
                          },
                        ),


//=========================================== CustomMotivation ====================================//

                        WidgetMotivations(),
                        UIHelper.verticalSpace(24.h),

        //============================== Button ===============================//

                        CustomButtonWidget(
                          onTap: (){
                            NavigationService.navigateTo(Routes.aiChatScreen);
                          },
                            textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                            image: DecorationImage(image: AssetImage(AppImages.orangebutton)),
                            text: 'Use This Trainer'),
                        UIHelper.verticalSpace(20.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        )


    );
  }
}

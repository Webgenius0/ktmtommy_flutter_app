
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/arrow_button_athelete_flow.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button_widget.dart';
import 'package:ktmtommy_apps/features/athlet_flow/log_food/athlet_log_food_empty/widget/ingredient_breakdown.dart';
import 'package:ktmtommy_apps/features/athlet_flow/log_food/athlet_log_food_empty/widget/meal_widget.dart';
import 'package:ktmtommy_apps/features/athlet_flow/log_food/athlet_log_food_empty/widget/nutritions_widget.dart';
import 'package:ktmtommy_apps/features/athlet_flow/log_food/athlet_log_food_empty/widget/progress_widget.dart';
import 'package:ktmtommy_apps/helpers/all_routes.dart';
import 'package:ktmtommy_apps/helpers/navigation_service.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';





class AthletMealAnalyzeScreen extends StatefulWidget {
  final String imagePath;

  const AthletMealAnalyzeScreen({super.key, required this.imagePath});
  @override
  State<AthletMealAnalyzeScreen> createState() => _AthletMealAnalyzeScreenState();
}

class _AthletMealAnalyzeScreenState extends State<AthletMealAnalyzeScreen> {


  final List<Map<String,dynamic>> traleadingTitle = [

    {
      "title":'Brown rice' ,
      "value":'1 cup (185g)'
    },

    {
      "title":'Grilled chicken' ,
      "value": '4 oz (115g)',
    },

    {
      "title":'Avocado',
      "value": '½ (75g)',
    },

    {
      "title":'Broccoli',
      "value": '½ cup (45g)',
    },

    {
      "title": 'Grilled carrots',
      "value":'¼ cup (30g)'
    }



  ];







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [

  //====================== Arrw button ==============================//

              ArrowButtonAtheleteFlow(
                text: 'Meal Analyze',
                subtitle: 'Nutritional breakdown & insights',
                onTap: () {
                  NavigationService.goBack;
                },
              ),

              UIHelper.verticalSpace(24.h),

//=========================================  SingleChildScrollView =================================//



              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

   //============================= Mealwidget ================================//
                      MealWidget(imagePath: widget.imagePath),

                      UIHelper.verticalSpace(24.h),
    //=================================== Progress ===========================//

                      ProgressWidget(
                        nutrients: [
                          {
                            'title': 'Carbs',
                            'percentage': '45%',
                            'grams': '(69g)',
                            'progress': 0.3,
                            'color': AppColors.cFFFFFF,
                          },
                          {
                            'title': 'Protein',
                            'percentage': '30%',
                            'grams': '(46g)',
                            'progress': 0.4,
                            'color': AppColors.orangeColor,
                          },
                          {
                            'title': 'Fat',
                            'percentage': '25%',
                            'grams': '(17g)',
                            'progress': 0.2,
                            'color': AppColors.cCC1F28,
                          },

                        ],
                      ),
                      UIHelper.verticalSpace(24.h),


     //=================================   Nutrition       ===============================//

                      NutritionsWidget(text: 'Nutrition Facts'),
                      UIHelper.verticalSpace(24.h),


//========================================= IngredientBreakdown =================================//

                      IngredientBreakdown(traleadingTitle: traleadingTitle),
                      UIHelper.verticalSpace(24.h),


//=========================================== Done ================================//


                      Container(
                        width: double.infinity,
                        decoration: ShapeDecoration(
                            color:  Color(0xFF181818),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            )),child: Padding(
                        padding:  EdgeInsets.symmetric(vertical: 16.h,horizontal: 16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

   //======================================= Nutritional ===================================//
                            Row(
                              children: [
                                SvgPicture.asset(AppIcons.whaticon,height: 20.h,color: AppColors.orangeColor,),
                                UIHelper.horizontalSpace(8.w),
                                Text(
                                  'Nutritional Insights',
                                  style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                                    fontSize: 18.sp,fontWeight: FontWeight.w400
                                  )
                                ),

                              ],
                            ),
                            UIHelper.verticalSpace(16.h),

  //======================================protein =====================================//



                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 2.w,
                                  height: 55.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.orangeColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12.r),
                                      bottomLeft: Radius.circular(12.r),
                                    ),
                                  ),
                                ),
                                UIHelper.horizontalSpace(7.w),
                                Text(
                                    'Good protein source - helps with muscle\nrecovery',
                                    style: TextFontStyle.textStyle14w400cBABABApoppins
                                ),
                              ],
                            ),
                            UIHelper.verticalSpace(16.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 2.w,
                                  height: 55.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.orangeColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12.r),
                                      bottomLeft: Radius.circular(12.r),
                                    ),
                                  ),
                                ),
                                UIHelper.horizontalSpace(7.w),
                                Text(
                                    'Consider adding more vegetables for\nadditional fiber',
                                    style: TextFontStyle.textStyle14w400cBABABApoppins
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ),
                      UIHelper.verticalSpace(24.h),

                      CustomButtonWidget(
                        textStyle: TextFontStyle.textStyle20w700cFFFFFFTeko,
                        image: DecorationImage(image: AssetImage(AppImages.orangebutton)),
                        text: 'Save Log',
                        onTap: (){
                          NavigationService.navigateTo(Routes.athletLogFoodEmptyScreen);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}









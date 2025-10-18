
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';




class GallryCameraWidget extends StatelessWidget {
  const GallryCameraWidget({
    super.key,
    required this.imagePath,
    required this.onRetake,
  });

  final String imagePath;
  final Future<void> Function(ImageSource source) onRetake;


  //=============================================  Camera And Gallery =====================================//

  void _showPickOption(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.c181818,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt,color: AppColors.orangeColor),
                title:  Text("Take Photo",style: TextStyle(color: AppColors.orangeColor )),
                onTap: () {
                  Navigator.pop(context);
                  onRetake(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: AppColors.orangeColor ,),
                title:  Text("Choose from Gallery",style: TextStyle(color:AppColors.orangeColor )),
                onTap: () {
                  Navigator.pop(context);
                  onRetake(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
//======================================= Done ====================================//

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300.h,
      decoration: BoxDecoration(
        color: AppColors.c2E2F34,
        border: Border.all(color: AppColors.c454545, width: 1.w),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                  child: Image.file(
                    File(imagePath),
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.c181818,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              ),
            ),
            child: GestureDetector(
              onTap: () => _showPickOption(context),
              child: Column(
                children: [
                  UIHelper.verticalSpace(18.h),
                  Image.asset(
                    AppImages.orangecamera,
                    height: 70.h,
                  ),
                  UIHelper.verticalSpace(18.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

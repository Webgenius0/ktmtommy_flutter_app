
import 'dart:io' show File;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';




class CustomDotted extends StatefulWidget {
  final String text;
  final String textmb;
  final Widget icon;
  final ValueChanged<File?> onImagePicked;

  const CustomDotted({
    super.key,
    required this.text,
    required this.textmb,
    required this.icon,
    required this.onImagePicked,
  });

  @override
  State<CustomDotted> createState() => _CustomDottedState();
}

class _CustomDottedState extends State<CustomDotted> {
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _showImageSourceDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.c2A2A2A,
        title: Text(
          'Select Image Source',
          style: TextFontStyle.textStyle14w400c87B842poppins,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo_library, color: AppColors.c87B842),
              title: Text(
                'Gallery',
                style: TextFontStyle.textStyle14w400c87B842poppins,
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt, color: AppColors.c87B842),
              title: Text(
                'Camera',
                style: TextFontStyle.textStyle14w400c87B842poppins,
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
      widget.onImagePicked(_pickedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: AppColors.c454545,
      strokeWidth: 1.5,
      dashPattern:  [10, 4],
      borderType: BorderType.RRect,
      radius: Radius.circular(12.r),
      child: GestureDetector(
        onTap: () => _showImageSourceDialog(context),
        child: Container(
          width: double.infinity,
          height: 160.h,
          decoration: BoxDecoration(
            color: AppColors.c2A2A2A,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (_pickedImage != null)
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.file(
                      _pickedImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_pickedImage == null)
                    Image.asset(AppImages.camera, height: 60.h),
                  UIHelper.verticalSpace(8.h),
                  Text(
                    'Tap to add photo',
                    textAlign: TextAlign.center,
                    style: TextFontStyle.textStyle24w400cA3A3A3poppins.copyWith(
                      fontSize: 13.sp,
                    ),
                  ),
                  UIHelper.verticalSpace(4.h),
                  Text(
                    'Gallery or Camera',
                    textAlign: TextAlign.center,
                    style: TextFontStyle.textStyle24w400cA3A3A3poppins.copyWith(
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
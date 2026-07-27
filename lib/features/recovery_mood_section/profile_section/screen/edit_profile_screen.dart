import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_fonts.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/assets_helper/app_image.dart';
import 'package:ktmtommy_apps/common_widgets/custom_arrow_back.dart';
import 'package:ktmtommy_apps/common_widgets/custom_button.dart';
import 'package:ktmtommy_apps/constants/app_constants.dart';
import 'package:ktmtommy_apps/helpers/di.dart';
import 'package:ktmtommy_apps/helpers/ui_helpers.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController(text: appData.read(kKeyuserEmail));
  final TextEditingController _ageController = TextEditingController();

  // State variables
  XFile? _selectedImage;
  DateTime? _selectedDate;
  String? _selectedGender;

  // Image picker
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      setState(() => _selectedImage = image);
    }
  }

  Future<void> _showImagePicker() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.c181818,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UIHelper.verticalSpace(12.h),
            Container(width: 40.w, height: 4.h, decoration: BoxDecoration(color: AppColors.c454545, borderRadius: BorderRadius.circular(2.r))),
            UIHelper.verticalSpace(20.h),
            ListTile(
              leading: Icon(Icons.photo_library, color: AppColors.c87B842),
              title: Text('Gallery', style: TextStyle(color: Colors.white, fontSize: 16.sp)),
              onTap: () {
                _pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt, color: AppColors.c87B842),
              title: Text('Camera', style: TextStyle(color: Colors.white, fontSize: 16.sp)),
              onTap: () {
                _pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            UIHelper.verticalSpace(20.h),
          ],
        ),
      ),
    );
  }

  // Date picker
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppColors.c87B842,
              onPrimary: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        int age = DateTime.now().year - picked.year;
        if (DateTime.now().month < picked.month ||
            (DateTime.now().month == picked.month && DateTime.now().day < picked.day)) {
          age--;
        }
        _ageController.text = age.toString();
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bacroundColorBlack,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Appbar (same as MyProfileSettingScreen)
            CustomAppbarWidget(
              onTap: () => Navigator.pop(context),
              text: 'Edit Profile',
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    UIHelper.verticalSpace(30.h),

                    ///================ Profile Photo Section===================
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 110.h,
                            width: 110.w,
                            child: CircleAvatar(
                              radius: 55.r,
                              backgroundImage: _selectedImage != null
                                  ? FileImage(File(_selectedImage!.path))
                                  : const AssetImage(AppImages.tomimage) as ImageProvider,
                            ),
                          ),
                          Positioned(
                            bottom: 3.h,
                            right: -5.w,
                            child: GestureDetector(
                              onTap: _showImagePicker,
                              child: Container(
                                padding: EdgeInsets.all(8.w),
                                decoration: const BoxDecoration(
                                  color: AppColors.c87B842,
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  AppIcons.cammera,
                                  width: 18.w,
                                  height: 18.h,
                                  colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),


                    UIHelper.verticalSpace(40.h),

                    // Form Container
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Full Name',
                              style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                                  .copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(8.h),
                        // Full Name
                        _buildTextField(
                          controller: _nameController,
                          hint: "Full Name",
                          icon: AppIcons.profile_icon,
                        ),

                        UIHelper.verticalSpace(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'E-mail Address',
                              style: TextFontStyle.textStyle24w600cFFFFFFpoppins
                                  .copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(8.h),
                        // Email
                        _buildTextField(
                          readOnly: true,
                          controller: _emailController,
                          hint: "Email Address",
                          icon: AppIcons.email_icon,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        UIHelper.verticalSpace(16.h),

                      ],
                    ),


                    UIHelper.verticalSpace(200.h),
                    ///================ Update Button=============================
                    CustomButton(
                      context: context,
                      name: "Update",
                      onCallBack: () {
                        debugPrint("===============>>> Update Clicked");
                        debugPrint("Name: ${_nameController.text}");
                        debugPrint("Email: ${_emailController.text}");
                        debugPrint("Image: ${_selectedImage?.path ?? 'No change'}");
                      },
                      borderColor: AppColors.c87B842,
                      color: AppColors.c87B842,
                      height: 50.h,
                      borderRadius: 999.r,
                      textStyle: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    UIHelper.verticalSpace(20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///========= Reusable TextField (matching MyProfileSettingScreen style)=======
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required String icon,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    VoidCallback? onTap,
    IconData? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      enableInteractiveSelection: !readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      style: TextFontStyle.textStyle24w600cFFFFFFpoppins.copyWith(
        fontSize: 15.sp,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.cA3A3A3, fontSize: 15.sp),
        prefixIcon: Padding(
          padding: EdgeInsets.all(12.w),
          child: SvgPicture.asset(icon, width: 20.w, height: 20.h, colorFilter: const ColorFilter.mode(AppColors.c87B842, BlendMode.srcIn)),
        ),
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, color: AppColors.c87B842)
            : null,
        filled: true,
        fillColor: AppColors.c2F2F2F,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16.h),
      ),
    );
  }

}
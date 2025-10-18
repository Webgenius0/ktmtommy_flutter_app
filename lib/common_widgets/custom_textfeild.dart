
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../assets_helper/app_colors.dart';
import '../assets_helper/app_fonts.dart';

class CustomTextfield extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final double? fieldHeight;
  final int? maxline;
  final String? Function(String?)? validator;
  final bool? validation;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? isObsecure;
  final bool? isPass;

  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final bool? isEnabled;
  final double? cursorHeight;
  final Color? disableColor;
  final bool? isRead;
  final double? borderRadius;
  final Color? fillColor;
  final TextStyle? hintTextSyle;
  final Color? borderColor;
  final TextAlign? textAlign;
  final VoidCallback? ontap;
  final EdgeInsetsGeometry? contentPadding;

  final bool? idoNotErrorBorder;

  const CustomTextfield({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    this.inputType,
    this.fieldHeight,
    this.maxline,
    this.validator,
    this.validation,
    this.suffixIcon,
    this.prefixIcon,
    this.isObsecure = false,
    this.isPass = false,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.onChanged,
    this.inputFormatters,
    this.labelStyle,
    this.isEnabled,
    this.style,
    this.cursorHeight,
    this.disableColor,
    this.isRead = false,
    this.borderRadius,
    this.fillColor,
    this.hintTextSyle,
    this.borderColor,
    this.textAlign = TextAlign.center,
    this.ontap,
    this.contentPadding,  this.idoNotErrorBorder = false
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.isObsecure ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: widget.textAlign ?? TextAlign.left,
      readOnly: widget.isRead ?? false,
      cursorHeight: widget.cursorHeight ?? 20,
      focusNode: widget.focusNode,
      obscureText: _obscureText,
      onTap: widget.ontap,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      maxLines: widget.maxline ?? 1,
      controller: widget.controller,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      enabled: widget.isEnabled,
      obscuringCharacter: "*",
      decoration: InputDecoration(
        suffixIcon: widget.isPass == true
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: AppColors.cC0C0C0,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : (widget.suffixIcon != null
            ? SizedBox(width: 14.w, height: 14.h, child: widget.suffixIcon)
            : null),
        prefixIcon: widget.prefixIcon != null
            ? SizedBox(width: 14.w, height: 14.h, child: widget.prefixIcon)
            : null,
        fillColor: widget.fillColor ?? Colors.transparent,
        filled: true,
        contentPadding: widget.contentPadding ??
            EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        hintText: widget.hintText,
        hintStyle: widget.hintTextSyle ??
            TextFontStyle.textStyle16w400c5C5C5C.copyWith(
              color: AppColors.cC0C0C0,
              fontWeight: FontWeight.w400,
            ),
        labelText: widget.labelText,
        border: widget.borderRadius != null
            ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius!),
        )
            : null,
        enabledBorder: widget.borderRadius != null
            ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius!),
          borderSide: BorderSide(
            color: widget.borderColor ??  Colors.transparent,
            width: 1,
          ),
        )
            : UnderlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.transparent,
            width: 1,
          ),
        ),
        focusedBorder: widget.borderRadius != null
            ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius!),
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.transparent,
            width: 1.5,
          ),
        )
            : UnderlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.transparent,
            width: 1.5,
          ),
        ),
        errorBorder:widget.idoNotErrorBorder == true? UnderlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1
          )
        ): widget.borderRadius != null
            ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius!),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        )
            : UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedErrorBorder: widget.borderRadius != null
            ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius!),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
        )
            : UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
        ),
        disabledBorder: widget.borderRadius != null
            ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius!),
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.transparent,
            width: 1,
          ),
        )
            : UnderlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.transparent,
            width: 1,
          ),
        ),
      ),
      style: widget.style ??
          TextFontStyle.textStyle16w400c5C5C5C.copyWith(
            color: AppColors.c333333,
          ),
      keyboardType: widget.inputType,
    );
  }
}
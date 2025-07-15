// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';
import '../constants/text_font_style.dart';
import '../gen/colors.gen.dart';
import '../helpers/helper_methods.dart';

class CustomTextFormField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool isPrefixIcon;
  final AutovalidateMode? autovalidateMode;
  final double borderRadius;
  final VoidCallback? onSuffixIconTap;
  final String? iconpath;
  final FocusNode? focusNode;
  TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  List<TextInputFormatter>? inputFormatters;
  final int? maxLine;
  final bool? isReadOnly;
  final VoidCallback? onTap;

  CustomTextFormField(
      {super.key,
      this.labelText,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      this.autovalidateMode = AutovalidateMode.onUserInteraction,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.onChanged,
      this.validator,
      this.borderRadius = 40.0, // Set to 10 pixels
      required this.isPrefixIcon,
      this.iconpath,
      this.onSuffixIconTap,
      this.focusNode,
      this.onFieldSubmitted,
      this.inputFormatters,
      this.textInputAction = TextInputAction.next,
      this.maxLine = 1,
      this.isReadOnly = false, this.onTap});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: TextFormField(
        onTap: widget.onTap,
        readOnly: widget.isReadOnly ?? false,
        autovalidateMode: widget.autovalidateMode,
        focusNode: _focusNode,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        onChanged: widget.onChanged,
        validator: widget.validator,
        inputFormatters: widget.inputFormatters,
        textInputAction: widget.textInputAction,
        maxLines: widget.maxLine,
        style: TextFontStyle.headline16StyleCabin500
            .copyWith(color: AppColors.white),
        cursorColor: appColor(),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.c1C1C1C,
          labelText: widget.labelText,
          hintText: widget.hintText,
          hintStyle: TextFontStyle.headline16StyleCabin500
              .copyWith(color: AppColors.c5A5C5F),
          prefixIcon: widget.isPrefixIcon && widget.iconpath != null
              ? Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 12.w),
                  child: SvgPicture.asset(
                    widget.iconpath!,
                    width: 24.w,
                    // color: _isFocused ? AppColors.cAEC671 : AppColors.c1E232C,
                  ),
                )
              : null,
          suffixIcon: widget.suffixIcon != null
              ? GestureDetector(
                  onTap: widget.onSuffixIconTap,
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: Icon(
                      widget.suffixIcon,
                      color: _isFocused ? appColor() : AppColors.cA8A8A8,
                    ),
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(width: 1.sp, color: AppColors.c1C1C1C),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              width: 1.sp,
              color: AppColors
                  .allPrimaryColor, // Adjust the border width if needed
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(width: 1.sp, color: AppColors.cFDDBDD),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(width: 1.sp, color: AppColors.cFDDBDD),
          ),
          disabledBorder: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        ),
      ),
    );
  }
}

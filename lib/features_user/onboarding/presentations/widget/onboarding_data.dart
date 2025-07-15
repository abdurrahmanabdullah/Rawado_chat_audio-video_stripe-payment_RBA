import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/gen/assets.gen.dart';
import 'package:rawado/gen/colors.gen.dart';
import 'package:rawado/helpers/ui_helpers.dart';

import '../../../../helpers/helper_methods.dart';

class OnboardingData {
  final Color backgroundColor;
  final Widget child;

  OnboardingData({required this.backgroundColor, required this.child});
}

class OnboardingDataWidgets extends StatelessWidget {
  final OnboardingData data;

  const OnboardingDataWidgets({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Logo image Section
        Image.asset(
          Assets.images.onboardingImage.path,
          fit: BoxFit.cover,
        ),

        Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: SizedBox(
            child: Image.asset(
              Assets.images.blackGradiant.path,
              fit: BoxFit.cover,
            ),
          ),
        ),

        // // Bottom gradient
        // Positioned(
        //   bottom: 0,
        //   left: 0,
        //   right: 0,
        //   child: Container(
        //     height: 200.h, // Adjust the height of the gradient
        //     decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //         begin: Alignment.topCenter,
        //         end: Alignment.bottomCenter,
        //         colors: [
        //           Colors.black.withOpacity(0.9), // Starts transparent
        //           Colors.black, // Ends with a black overlay
        //         ],
        //       ),
        //     ),
        //   ),
        // ),

        // Title Section
        Positioned(
          top: 400.h,
          left: 16.sp,
          right: 16.sp,
          child: data.child,
        ),
      ],
    );
  }
}

class LanguageSelect extends StatefulWidget {
  const LanguageSelect({super.key});

  @override
  State<LanguageSelect> createState() => _LanguageSelectState();
}

class _LanguageSelectState extends State<LanguageSelect> {
  String? selectedProfileType = 'ENGLISH';
  bool _isEnglish = true;
  bool _isArabic = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UIHelper.verticalSpaceMedium,
        Text(
          'SELECT YOUR LANGUAGE',
          style: TextFontStyle.headline24StyleCabin700,
          textAlign: TextAlign.center,
        ),
        UIHelper.verticalSpace(8.h),
        LanguageButton(
          onTap: () {
            setState(() {
              _isEnglish = true;
              _isArabic = false;
              selectedProfileType = 'ENGLISH';
            });
          },
          title: 'ENGLISH',
          isSelected: _isEnglish,
        ),
        UIHelper.verticalSpace(8.h),
        LanguageButton(
          onTap: () {
            setState(() {
              _isEnglish = false;
              _isArabic = true;
              selectedProfileType = 'ARABIC';
            });
          },
          title: 'ARABIC',
          isSelected: _isArabic,
        ),
      ],
    );
  }
}

class LanguageButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback? onTap;
  const LanguageButton({
    super.key,
    required this.title,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 58.h,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.c1C1C1C,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
              width: 2, color: isSelected ? appColor() : AppColors.c1C1C1C),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextFontStyle.headline16StyleCabin500
                  .copyWith(color: AppColors.cCFCFCF),
            ),
            isSelected
                ? CircleAvatar(
                    radius: 10,
                    backgroundColor: appColor(),
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: AppColors.c1C1C1C,
                      child: CircleAvatar(
                        radius: 6,
                        backgroundColor: appColor(),
                      ),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

class WorkoutWidget extends StatelessWidget {
  const WorkoutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UIHelper.verticalSpaceLarge,
            Text(
              'LEAD THE PACK',
              style: TextFontStyle.headline32StyleCabin700,
              textAlign: TextAlign.center,
            ),
            UIHelper.verticalSpace(8.h),
            Text(
              'UNLEASH YOUR POWER WITH WOLF - WHEREVER, WHENEVER',
              style: TextFontStyle.headline14StyleCabin500
                  .copyWith(color: AppColors.cA7A7A7),
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }
}

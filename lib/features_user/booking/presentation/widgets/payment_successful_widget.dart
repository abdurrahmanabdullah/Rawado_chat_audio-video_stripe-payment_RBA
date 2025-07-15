import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/common_wigdets/auth_button.dart';
import 'package:rawado/common_wigdets/custom_container.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/gen/colors.gen.dart';
import 'package:rawado/helpers/navigation_service.dart';
import 'package:rawado/helpers/ui_helpers.dart';

import '../../../../helpers/helper_methods.dart';

class PaymentSuccessfulWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subTitle;
  final VoidCallback? onTap;
  const PaymentSuccessfulWidget(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.subTitle,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      boarder: 20.r,
      height: 491,
      color: AppColors.c353535,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: 200.h,
            width: 200.w,
            fit: BoxFit.cover,
          ),
          UIHelper.verticalSpace(16.h),
          Text(title,
              textAlign: TextAlign.center,
              style: TextFontStyle.headline24StyleCabin700),
          UIHelper.verticalSpace(16.h),
          Text(subTitle,
              textAlign: TextAlign.center,
              style: TextFontStyle.headline14StyleCabin500
                  .copyWith(color: AppColors.cA7A7A7)),
          UIHelper.verticalSpace(16.h),
          AppCustomeButton(
              name: 'BACK TO HOME',
              onCallBack: () {
                if (onTap != null) {
                  onTap!();
                } else {
                  NavigationService.goBack;
                }
              },
              height: 54.h,
              minWidth: 271.w,
              borderRadius: 40.r,
              color: appColor(),
              textStyle: TextFontStyle.headline16StyleCabin700
                  .copyWith(color: appTextColor()),
              context: context)
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/constants/app_constants.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/helpers/all_routes.dart';
import 'package:rawado/helpers/di.dart';
import 'package:rawado/helpers/navigation_service.dart';

import '../../../../helpers/helper_methods.dart';

class BottomButtons extends StatelessWidget {
  final int currentIndex;
  final int dataLength;
  final PageController controller;

  const BottomButtons(
      {super.key,
      required this.currentIndex,
      required this.dataLength,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: currentIndex == dataLength - 1
            //Login Button for last page
            ? GestureDetector(
                onTap: () async{
                  await appData.write(kKeyIsFirstTime, false);
                  NavigationService.navigateTo(Routes.logInScreen);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  width: 154.w,
                  height: 54.h,
                  decoration: BoxDecoration(
                      color: appColor(),
                      border: Border.all(color: appColor(), width: 2.w),
                      borderRadius: BorderRadius.circular(40.r)),
                  child: Text(
                    "NEXT",
                    style: TextFontStyle.headline16StyleCabin700
                        .copyWith(color: appTextColor()),
                    textAlign: TextAlign.center,
                  ),
                ),
              )

            //Skip Now Button
            : GestureDetector(
                onTap: () {
                  controller.nextPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  width: 154.w,
                  height: 54.h,
                  decoration: BoxDecoration(
                      color: appColor(),
                      border: Border.all(color: appColor(), width: 2.w),
                      borderRadius: BorderRadius.circular(40.r)),
                  child: Text(
                    "GET STARTED",
                    style: TextFontStyle.headline16StyleCabin700
                        .copyWith(color: appTextColor()),
                    textAlign: TextAlign.center,
                  ),
                ),
              ));
  }
}

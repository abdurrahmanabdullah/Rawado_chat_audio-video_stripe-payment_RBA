// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rawado/provider/address_provider.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../../constants/text_font_style.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../helpers/ui_helpers.dart';
import '../../../../common_wigdets/auth_button.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../helpers/helper_methods.dart';

class LocationBottomSheet extends StatelessWidget {
  final Function()? onTapConfirm;
  final String? lat;
  final String? lon;
  final String? buttonName;
  const LocationBottomSheet({
    super.key,
    this.onTapConfirm,
    this.lat,
    this.lon,
    this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.c222222,
          borderRadius: BorderRadius.vertical(top: Radius.circular(42.sp))),
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Center(
            child: Container(
              height: 5.h,
              width: 135.w,
              decoration: BoxDecoration(
                  color: appColor(),
                  borderRadius: BorderRadius.all(Radius.circular(100.sp))),
            ),
          ),
          UIHelper.verticalSpaceLarge,
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: UIHelper.kDefaulutPadding()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icons.location,
                      height: 21.h,
                      width: 32.w,
                      color: AppColors.white,
                    ),
                    UIHelper.horizontalSpace(16.w),
                    SizedBox(
                      width: 230.w,
                      child: Consumer<AddressProvider>(
                          builder: (context, address, _) {
                        return Text(
                          address.address ?? 'SET LOCATION MANUALLY',
                          style: TextFontStyle.headline14StyleCabin500,
                        );
                      }),
                    ),
                    const Spacer(),
                    // GestureDetector(
                    //   onTap: () {},
                    //   child: Text('CHANGE',
                    //       textAlign: TextAlign.right,
                    //       style: TextFontStyle.headline14StyleCabin500
                    //           .copyWith(color: appColor())),
                    // )
                  ],
                ),
                UIHelper.verticalSpaceMediumLarge,
                AppCustomeButton(
                  color: appColor(),
                  borderRadius: 40.sp,
                  context: context,
                  height: 54.h,
                  minWidth: double.infinity,
                  name: buttonName ?? 'USER CURRENT LOCATION',
                  onCallBack: () {
                    if (onTapConfirm == null) {
                      log('button null');
                      return;
                    }

                    onTapConfirm!();
                    // heldle login function\
                    // NavigationService.goBack;
                    // NavigationService.navigateTo(Routes.gpsSearch);
                  },
                  textStyle: TextFontStyle.headline16StyleCabin
                      .copyWith(color: appTextColor()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

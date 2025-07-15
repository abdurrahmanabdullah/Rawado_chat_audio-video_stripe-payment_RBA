// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/helpers/all_routes.dart';
import 'package:rawado/networks/api_acess.dart';

import '../../../../common_wigdets/auth_button.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helpers/helper_methods.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../helpers/social_login_helper.dart';
import '../../../../helpers/ui_helpers.dart';

class LogoutBottomsheet extends StatelessWidget {
  const LogoutBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.c222222,
          borderRadius: BorderRadius.vertical(top: Radius.circular(42.sp))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.h,
          ),
          UIHelper.verticalSpaceSmall,
          Text(
            'LOG OUT',
            style: TextFontStyle.headline24StyleCabin700,
          ),
          UIHelper.verticalSpaceSmall,
          UIHelper.customDivider(),
          UIHelper.verticalSpaceMediumLarge,
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: UIHelper.kDefaulutPadding()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "ARE YOU SURE YOU WANT TO LOG OUT",
                  style: TextFontStyle.headline16StyleCabin500,
                ),
                UIHelper.verticalSpaceMediumLarge,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: AppCustomeButton(
                        minWidth: 164.w,
                        borderSideColor: appColor(),
                        color: Colors.transparent,
                        borderRadius: 40.sp,
                        context: context,
                        height: 54.h,
                        name: 'CANCLE',
                        onCallBack: () {
                          // heldle login function\
                          NavigationService.goBack;
                        },
                        textStyle: TextFontStyle.headline16StyleCabin
                            .copyWith(color: AppColors.white),
                      ),
                    ),
                    UIHelper.horizontalSpaceMedium,
                    Flexible(
                      flex: 1,
                      child: AppCustomeButton(
                        color: appColor(),
                        borderRadius: 40.sp,
                        context: context,
                        height: 54.h,
                        minWidth: 164.w,
                        name: 'LOGOUT',
                        onCallBack: () async {
                          // heldle login function\
                          await getLogOutRXObj.fetchLogoutData();
                          SocialLoginHelper.instance.googleSignIn.signOut();
                          NavigationService.goBack;
                          Navigator.pushNamedAndRemoveUntil(
                              context, Routes.logInScreen, (route) => false);
                          // cleanLoginData();
                        },
                        textStyle: TextFontStyle.headline16StyleCabin
                            .copyWith(color: appTextColor()),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

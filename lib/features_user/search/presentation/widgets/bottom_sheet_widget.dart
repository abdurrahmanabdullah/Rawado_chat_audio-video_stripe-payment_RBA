import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../../constants/text_font_style.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../helpers/ui_helpers.dart';
import '../../../../common_wigdets/auth_button.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/helper_methods.dart';
import '../../../../helpers/navigation_service.dart';

class BottomSheetWidget extends StatelessWidget {
  final Function()? onTapConfirm;
  final String? lat;
  final String? lon;
  const BottomSheetWidget({
    super.key,
    this.onTapConfirm,
    this.lat,
    this.lon,
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
                    ),
                    UIHelper.horizontalSpace(16.w),
                    SizedBox(
                      width: 230.w,
                      child: Text(
                        "R880. DHAKA, RAMPURA, BANGLADESH R880",
                        style: TextFontStyle.headline14StyleCabin500,
                      ),
                    ),
                    const Spacer(),
                    Text('CHANGE',
                        textAlign: TextAlign.right,
                        style: TextFontStyle.headline14StyleCabin500
                            .copyWith(color: appColor()))
                  ],
                ),
                UIHelper.verticalSpaceMediumLarge,
                AppCustomeButton(
                  color: appColor(),
                  borderRadius: 40.sp,
                  context: context,
                  height: 54.h,
                  minWidth: double.infinity,
                  name: 'USER CURRENT LOCATION',
                  onCallBack: () {
                    // heldle login function\
                    NavigationService.navigateTo(Routes.manuallySearch);
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

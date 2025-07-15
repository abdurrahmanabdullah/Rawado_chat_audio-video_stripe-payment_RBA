import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common_wigdets/auth_button.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helpers/helper_methods.dart';
import '../../../../helpers/ui_helpers.dart';

class ExploreBanner extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onExploreTap;
  const ExploreBanner({
    super.key,
    this.onTap,
    this.onExploreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.sp, top: 10.sp, bottom: 10.sp),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.c1C1C1C,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -0,
            child: SizedBox(
              width: 74.w,
              height: 135.h,
              child: Image.asset(
                Assets.images.halfAmin.path,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 160.w,
                child: AppCustomeButton(
                  borderRadius: 40.sp,
                  color: appColor(),
                  context: context,
                  minWidth: 120.w,
                  height: 35.h,
                  name: 'STRENGTH TRAINER',
                  onCallBack: () {
                    if (onTap == null) {
                      return;
                    }
                    onTap;
                  },
                  textStyle: TextFontStyle.headline12StyleCabin500
                      .copyWith(color: appTextColor()),
                ),
              ),
              UIHelper.verticalSpaceSmall,
              Text(
                'LEAD THE PACK',
                style: TextFontStyle.headline16StyleCabin700,
              ),
              UIHelper.verticalSpaceSmall,
              SizedBox(
                width: 256.w,
                child: Text(
                  'YOUR JOURNEY TO FITNESS STARTS HERE',
                  style: TextFontStyle.headline12StyleCabin
                      .copyWith(color: AppColors.cA7A7A7),
                ),
              ),
              UIHelper.verticalSpaceSmall,
              GestureDetector(
                onTap: () {
                  if (onExploreTap == null) {
                    return;
                  }
                  onExploreTap;
                },
                child: Row(
                  children: [
                    Text(
                      'EXPLORE NOW',
                      style: TextFontStyle.headline14StyleCabin500
                          .copyWith(color: appColor()),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: appColor(),
                      size: 12.sp,
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/common_wigdets/custom_appbar.dart';
import 'package:rawado/gen/assets.gen.dart';
import 'package:rawado/gen/colors.gen.dart';
import 'package:rawado/helpers/ui_helpers.dart';
import '../../../common_wigdets/auth_button.dart';
import '../../../constants/text_font_style.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/helper_methods.dart';
import '../../../helpers/navigation_service.dart';



class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        // action: [
        //   GestureDetector(
        //     child: Padding(
        //       padding: const EdgeInsets.all(16.0),
        //       child: Image.asset(
        //         Assets.icons.crossPng.path,
        //       ),
        //     ),
        //   )
        // ],
        title: 'SEARCH',
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
        children: [
          Image.asset(
            Assets.images.searchImage.path,
            height: 404.h,
            fit: BoxFit.cover,
          ),
          UIHelper.verticalSpace(90.h),
          AppCustomeButton(
            borderSideColor: appColor(),
            borderRadius: 40.sp,
            color: Colors.transparent,
            context: context,
            height: 54.h,
            minWidth: double.infinity,
            name: 'USER CURRENT LOCATION',
            onCallBack: () {
              // heldle login function\
              NavigationService.navigateTo(Routes.gpsSearch);
            },
            textStyle: TextFontStyle.headline16StyleCabin
                .copyWith(color: AppColors.white),
          ),
          UIHelper.verticalSpaceMedium,
          AppCustomeButton(
            borderRadius: 40.sp,
            color: appColor(),
            context: context,
            height: 54.h,
            minWidth: double.infinity,
            name: 'SEARCH MANUALLY',
            onCallBack: () {
              // heldle login function\
              NavigationService.navigateTo(Routes.manuallySearch);
            },
            textStyle: TextFontStyle.headline16StyleCabin
                .copyWith(color: appTextColor()),
          ),
        ],
      ),
    );
  }
}

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/common_wigdets/custom_appbar.dart';
import 'package:rawado/common_wigdets/custom_container.dart';
import 'package:rawado/common_wigdets/loading_indicators.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/features_user/profile/model/profile_details_model.dart';
import 'package:rawado/gen/assets.gen.dart';
import 'package:rawado/gen/colors.gen.dart';
import 'package:rawado/helpers/all_routes.dart';
import 'package:rawado/helpers/navigation_service.dart';
import 'package:rawado/helpers/ui_helpers.dart';
import 'package:rawado/networks/api_acess.dart';
import 'package:svg_flutter/svg.dart';

import 'widgets/logout_bottomsheet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileData? profile = ProfileData();

  @override
  void initState() {
    // log('service id is : ${widget.serviceResponse!.data!.id!}');
    getProfileDetailsRXObj.getprofileDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isLeading: false,
        centerTitle: false,
        title: 'PROFILE',
      ),
      body: ListView(
        padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
        children: [
          ///profile data fetch...
          StreamBuilder(
              stream: getProfileDetailsRXObj.dataFetcher,
              builder: (context, snapshot) {
                final profileData = snapshot.data;
                profile = profileData?.data;
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData && snapshot.data != null) {
                  return Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.white,
                        radius: 50.r,
                        child: profileData?.data?.avatar != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50.r),
                                child: CachedNetworkImage(
                                  height: 100.h,
                                  width: 100.h,
                                  imageUrl: profileData?.data?.avatar,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      loadingIndicatorCircle(context: context),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error,
                                    color: Colors.redAccent,
                                    size: 50.sp,
                                  ),
                                ),
                              )
                            : Image.asset(Assets.images.profilePicture.path),
                      ),
                      Text(profileData!.data!.name!,
                          textAlign: TextAlign.center,
                          style: TextFontStyle.headline18StyleCabin700),
                      Text(profileData.data!.email!,
                          textAlign: TextAlign.center,
                          style: TextFontStyle.headline14StyleCabin
                              .copyWith(color: AppColors.cD7D7D7)),
                    ],
                  );
                } else {
                  return Center(
                    child: loadingIndicatorCircle(context: context),
                  );
                }
              }),

          UIHelper.verticalSpace(33.h),
          ProfileButton(
            onTap: () => NavigationService.navigateToWithObject(
                Routes.editProfile, profile),
            title: 'EDIT PROFILE',
            imagePath: Assets.icons.profile,
          ),
          UIHelper.verticalSpace(16.h),

          /// ----- TODO: IN MYWALLETSCREEN add your wallet system
          ProfileButton(
            onTap: () => NavigationService.navigateTo(
              Routes.myWallet,
            ),
            title: 'MY WALLET',
            imagePath: Assets.icons.profile,
          ),
          UIHelper.verticalSpace(16.h),
          ProfileButton(
            onTap: () =>
                NavigationService.navigateTo(Routes.appointmentHistory),
            title: 'APPOINTMENT HISTORY',
            imagePath: Assets.icons.calendar,
          ),
          UIHelper.verticalSpace(16.h),
          ProfileButton(
            onTap: () {
              NavigationService.navigateTo(Routes.selectTheme);
            },
            title: 'THEME',
            imagePath: Assets.icons.setting,
          ),
          UIHelper.verticalSpace(16.h),
          ProfileButton(
            onTap: () => NavigationService.navigateTo(Routes.settings),
            title: 'SETTINGS',
            imagePath: Assets.icons.setting,
          ),
          UIHelper.verticalSpace(16.h),
          ProfileButton(
            onTap: () {
              log('logout on tap');
              showBottom(context);
            },
            title: 'LOG OUT',
            imagePath: Assets.icons.logoutIcon,
          ),
          UIHelper.verticalSpace(16.h),
        ],
      ),
    );
  }

  void showBottom(BuildContext context) {
    showModalBottomSheet(
      elevation: 0,
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (builder) {
        return const LogoutBottomsheet();
      },
    );
  }
}

class ProfileButton extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback? onTap;
  const ProfileButton({
    super.key,
    this.onTap,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        boarder: 40.r,
        height: 54.w,
        child: Row(
          children: [
            SvgPicture.asset(imagePath),
            UIHelper.horizontalSpaceSmall,
            Text(title,
                style: TextFontStyle.headline16StyleCabin
                    .copyWith(color: AppColors.cCFCFCF))
          ],
        ),
      ),
    );
  }
}

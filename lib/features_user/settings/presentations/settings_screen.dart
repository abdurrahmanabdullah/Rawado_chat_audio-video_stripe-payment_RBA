import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/common_wigdets/custom_appbar.dart';
import '../../../gen/assets.gen.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/navigation_service.dart';
import '../../../helpers/ui_helpers.dart';
import '../../../helpers/url_lunch.dart';
import '../../profile/presentation/profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'SETTINGS',
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
        child: Column(
          children: [
            ProfileButton(
              onTap: () => NavigationService.navigateTo(Routes.changePassword),
              title: 'CHANGE PASSWORD',
              imagePath: Assets.icons.lock,
            ),
            UIHelper.verticalSpace(16.h),
            ProfileButton(
              onTap: () =>
                  openUrl('https://wegowolf.com/page/show/privacy-policy'),
              // onTap: () => NavigationService.navigateTo(Routes.privacyPolecy),
              title: 'PRIVACY POLICY',
              imagePath: Assets.icons.privacy,
            ),
            UIHelper.verticalSpace(16.h),
            ProfileButton(
              onTap: () => openUrl(
                  'https://wegowolf.com/page/show/terms-and-conditions'),
              // onTap: () => NavigationService.navigateTo(Routes.privacyPolecy),
              title: 'TERMS & CONDITIONS ',
              imagePath: Assets.icons.terms,
            ),
            UIHelper.verticalSpace(16.h),
            ProfileButton(
              onTap: () => NavigationService.navigateTo(Routes.privacyPolecy),
              title: 'ABOUT US',
              imagePath: Assets.icons.about,
            ),
            UIHelper.verticalSpace(16.h),
          ],
        ),
      ),
    );
  }
}

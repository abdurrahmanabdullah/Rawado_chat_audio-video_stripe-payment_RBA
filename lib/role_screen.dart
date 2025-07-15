import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/constants/app_constants.dart';
import 'package:rawado/helpers/di.dart';
import '../../constants/text_font_style.dart';
import '../../gen/assets.gen.dart';
import '../../helpers/ui_helpers.dart';
import 'common_wigdets/auth_button.dart';
import 'features_user/onboarding/presentations/widget/onboarding_data.dart';
import 'helpers/all_routes.dart';
import 'helpers/helper_methods.dart';
import 'helpers/navigation_service.dart';
import 'helpers/toast.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({super.key});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  bool _isUser = false;
  bool _isTrainer = false;

  String? selectedProfileType;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.sp),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 8,
                child: Stack(
                  children: [
                    // Logo image Section
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.00, -1.00),
                          end: Alignment(0, 1),
                          colors: [Color(0x000B0A0A), Color(0xFF0B0A0A)],
                        ),
                      ),
                      child: Image.asset(
                        Assets.images.onboardingImage.path,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // Title Section
                    Positioned(
                        top: 400.h,
                        left: 16.sp,
                        right: 16.sp,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'SELECT YOUR ROLE',
                              style: TextFontStyle.headline24StyleCabin700,
                              textAlign: TextAlign.center,
                            ),
                            UIHelper.verticalSpace(8.h),
                            LanguageButton(
                              onTap: () {
                                setState(() {
                                  _isUser = true;
                                  _isTrainer = false;
                                  selectedProfileType = kKeyISUser;
                                  appData.write(kKeyRoleType, kKeyISUser);
                                });
                              },
                              title: 'USER',
                              isSelected: _isUser,
                            ),
                            UIHelper.verticalSpace(12.h),
                            LanguageButton(
                              onTap: () {
                                setState(() {
                                  _isTrainer = true;
                                  _isUser = false;
                                  selectedProfileType = kKeyISTrainer;
                                  appData.write(kKeyRoleType, kKeyISTrainer);
                                });
                              },
                              title: 'TRAINER',
                              isSelected: _isTrainer,
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              UIHelper.verticalSpace(35.h),
              UIHelper.verticalSpace(30.h),
              AppCustomeButton(
                  name: 'NEXT',
                  onCallBack: () {
                    if (selectedProfileType == null) {
                      ToastUtil.showLongToast('PLEASE SELECT YOUR ROLE!');
                    } else {
                      NavigationService.navigateToWithArgs(Routes.logInScreen, {
                        'userType': selectedProfileType,
                      });
                      log("Selected Type: $selectedProfileType");
                    }
                  },
                  height: 50.h,
                  minWidth: double.infinity,
                  borderRadius: 40.r,
                  color: appColor(),
                  textStyle: TextFontStyle.headline18StyleCabin700
                      .copyWith(color: appTextColor()),
                  context: context),
            ],
          ),
        ),
      ),
    );
  }
}

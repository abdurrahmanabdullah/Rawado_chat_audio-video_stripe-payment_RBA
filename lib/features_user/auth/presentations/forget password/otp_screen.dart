import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rawado/constants/app_constants.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/features_user/auth/presentations/forget%20password/confirm_password.dart';
import 'package:rawado/gen/colors.gen.dart';
import 'package:rawado/helpers/loading_helper.dart';
import 'package:rawado/helpers/ui_helpers.dart';

import '../../../../common_wigdets/auth_button.dart';
import '../../../../common_wigdets/custom_appbar.dart';
import '../../../../helpers/di.dart';
import '../../../../helpers/helper_methods.dart';
import '../../../../helpers/toast.dart';
import '../../../../networks/api_acess.dart';
import '../../../../networks/exception_handler/error_response.dart';

class OtpScreen extends StatefulWidget {
  final Map? map;
  const OtpScreen({super.key, this.map});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController _otpTEController = TextEditingController();
  bool isPassVisible = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      // emailController.text = 'raselbabu34.bd@gmail.com';
      // passwordController.text = '12345678';
    }
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Form(
            key: _fromKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Verification',
                      textAlign: TextAlign.center,
                      style: TextFontStyle.headline28StyleCabin700),
                  Row(
                    children: [
                      Text(
                        'Enter your OTP',
                        style: TextFontStyle.headline16StyleCabin
                            .copyWith(color: AppColors.cA7A7A7),
                      ),
                      UIHelper.horizontalSpaceSmall,
                    ],
                  ),
                  UIHelper.verticalSpace(120.h),

                  PinCodeTextField(
                    length: 4,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(12.r),
                      fieldHeight: 64.h,
                      fieldWidth: 56.w,
                      inactiveFillColor: AppColors.c111111.withOpacity(0.1),
                      inactiveColor: AppColors.allPrimaryColor,
                      // selectedColor: AppColors.c171717,
                      selectedBorderWidth: 2,
                      activeFillColor: AppColors.allPrimaryColor,
                      activeColor: const Color.fromARGB(255, 0, 255, 21),
                      selectedFillColor: Colors.white,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    controller: _otpTEController,
                    onCompleted: (v) {},
                    onChanged: (value) {},
                    appContext: context,
                  ),

                  UIHelper.verticalSpaceMedium,

                  //Log in button
                  AppCustomeButton(
                    borderRadius: 40.sp,
                    color: appColor(),
                    context: context,
                    height: 54.h,
                    minWidth: double.infinity,
                    name: 'Send',
                    onCallBack: () async {
                      try {
                        bool success = await verifyOtpFPRX
                            .verifyOtp(
                                code: _otpTEController.text,
                                email: appData.read(kEmail))
                            .waitingForFutureWithoutBg();
                        if (success) {
                          //  NavigationService.navigateTo(Routes.setNewPasswordScreen);

                          Get.to(() => const ConfirmPasswordScreen());
                        }
                      } catch (error) {
                        log(error.toString());
                        ToastUtil.showShortToast(ResponseMessage.DEFAULT);
                      }
                      // !appData.read(kKeyUser)
                      //     ? NavigationService.navigateTo(
                      //         Routes.loactionAccessRoutes)
                      //     : NavigationService.navigateTo(
                      //         Routes.completeInformationRoutes);

                      // NavigationService.navigateTo(Routes.homepageRoutes);
                    },
                    textStyle: TextFontStyle.authButton16StyleCabin,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

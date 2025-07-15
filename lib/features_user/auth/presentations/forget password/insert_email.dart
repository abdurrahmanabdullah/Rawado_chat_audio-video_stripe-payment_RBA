// ignore_for_file: unused_element

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rawado/common_wigdets/custom_textfiled.dart';
import 'package:rawado/constants/app_constants.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/features_user/auth/presentations/forget%20password/otp_screen.dart';
import 'package:rawado/gen/colors.gen.dart';
import 'package:rawado/helpers/loading_helper.dart';
import 'package:rawado/helpers/ui_helpers.dart';

import '../../../../common_wigdets/auth_button.dart';
import '../../../../common_wigdets/custom_appbar.dart';
import '../../../../helpers/di.dart';
import '../../../../helpers/helper_methods.dart';
import '../../../../helpers/toast.dart';
import '../../../../networks/api_acess.dart';

class InserEmailScreen extends StatefulWidget {
  final Map? map;
  const InserEmailScreen({super.key, this.map});

  @override
  State<InserEmailScreen> createState() => _InserEmailScreenState();
}

class _InserEmailScreenState extends State<InserEmailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  bool isPassVisible = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      // emailController.text = 'raselbabu34.bd@gmail.com';
      // passwordController.text = '12345678';
    }

    String? emailValidator(String? value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your email';
      }
      final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
      if (!emailRegex.hasMatch(value)) {
        return 'Please enter a valid email address';
      }
      return null;
    }

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('FORGOT YOUR PASSWORD?',
                    // textAlign: TextAlign.center,
                    style: TextFontStyle.headline28StyleCabin700),
                Row(
                  children: [
                    Text(
                      'Enter your email to get help logging in.',
                      style: TextFontStyle.headline16StyleCabin
                          .copyWith(color: AppColors.cA7A7A7),
                    ),
                    UIHelper.horizontalSpaceSmall,
                  ],
                ),
                UIHelper.verticalSpace(120.h),
                // Email Text Field
                _buildEmailTextField(),
                UIHelper.verticalSpaceMedium,
                //Log in button
                AppCustomeButton(
                  borderRadius: 40.sp,
                  color: appColor(),
                  context: context,
                  height: 54.h,
                  minWidth: double.infinity,
                  name: 'CONTINUE',
                  onCallBack: () async {
                    try {
                      if (_formKey.currentState!.validate()) {
                        await postForgetEmailRXObj
                            .postForgetEmail(email: emailController.text)
                            .waitingForFutureWithoutBg()
                            .then(
                          (value) {
                            if (value) {
                              Get.to(() => const OtpScreen());
                              appData.write(
                                  kEmail, emailController.text.trim());
                              // emailProvider
                              //     .changeEmail(emailController.text);
                            }
                          },
                        );
                      }
                    } catch (error) {
                      log(error.toString());
                      ToastUtil.showShortToast(error.toString());
                    }

                    // NavigationService.navigateTo(Routes.otpRoutes);
                    // NavigationService.navigateTo(Routes.phoneNumberRoutes);
                    // Get.to(() => PhoneNumber());
                  },
                  textStyle: TextFontStyle.authButton16StyleCabin,
                ),

                UIHelper.verticalSpace(48.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CustomTextFormField _buildEmailTextField() {
    return CustomTextFormField(
      controller: emailController,
      isPrefixIcon: false,
      hintText: 'EMAIL',
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter Your Email';
        }
        return null;
      },
    );
  }
}

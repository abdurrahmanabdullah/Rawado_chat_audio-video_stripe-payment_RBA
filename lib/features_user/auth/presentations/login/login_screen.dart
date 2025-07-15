import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rawado/common_wigdets/custom_textfiled.dart';
import 'package:rawado/common_wigdets/or_divider.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/features_user/auth/presentations/forget%20password/insert_email.dart';
import 'package:rawado/gen/assets.gen.dart';
import 'package:rawado/gen/colors.gen.dart';
import 'package:rawado/helpers/navigation_service.dart';
import 'package:rawado/helpers/social_login_helper.dart';
import 'package:rawado/helpers/ui_helpers.dart';
import 'package:svg_flutter/svg.dart';
import '../../../../common_wigdets/auth_button.dart';
import '../../../../common_wigdets/custom_appbar.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/helper_methods.dart';
import '../../../../helpers/toast.dart';
import '../../../../helpers/url_lunch.dart';
import '../../../../networks/api_acess.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                Text('LOG IN',
                    textAlign: TextAlign.center,
                    style: TextFontStyle.headline28StyleCabin700),
                Row(
                  children: [
                    Text(
                      'LOG IN TO GET ACTIVE',
                      style: TextFontStyle.headline16StyleCabin
                          .copyWith(color: AppColors.cA7A7A7),
                    ),
                    UIHelper.horizontalSpaceSmall,
                    SvgPicture.asset(Assets.icons.arm)
                  ],
                ),
                UIHelper.verticalSpaceSmall,
                UIHelper.verticalSpaceMedium,

                // Email Text Field
                _buildEmailTextField(),

                UIHelper.verticalSpace(16.h),

                // Password Text Field
                _buildPasswordtextField(),

                UIHelper.verticalSpace(16.h),
                // Forgot Password
                buildForgotPass(),
                UIHelper.verticalSpace(32.h),

                //Log in button
                AppCustomeButton(
                  borderRadius: 40.sp,
                  color: appColor(),
                  context: context,
                  height: 54.h,
                  minWidth: double.infinity,
                  name: 'LOG IN',
                  onCallBack: () async {
                    if (_fromKey.currentState?.validate() ?? false) {
                      // log(widget.map!['userType']);

                      // heldle login function
                      // if (widget.map!['userType'] == kKeyISUser) {
                      try {
                        await getLoginRXObj.login(
                            emailController.text, passwordController.text);

                        // if (isRoute) {
                        //   log('route');
                        //   NavigationService.navigateToUntilReplacement(
                        //       Routes.navigationScreen);
                        // }
                      } catch (e) {
                        log(e.toString());
                        ToastUtil.showShortToast(
                            "Login failed. Please try again.");
                      }
                      // } else if (widget.map!['userType'] == kKeyISTrainer) {
                      //   NavigationService.navigateTo(
                      //       Routes.trainerNavigationScreen);
                      // }
                    }
                  },
                  textStyle: TextFontStyle.authButton16StyleCabin,
                ),

                UIHelper.verticalSpace(48.h),

                const OrDivider(),
                UIHelper.verticalSpace(24.h),
                GestureDetector(
                  onTap: () {
                    SocialLoginHelper.instance
                        .signInWithGoogle(context)
                        .then((user) {
                      log("Google Sign In User Data: $user");
                    });
                  },
                  child: Center(
                      child: SvgPicture.asset(
                    Assets.icons.googleIcon,
                    height: 32.h,
                  )),
                ),
                UIHelper.verticalSpace(32.h),
                _buildTermsCondition(),
                UIHelper.verticalSpace(20.h),
                _buildRegisterButton()
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

  CustomTextFormField _buildPasswordtextField() {
    return CustomTextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter Your Password';
        } else if (value.length <= 6) {
          return 'Please Enter 6 Digite Password';
        }
        return null;
      },
      controller: passwordController,
      textInputAction: TextInputAction.done,
      hintText: 'PASSWORD',
      isPrefixIcon: true,
      obscureText: isPassVisible,
      suffixIcon: isPassVisible ? Icons.visibility : Icons.visibility_off,
      onSuffixIconTap: () {
        isPassVisible = !isPassVisible;
        setState(() {});
      },
    );
  }

  Align buildForgotPass() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          Get.to(() => const InserEmailScreen());
          // NavigationService.navigateTo(Routes.forgotPass);
        },
        child: Text(
          'FORGET PASSWORD? CLICK HERE',
          style: TextFontStyle.headline16StyleCabin.copyWith(
            color: AppColors.c5A5C5F,
          ),
        ),
      ),
    );
  }

  Align _buildTermsCondition() {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'BY LOGIN YOU AGREE TO YOUR ',
          style: TextFontStyle.headline12StyleCabin500,
          children: <TextSpan>[
            TextSpan(
              text: 'TERMS & CONDITION ',
              style: TextFontStyle.headline12StyleCabin500.copyWith(
                color: appColor(),
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  await openUrl(
                      'https://wegowolf.com/page/show/terms-and-conditions');
                  // NavigationService.navigateTo(Routes.signUpScreen);
                },
            ),
            TextSpan(
              text: 'AND PRIVACY POLICY',
              style: TextFontStyle.headline12StyleCabin500,
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  await openUrl(
                      'https://wegowolf.com/page/show/privacy-policy');
                  // NavigationService.navigateTo(Routes.signUpScreen);
                },
            ),
          ],
        ),
      ),
    );
  }

  Align _buildRegisterButton() {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'YOU DONT HAVE AN ACCOUNT YET? ',
          style: TextFontStyle.headline12StyleCabin500,
          children: <TextSpan>[
            TextSpan(
              text: 'SIGN-UP',
              style: TextFontStyle.headline12StyleCabin500.copyWith(
                color: appColor(),
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  NavigationService.navigateTo(Routes.signUpScreen);
                },
            ),
          ],
        ),
      ),
    );
  }
}

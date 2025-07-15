import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/common_wigdets/custom_textfiled.dart';
import 'package:rawado/common_wigdets/or_divider.dart';
import 'package:rawado/constants/app_constants.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/gen/assets.gen.dart';
import 'package:rawado/gen/colors.gen.dart';
import 'package:rawado/helpers/navigation_service.dart';
import 'package:rawado/helpers/toast.dart';
import 'package:rawado/helpers/ui_helpers.dart';
import 'package:rawado/networks/api_acess.dart';
import 'package:svg_flutter/svg.dart';
import '../../../../common_wigdets/auth_button.dart';
import '../../../../common_wigdets/custom_appbar.dart';
import '../../../../common_wigdets/custom_dropdown.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/helper_methods.dart';
import '../../../../helpers/url_lunch.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController pController = TextEditingController();
  bool isPassVisible = true;
  bool isCPassVisible = true;

  String? selectedGander;

  List<String> gander = ['MALE', 'FEMALE'];

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    lNameController.dispose();
    cPasswordController.dispose();
    pController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                Text('SIGN UP',
                    textAlign: TextAlign.center,
                    style: TextFontStyle.headline28StyleCabin700),
                Row(
                  children: [
                    Text(
                      'SIGN UP TO GET ACTIVE',
                      style: TextFontStyle.headline16StyleCabin
                          .copyWith(color: AppColors.cA7A7A7),
                    ),
                    UIHelper.horizontalSpaceSmall,
                    SvgPicture.asset(Assets.icons.arm)
                  ],
                ),
                UIHelper.verticalSpaceSmall,
                UIHelper.verticalSpaceMedium,
                CustomTextFormField(
                  controller: emailController,
                  isPrefixIcon: false,
                  hintText: 'EMAIL',
                ),
                UIHelper.verticalSpace(20.h),

                CustomTextFormField(
                  controller: lNameController,
                  isPrefixIcon: false,
                  hintText: 'USER NAME',
                ),
                UIHelper.verticalSpace(20.h),

                CustomTextFormField(
                  controller: pController,
                  isPrefixIcon: false,
                  hintText: 'PHONE',
                ),

                UIHelper.verticalSpace(18.h),
                CustomDropdown<String>(
                    borderRadius: BorderRadius.circular(40.r),
                    hint: 'GENDER',
                    items: gander,
                    selectedItem: selectedGander,
                    itemToString: (gander) => gander,
                    onChanged: (value) {
                      setState(() {
                        selectedGander = value!;
                      });
                    }),

                UIHelper.verticalSpace(18.h),

                // Password Text Field
                CustomTextFormField(
                  controller: passwordController,
                  hintText: 'PASSWORD',
                  isPrefixIcon: true,
                  obscureText: isPassVisible,
                  suffixIcon:
                      isPassVisible ? Icons.visibility : Icons.visibility_off,
                  onSuffixIconTap: () {
                    isPassVisible = !isPassVisible;
                    setState(() {});
                  },
                ),

                UIHelper.verticalSpace(20.h),

                CustomTextFormField(
                  controller: cPasswordController,
                  textInputAction: TextInputAction.done,
                  hintText: 'CONFIRM PASSWORD',
                  isPrefixIcon: true,
                  obscureText: isCPassVisible,
                  suffixIcon:
                      isCPassVisible ? Icons.visibility : Icons.visibility_off,
                  onSuffixIconTap: () {
                    isCPassVisible = !isCPassVisible;
                    setState(() {});
                  },
                ),

                UIHelper.verticalSpace(32.h),
                //Log in button
                AppCustomeButton(
                  borderRadius: 40.sp,
                  color: appColor(),
                  context: context,
                  height: 54.h,
                  minWidth: double.infinity,
                  name: 'SIGN UP',
                  onCallBack: () async {
                    // log(appData.read(kKeyRoleType));
                    // final userRole = await appData.read(kKeyRoleType);
                    try {
                      if (_fromKey.currentState?.validate() ?? false) {
                        try {
                          await postSignUpRX.signup(
                              firstName: lNameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              password_confirmation:
                                  cPasswordController.text.trim(),
                              phone: pController.text.trim(),
                              gender: selectedGander!,
                              role: kKeyISUser);
                        } catch (e) {
                          log(e.toString());
                        }
                      } else {
                        ToastUtil.showLongToast('Please Fill All The Field');
                      }
                    } catch (e) {
                      log(e.toString());
                    }
                    // heldle login function\
                    // NavigationService.navigateToUntilReplacement(
                    //     Routes.navigationScreen);
                  },
                  textStyle: TextFontStyle.authButton16StyleCabin,
                ),

                UIHelper.verticalSpace(48.h),

                const OrDivider(),
                UIHelper.verticalSpace(24.h),
                Center(
                    child: SvgPicture.asset(
                  Assets.icons.googleIcon,
                  height: 32.h,
                )),
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

  Align buildForgotPass() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
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
                ..onTap = () async{
                await  openUrl(
                      'https://wegowolf.com/page/show/terms-and-conditions');
                  // NavigationService.navigateTo(Routes.signUpScreen);
                },
            ),
            TextSpan(
              text: 'AND PRIVACY POLICY',
              style: TextFontStyle.headline12StyleCabin500,
              recognizer: TapGestureRecognizer()
                ..onTap = () async{
                await  openUrl(
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
          text: 'ALREADY HAVE AN ACCOUNT YET? ',
          style: TextFontStyle.headline12StyleCabin500,
          children: <TextSpan>[
            TextSpan(
              text: 'LOG-IN',
              style: TextFontStyle.headline12StyleCabin500.copyWith(
                color: appColor(),
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  NavigationService.navigateTo(Routes.logInScreen);
                },
            ),
          ],
        ),
      ),
    );
  }
}

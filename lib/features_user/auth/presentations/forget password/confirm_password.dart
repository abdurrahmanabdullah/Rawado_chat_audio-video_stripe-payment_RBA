import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rawado/common_wigdets/custom_textfiled.dart';
import 'package:rawado/constants/app_constants.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/gen/colors.gen.dart';
import 'package:rawado/helpers/loading_helper.dart';
import 'package:rawado/helpers/ui_helpers.dart';

import '../../../../common_wigdets/auth_button.dart';
import '../../../../common_wigdets/custom_appbar.dart';
import '../../../../helpers/di.dart';
import '../../../../helpers/helper_methods.dart';
import '../../../../helpers/toast.dart';
import '../../../../loading_screen.dart';
import '../../../../networks/api_acess.dart';
import '../../../../networks/exception_handler/error_response.dart';

class ConfirmPasswordScreen extends StatefulWidget {
  final Map? map;
  const ConfirmPasswordScreen({super.key, this.map});

  @override
  State<ConfirmPasswordScreen> createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

  final TextEditingController passwordTEController = TextEditingController();
  final TextEditingController cpasswordTEController = TextEditingController();
  bool passVisible = true;
  bool cPassVisible = true;

  @override
  void dispose() {
    passwordTEController.dispose();
    cpasswordTEController.dispose();
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
                Text('CONFIRM PASSWORD',
                    textAlign: TextAlign.center,
                    style: TextFontStyle.headline28StyleCabin700),
                UIHelper.verticalSpaceSmall,
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'PLEASE ENTER YOUR PASSWORD AND CONFIRM PASSWORD',
                        style: TextFontStyle.headline16StyleCabin
                            .copyWith(color: AppColors.cA7A7A7),
                      ),
                    ),
                    UIHelper.horizontalSpaceSmall,
                  ],
                ),

                UIHelper.verticalSpace(120.h),
                // Email Text Field
                // Password Text Field
                CustomTextFormField(
                  controller: passwordTEController,
                  hintText: 'PASSWORD',
                  isPrefixIcon: true,
                  obscureText: passVisible,
                  suffixIcon:
                      passVisible ? Icons.visibility : Icons.visibility_off,
                  onSuffixIconTap: () {
                    passVisible = !passVisible;
                    setState(() {});
                  },
                ),

                UIHelper.verticalSpace(20.h),

                CustomTextFormField(
                  controller: cpasswordTEController,
                  textInputAction: TextInputAction.done,
                  hintText: 'CONFIRM PASSWORD',
                  isPrefixIcon: true,
                  obscureText: cPassVisible,
                  suffixIcon:
                      cPassVisible ? Icons.visibility : Icons.visibility_off,
                  onSuffixIconTap: () {
                    cPassVisible = !cPassVisible;
                    setState(() {});
                  },
                ),
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
                    if (passwordTEController.text.length < 8) {
                      Fluttertoast.showToast(
                          msg: 'Password Needs at least 8 Characters');
                    } else if (passwordTEController.text ==
                        passwordTEController.text) {
                      try {
                        String token = appData.read('tokenFP');
                        await postForgertPwRX
                            .postProductBasicData(
                                // emailProvider.email.trim(),
                                appData.read(kEmail),
                                passwordTEController.text.trim(),
                                passwordTEController.text,
                                token)
                            .waitingForFutureWithoutBg()
                            .then(
                          (value) {
                            if ((value)) {
                              // emailProvider.changePass(
                              //    );
                              // appData.write(
                              //     kPassword, _newTEController.text.trim(),
                              //     );

                              getLoginRXObj
                                  .login(appData.read(kEmail),
                                      passwordTEController.text.trim())
                                  .customeThen()
                                  .then(
                                (value) {
                                  ToastUtil.showShortToast(
                                      'New Password set Successfully');
                                  Get.offAll(() => const Loading());
                                },
                              );
                            }
                          },
                        );
                      } catch (error) {
                        log(error.toString());
                        ToastUtil.showShortToast(ResponseMessage.DEFAULT);
                      }
                    } else {
                      Fluttertoast.showToast(msg: 'Password mismatched');
                    }
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

  // CustomTextFormField _buildEmailTextField() {
  //   return CustomTextFormField(
  //     controller: emailController,
  //     isPrefixIcon: false,
  //     hintText: 'EMAIL',
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         return 'Please Enter Your Email';
  //       }
  //       return null;
  //     },
  //   );
  // }
}

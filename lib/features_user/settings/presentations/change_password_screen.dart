import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/common_wigdets/custom_appbar.dart';
import 'package:rawado/helpers/all_routes.dart';
import 'package:rawado/helpers/loading_helper.dart';
import 'package:rawado/helpers/navigation_service.dart';
import 'package:rawado/helpers/ui_helpers.dart';
import 'package:rawado/networks/api_acess.dart';

import '../../../common_wigdets/custom_textfiled.dart';
import '../../../constants/text_font_style.dart';
import '../../../gen/colors.gen.dart';
import '../../booking/presentation/booking_summary_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  final TextEditingController currentPWController = TextEditingController();
  final TextEditingController newPWController = TextEditingController();
  final TextEditingController confirmPWController = TextEditingController();
  bool isCurrentPWVisible = true;
  bool isNewPWVisible = true;
  bool isConfirmPWVisible = true;

  @override
  void dispose() {
    currentPWController.dispose();
    newPWController.dispose();
    confirmPWController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'CHANGE PASSWORD',
        centerTitle: false,
      ),
      body: Form(
        key: _fromKey,
        child: ListView(
          padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
          children: [
            // Current PAssword Text Filed
            Text(
              'CURRENT PASSWORD',
              style: TextFontStyle.headline14StyleCabin500
                  .copyWith(color: AppColors.cA7A7A7),
            ),
            UIHelper.verticalSpace(8.h),
            CustomTextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter Current Password'.toUpperCase();
                } else if (value.length <= 6) {
                  return 'Please Enter 6 Digite Password'.toUpperCase();
                }
                return null;
              },
              controller: currentPWController,
              textInputAction: TextInputAction.done,
              hintText: 'CURRENT PASSWORD',
              isPrefixIcon: true,
              obscureText: isCurrentPWVisible,
              suffixIcon:
                  isCurrentPWVisible ? Icons.visibility : Icons.visibility_off,
              onSuffixIconTap: () {
                isCurrentPWVisible = !isCurrentPWVisible;
                setState(() {});
              },
            ),
            UIHelper.verticalSpace(20.h),

            // New PAssword Text Filed
            Text(
              'NEW PASSWORD',
              style: TextFontStyle.headline14StyleCabin500
                  .copyWith(color: AppColors.cA7A7A7),
            ),
            UIHelper.verticalSpace(8.h),
            CustomTextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter New Password'.toUpperCase();
                } else if (value.length <= 6) {
                  return 'Please Enter 6 Digite Password'.toUpperCase();
                }
                return null;
              },
              controller: newPWController,
              textInputAction: TextInputAction.done,
              hintText: 'NEW PASSWORD',
              isPrefixIcon: true,
              obscureText: isNewPWVisible,
              suffixIcon:
                  isNewPWVisible ? Icons.visibility : Icons.visibility_off,
              onSuffixIconTap: () {
                isNewPWVisible = !isNewPWVisible;
                setState(() {});
              },
            ),
            UIHelper.verticalSpace(20.h),

            // Confirm PAssword Text Filed
            Text(
              'CONFIRM PASSWORD',
              style: TextFontStyle.headline14StyleCabin500
                  .copyWith(color: AppColors.cA7A7A7),
            ),
            UIHelper.verticalSpace(8.h),
            CustomTextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter Confirm Password'.toUpperCase();
                } else if (value.length <= 6) {
                  return 'Please Enter 6 Digite Password'.toUpperCase();
                } else if (newPWController.text != confirmPWController.text) {
                  return 'Password Dosn\'t Match'.toUpperCase();
                }
                return null;
              },
              controller: confirmPWController,
              textInputAction: TextInputAction.done,
              hintText: 'CONFIRM PASSWORD',
              isPrefixIcon: true,
              obscureText: isConfirmPWVisible,
              suffixIcon:
                  isConfirmPWVisible ? Icons.visibility : Icons.visibility_off,
              onSuffixIconTap: () {
                isConfirmPWVisible = !isConfirmPWVisible;
                setState(() {});
              },
            ),
            UIHelper.verticalSpace(20.h),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingButton(
        title: 'UPDATE PASSWORD',
        onTap: () async {
          if (_fromKey.currentState?.validate() ?? false) {
            Map body = {
              "old_password": currentPWController.text.trim(),
              "password": newPWController.text.trim(),
              "password_confirmation": confirmPWController.text.trim()
            };
            await postChangePasswordRXobj.changePW(body).waitingForFuture();
            NavigationService.navigateToReplacement(Routes.settings);
          }
        },
      ),
    );
  }
}

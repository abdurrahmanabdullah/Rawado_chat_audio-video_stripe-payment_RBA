// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/common_wigdets/auth_button.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/helpers/loading_helper.dart';
import 'package:rawado/helpers/navigation_service.dart';
import 'package:rawado/networks/api_acess.dart';
import 'package:svg_flutter/svg.dart';
import '../../../common_wigdets/custom_appbar.dart';
import '../../../common_wigdets/custom_textfiled.dart';
import '../../../common_wigdets/image_picker.dart';
import '../../../common_wigdets/loading_indicators.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/helper_methods.dart';
import '../../../helpers/ui_helpers.dart';
import '../model/profile_details_model.dart';

class EditProfileScreen extends StatefulWidget {
  final ProfileData? profile;
  const EditProfileScreen({super.key, this.profile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _imageFileNotifier = ValueNotifier<File?>(null);
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  bool isPassVisible = true;
  bool isCPassVisible = true;

  @override
  void initState() {
    setInitialData();
    super.initState();
  }

  void setInitialData() {
    lNameController.text = widget.profile?.name ?? '';
    emailController.text = widget.profile?.email ?? '';
    phoneController.text = widget.profile?.phone ?? '';
    addressController.text = widget.profile?.address ?? '';
  }

  @override
  void dispose() {
    emailController.dispose();
    lNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        centerTitle: false,
        title: 'EDIT PROFILE',
      ),
      body: ListView(
        padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
        children: [
          Center(
            child: Container(
              height: 100.h,
              width: 100.w,
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: appColor()),
              child: Stack(
                children: [
                  ValueListenableBuilder<File?>(
                    valueListenable: _imageFileNotifier,
                    builder: (context, imagePath, _) {
                      if (imagePath != null) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(75.r),
                          child: Image.file(
                            imagePath,
                            height: 100.h,
                            width: 100.w,
                            fit: BoxFit.cover,
                          ),
                        );
                      } else {
                        if (widget.profile?.avatar != null) {
                          return CircleAvatar(
                              backgroundColor: AppColors.white,
                              radius: 50.r,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.r),
                                child: CachedNetworkImage(
                                  height: 100.h,
                                  width: 100.h,
                                  imageUrl: widget.profile?.avatar,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      loadingIndicatorCircle(context: context),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error,
                                    color: Colors.redAccent,
                                    size: 50.sp,
                                  ),
                                ),
                              ));
                        } else {
                          return Image.asset(Assets.images.profilePicture.path);
                        }
                      }
                    },
                  ),
                  Positioned(
                    right: 4.w,
                    bottom: 2.h,
                    child: GestureDetector(
                      onTap: () {
                        _showImageSourceDialog(context);
                      },
                      child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: AppColors.cA7A7A7,
                        child: SvgPicture.asset(
                          Assets.icons.editIcon,
                          width: 18.w,
                          color: appColor(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          UIHelper.verticalSpace(33.h),
          UIHelper.verticalSpaceMedium,
          Form(
            key: _fromKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NAME',
                  style: TextFontStyle.headline14StyleCabin500
                      .copyWith(color: AppColors.cA7A7A7),
                ),
                UIHelper.verticalSpace(8.h),
                CustomTextFormField(
                  controller: lNameController,
                  isPrefixIcon: false,
                  hintText: 'NAME',
                ),
                UIHelper.verticalSpace(20.h),
                Text(
                  'EMAIL',
                  style: TextFontStyle.headline14StyleCabin500
                      .copyWith(color: AppColors.cA7A7A7),
                ),
                UIHelper.verticalSpace(8.h),
                CustomTextFormField(
                  isReadOnly: true,
                  controller: emailController,
                  isPrefixIcon: false,
                  hintText: 'EMAIL',
                ),
                UIHelper.verticalSpace(20.h),
                Text(
                  'PHONE',
                  style: TextFontStyle.headline14StyleCabin500
                      .copyWith(color: AppColors.cA7A7A7),
                ),
                UIHelper.verticalSpace(8.h),
                CustomTextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: phoneController,
                  isPrefixIcon: false,
                  hintText: 'PHONE',
                ),
                UIHelper.verticalSpace(20.h),
                // Text(
                //   'ADDRESS',
                //   style: TextFontStyle.headline14StyleCabin500
                //       .copyWith(color: AppColors.cA7A7A7),
                // ),
                // UIHelper.verticalSpace(8.h),
                // CustomTextFormField(
                //   keyboardType: TextInputType.number,
                //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                //   controller: addressController,
                //   isPrefixIcon: false,
                //   hintText: 'Address',
                // ),
                UIHelper.verticalSpace(20.h),
                UIHelper.verticalSpaceMedium,
                AppCustomeButton(
                    name: 'UPDATE',
                    onCallBack: () async {
                      // String fileName =
                      //     _imageFileNotifier.value!.path.split('/').last;
                      Map<String, dynamic> body = {
                        'name': lNameController.text.trim(),
                        'phone': phoneController.text.trim(),
                        'avatar': (_imageFileNotifier.value != null &&
                                _imageFileNotifier.value!.path.isNotEmpty)
                            ? await MultipartFile.fromFile(
                                _imageFileNotifier.value!.path,
                                filename:
                                    '${DateTime.now().millisecond}_${_imageFileNotifier.value!.path.split('/').last}')
                            : widget.profile?.avatar,
                      };
                      await postUpdateProfileRXObj
                          .updateProfile(body: body)
                          .waitingForFuture();
                      await getProfileDetailsRXObj.getprofileDetails();
                      NavigationService.goBack;
                    },
                    height: 54.h,
                    minWidth: double.infinity,
                    borderRadius: 40.r,
                    color: appColor(),
                    textStyle: TextFontStyle.headline16StyleCabin
                        .copyWith(color: appTextColor()),
                    context: context)
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => ImageSourceDialog(
        onImageSelected: (String imagePath) {
          _imageFileNotifier.value = File(imagePath);
        },
      ),
    );
  }
}

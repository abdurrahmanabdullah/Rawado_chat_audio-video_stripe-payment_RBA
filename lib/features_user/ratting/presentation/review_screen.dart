import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/common_wigdets/custom_appbar.dart';
import 'package:rawado/common_wigdets/custom_textfiled.dart';
import 'package:rawado/constants/app_constants.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/gen/colors.gen.dart';
import 'package:rawado/helpers/di.dart';
import 'package:rawado/helpers/loading_helper.dart';
import 'package:rawado/helpers/toast.dart';
import 'package:rawado/helpers/ui_helpers.dart';
import 'package:rawado/networks/api_acess.dart';

import '../../../common_wigdets/auth_button.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/helper_methods.dart';
import '../../../helpers/navigation_service.dart';

class ReviewScreen extends StatefulWidget {
  final int? serviceId;
  const ReviewScreen({super.key, this.serviceId});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  TextEditingController controller = TextEditingController();
  double rating = 0.0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'RATE THIS SERVICE',
        centerTitle: false,
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
        children: [
          Text(
              textAlign: TextAlign.center,
              'GIVE  A REVIEW TO THIS SERVICE',
              style: TextFontStyle.headline14StyleCabin500
                  .copyWith(color: AppColors.cD7D7D7)),
          UIHelper.verticalSpace(24.h),
          PannableRatingBar(
            rate: rating,
            items: List.generate(
                5,
                (index) => RatingWidget(
                      selectedColor: appColor(),
                      unSelectedColor: AppColors.cA7A7A7,
                      child: const Icon(
                        Icons.star,
                        size: 40,
                      ),
                    )),
            onChanged: (value) {
              // the rating value is updated on tap or drag.
              setState(() {
                rating = value;
              });
            },
          ),
          UIHelper.verticalSpace(48.h),
          Text(
              textAlign: TextAlign.center,
              'WRITE SOMETHING ABOUT THIS SERVICE',
              style: TextFontStyle.headline14StyleCabin500
                  .copyWith(color: AppColors.cD7D7D7)),
          UIHelper.verticalSpace(24.h),
          CustomTextFormField(
            controller: controller,
            borderRadius: 12.r,
            isPrefixIcon: false,
            hintText: 'WRITE THERE..',
            maxLine: 6,
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 36.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Flexible(
            //   flex: 1,
            //   child: AppCustomeButton(
            //       name: 'CANCLE',
            //       onCallBack: () {},
            //       height: 56.h,
            //       minWidth: double.infinity,
            //       borderRadius: 40.r,
            //       color: Colors.transparent,
            //       borderSideColor: appColor(),
            //       textStyle: TextFontStyle.headline14StyleCabin700
            //           .copyWith(color: appTextColor()),
            //       context: context),
            // ),
            // UIHelper.horizontalSpaceSmall,
            Flexible(
              flex: 1,
              child: AppCustomeButton(
                  name: 'CONFIRM',
                  onCallBack: () async {
                    try {
                      var userId = await appData.read(kKeyUserID);
                      Map body = {
                        "user_id": userId,
                        "service_id": widget.serviceId,
                        "message": controller.text,
                        "rating": rating
                      };
                      await postCustomerGiveReviewRXObjj
                          .giveReview(body)
                          .waitingForFuture();
                      rating = 0.0;
                      controller.clear();
                      NavigationService.navigateToReplacement(
                          Routes.appointmentHistory);
                    } catch (e) {
                      ToastUtil.showLongToast(e.toString());
                    }
                  },
                  height: 56.h,
                  minWidth: double.infinity,
                  borderRadius: 40.r,
                  color: appColor(),
                  textStyle: TextFontStyle.headline14StyleCabin700
                      .copyWith(color: appTextColor()),
                  context: context),
            ),
          ],
        ),
      ),
    );
  }
}

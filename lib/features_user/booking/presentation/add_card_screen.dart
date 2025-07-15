import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/common_wigdets/custom_appbar.dart';
import 'package:rawado/common_wigdets/custom_textfiled.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/features_user/booking/presentation/booking_summary_screen.dart';
import 'package:rawado/features_user/booking/presentation/widgets/payment_successful_widget.dart';
import 'package:rawado/gen/assets.gen.dart';
import 'package:rawado/gen/colors.gen.dart';
import 'package:rawado/helpers/helper_methods.dart';
import 'package:rawado/helpers/ui_helpers.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'ADD CARD',
        centerTitle: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
        children: [
          Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
              height: 177.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  Assets.images.cardImage.path,
                  fit: BoxFit.cover,
                ),
              )),
          UIHelper.verticalSpace(24.h),

          // Booking D
          Text('BOOKING DATE:',
              style: TextFontStyle.headline16StyleCabin
                  .copyWith(color: AppColors.cA7A7A7)),
          UIHelper.verticalSpace(8.h),
          CustomTextFormField(
            borderRadius: 12.r,
            isPrefixIcon: true,
            iconpath: Assets.icons.profile,
            hintText: 'NAME',
          ),
          UIHelper.verticalSpace(24.h),

          // Card Number
          Text('CARD NUMBER',
              style: TextFontStyle.headline16StyleCabin
                  .copyWith(color: AppColors.cA7A7A7)),
          UIHelper.verticalSpace(8.h),
          CustomTextFormField(
            borderRadius: 12.r,
            isPrefixIcon: true,
            iconpath: Assets.icons.card,
            hintText: '1827 1287 3920 0879',
          ),
          UIHelper.verticalSpace(24.h),

          Row(
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Card Number
                    Text('Expiry Date',
                        style: TextFontStyle.headline16StyleCabin
                            .copyWith(color: AppColors.cA7A7A7)),
                    UIHelper.verticalSpace(8.h),
                    CustomTextFormField(
                      borderRadius: 12.r,
                      isPrefixIcon: true,
                      iconpath: Assets.icons.calendar,
                      hintText: '10/01',
                    )
                  ],
                ),
              ),
              UIHelper.horizontalSpaceSmall,
              // Expaire Date
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('3- Digit CVV',
                        style: TextFontStyle.headline16StyleCabin
                            .copyWith(color: AppColors.cA7A7A7)),
                    UIHelper.verticalSpace(8.h),
                    CustomTextFormField(
                      borderRadius: 12.r,
                      isPrefixIcon: true,
                      iconpath: Assets.icons.lock,
                      hintText: '879',
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: CustomFloatingButton(
        title: 'PAYMENT',
        onTap: () {
          getPopUp(context, (p0) {
            return PaymentSuccessfulWidget(
              imagePath: Assets.images.verifyImage.path,
              title: 'YOU BOOKING IS SUCCESSFULLY DONE',
              subTitle:
                  'YOUR TRANSACTION IS BEING PROCESSED. IT TAKE TAKES COUPLE OF MINIUTE.',
            );
          });
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/common_wigdets/custom_appbar.dart';
import 'package:rawado/common_wigdets/custom_container.dart';
import 'package:rawado/helpers/all_routes.dart';
import 'package:rawado/helpers/navigation_service.dart';
import 'package:rawado/helpers/ui_helpers.dart';

import '../../../common_wigdets/auth_button.dart';
import '../../../constants/text_font_style.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/helper_methods.dart';
import '../../booking/presentation/booking_summary_screen.dart';

class ReScheduleBooking extends StatefulWidget {
  const ReScheduleBooking({super.key});

  @override
  State<ReScheduleBooking> createState() => _ReScheduleBookingState();
}

class _ReScheduleBookingState extends State<ReScheduleBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'BOOKING SUMMERY',
        centerTitle: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
        children: [
          CustomContainer(
            child: Column(
              children: [
                const BookingSummuryWidget(
                  title: 'TRAINER NAME:',
                  subTitle: 'JOHN DEO',
                ),
                UIHelper.verticalSpaceSmall,
                const BookingSummuryWidget(
                  title: 'Address:',
                  subTitle: 'Paris, France',
                ),
                UIHelper.verticalSpaceSmall,
                const BookingSummuryWidget(
                  title: 'Booking Date:',
                  subTitle: '26 Aug 2024',
                ),
                UIHelper.verticalSpaceSmall,
                const BookingSummuryWidget(
                  title: 'Booking Time:',
                  subTitle: '5.20 AM',
                ),
                UIHelper.verticalSpaceSmall,
                const BookingSummuryWidget(
                  title: 'Service:',
                  subTitle: 'Yoga',
                ),
                UIHelper.verticalSpaceSmall,
                const BookingSummuryWidget(
                  title: 'Service Duration:',
                  subTitle: '1 Hour',
                ),
                UIHelper.verticalSpaceSmall,
                const BookingSummuryWidget(
                  title: 'Payment:',
                  subTitle: '\$120',
                ),
                UIHelper.verticalSpaceSmall,
                const BookingSummaryButton(
                  padding: EdgeInsets.zero,
                )
              ],
            ),
          ),
        ],
      ),
      // floatingActionButton: const BookingSummaryButton(),
    );
  }
}

class BookingSummaryButton extends StatelessWidget {
  final String? leftButtonName;
  final String? rightButtonName;
  final VoidCallback? leftOnTap;
  final VoidCallback? rightOnTap;
  final EdgeInsets? padding;
  const BookingSummaryButton({
    super.key,
    this.leftButtonName,
    this.rightButtonName,
    this.leftOnTap,
    this.rightOnTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.only(left: 36.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: AppCustomeButton(
                name: leftButtonName ?? 'CANCLE',
                onCallBack: () {
                  if (rightOnTap == null) {
                    return;
                  }
                  leftOnTap!();
                },
                height: 56.h,
                minWidth: double.infinity,
                borderRadius: 40.r,
                color: Colors.transparent,
                borderSideColor: appColor(),
                textStyle: TextFontStyle.headline14StyleCabin700
                    .copyWith(color: AppColors.white),
                context: context),
          ),
          UIHelper.horizontalSpaceSmall,
          Flexible(
            flex: 1,
            child: AppCustomeButton(
                name: rightButtonName ?? 'CONFIRM',
                onCallBack: () {
                  if (rightOnTap == null) {
                    NavigationService.navigateTo(Routes.appointment);
                    return;
                  }
                  rightOnTap!();
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
    );
  }
}

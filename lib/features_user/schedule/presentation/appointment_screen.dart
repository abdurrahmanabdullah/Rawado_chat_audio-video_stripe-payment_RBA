import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/common_wigdets/custom_appbar.dart';
import '../../../constants/text_font_style.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/helper_methods.dart';
import '../../../helpers/ui_helpers.dart';
import '../../booking/presentation/booking_summary_screen.dart';
import '../../booking/presentation/widgets/payment_successful_widget.dart';
import '../../profile/presentation/profile_screen.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'RE-SCHEDULE APPOINTMENTS',
        centerTitle: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
        children: [
          Text(
            'DATE',
            style: TextFontStyle.headline16StyleCabin500
                .copyWith(color: AppColors.cA7A7A7),
          ),
          UIHelper.verticalSpace(12.h),
          ProfileButton(
            onTap: () {
              log('logout on tap');
            },
            title: '06 sep 2023',
            imagePath: Assets.icons.calendar,
          ),
          UIHelper.verticalSpace(18.h),
          Text(
            'TIME',
            style: TextFontStyle.headline16StyleCabin500
                .copyWith(color: AppColors.cA7A7A7),
          ),
          UIHelper.verticalSpace(12.h),
          ProfileButton(
            onTap: () {
              log('logout on tap');
            },
            title: '09:00 AM',
            imagePath: Assets.icons.clock,
          ),
        ],
      ),
      floatingActionButton: CustomFloatingButton(
          title: 'CONTINUE',
          onTap: () {
            getPopUp(context, (p0) {
              return PaymentSuccessfulWidget(
                imagePath: Assets.images.success.path,
                title: 'APPOINTMENT BOOKED',
                subTitle: 'YOUR BOOKING HAS BEEN SUCCESSFULLY DONE.',
              );
            });
          }),
    );
  }
}

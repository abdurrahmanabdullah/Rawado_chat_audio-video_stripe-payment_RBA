import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/common_wigdets/custom_appbar.dart';
import 'package:rawado/common_wigdets/custom_container.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/gen/colors.gen.dart';
import 'package:rawado/helpers/navigation_service.dart';
import 'package:rawado/helpers/ui_helpers.dart';

import '../../booking/presentation/booking_summary_screen.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'PRVACY POLICY',
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'THE SERVICE WE PROVIDE',
              style: TextFontStyle.headline14StyleCabin500
                  .copyWith(color: AppColors.cA7A7A7),
            ),
            UIHelper.verticalSpace(12.h),
            CustomContainer(
              boarder: 12.r,
              child: SizedBox(
                width: 313,
                child: Text(
                    "LOREM IPSUM DOLOR SIT AMET CONSECTETUR. NEC MORBI MAECENAS VITAE VIVERRA. ALIQUAM PURUS PROIN AENEAN QUAM PHARETRA VIVERRA URNA.",
                    style: TextFontStyle.headline14StyleCabin
                        .copyWith(color: AppColors.cCFCFCF)),
              ),
            ),
            UIHelper.verticalSpace(12.h),
            Text(
              'HOW OUR SERVICES ARE FUNDED',
              style: TextFontStyle.headline14StyleCabin500
                  .copyWith(color: AppColors.cA7A7A7),
            ),
            UIHelper.verticalSpace(12.h),
            CustomContainer(
              boarder: 12.r,
              child: SizedBox(
                width: 313,
                child: Text(
                    "LOREM IPSUM DOLOR SIT AMET CONSECTETUR. NEC MORBI MAECENAS VITAE VIVERRA. ALIQUAM PURUS PROIN AENEAN QUAM PHARETRA VIVERRA URNA.",
                    style: TextFontStyle.headline14StyleCabin
                        .copyWith(color: AppColors.cCFCFCF)),
              ),
            ),
            UIHelper.verticalSpace(12.h),
            Text(
              'ADDITIONAL PROVISIONS',
              style: TextFontStyle.headline14StyleCabin500
                  .copyWith(color: AppColors.cA7A7A7),
            ),
            UIHelper.verticalSpace(12.h),
            CustomContainer(
              boarder: 12.r,
              child: SizedBox(
                width: 313,
                child: Text(
                    "LOREM IPSUM DOLOR SIT AMET CONSECTETUR. NEC MORBI MAECENAS VITAE VIVERRA. ALIQUAM PURUS PROIN AENEAN QUAM PHARETRA VIVERRA URNA.",
                    style: TextFontStyle.headline14StyleCabin
                        .copyWith(color: AppColors.cCFCFCF)),
              ),
            ),
            UIHelper.verticalSpace(12.h),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingButton(
        title: 'BACK TO HOME',
        onTap: () {
          NavigationService.goBack;
        },
      ),
    );
  }
}

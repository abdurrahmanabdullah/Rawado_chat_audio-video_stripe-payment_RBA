import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/constants/app_constants.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/helpers/toast.dart';

import '../../../common_wigdets/custom_appbar.dart';
import '../../../helpers/di.dart';
import '../../../helpers/ui_helpers.dart';
import '../../onboarding/presentations/widget/onboarding_data.dart';

class SelectThemeScreen extends StatefulWidget {
  const SelectThemeScreen({super.key});

  @override
  State<SelectThemeScreen> createState() => _SelectThemeScreenState();
}

class _SelectThemeScreenState extends State<SelectThemeScreen> {
  String? selectedProfileType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        centerTitle: false,
        title: 'EDIT THEAM',
      ),
      body: ListView(
        padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
        children: [
          Text(
            'SELECT YOUR THEAM',
            style: TextFontStyle.headline24StyleCabin700,
            textAlign: TextAlign.center,
          ),
          UIHelper.verticalSpace(12.h),
          LanguageButton(
            onTap: () {
              setState(() {
                selectedProfileType = 'PURPLE';
                appData.write(kKeyTheam, kKeyPurpleTheam);
                ToastUtil.showLongToast('THEAM CHANGES SUCCESSSFULLY');
                // Get.changeTheme(ThemeData(
                //     primarySwatch: CustomTheme.kToPurple,
                //     useMaterial3: false,
                //     scaffoldBackgroundColor: AppColors.scaffoldColor));
              });
            },
            title: 'PURPLE',
            isSelected: appData.read(kKeyTheam) == kKeyPurpleTheam,
          ),
          UIHelper.verticalSpace(12.h),
          LanguageButton(
            onTap: () {
              setState(() {
                selectedProfileType = 'WHITE';
                appData.write(kKeyTheam, kKeyWhiteTheam);

                ToastUtil.showLongToast('THEAM CHANGES SUCCESSSFULLY');

                // Get.changeTheme(ThemeData(
                //     primarySwatch: CustomTheme.kToWhite,
                //     primaryColor: AppColors.whiteTheamColor,
                //     useMaterial3: false,
                //     scaffoldBackgroundColor: AppColors.scaffoldColor));
              });
            },
            title: 'WHITE',
            isSelected: appData.read(kKeyTheam) == kKeyWhiteTheam,
          ),
          UIHelper.verticalSpace(12.h),
          LanguageButton(
            onTap: () {
              setState(() {
                selectedProfileType = 'BLUE';
                appData.write(kKeyTheam, kKeyBlueTheam);

                ToastUtil.showLongToast('THEAM CHANGES SUCCESSSFULLY');
                // Get.changeTheme(ThemeData(
                //     primarySwatch: CustomTheme.kToBlue,
                //     primaryColor: AppColors.blueTheamColor,
                //     useMaterial3: false,
                //     scaffoldBackgroundColor: AppColors.scaffoldColor));
              });
            },
            title: 'BLUE',
            isSelected: appData.read(kKeyTheam) == kKeyBlueTheam,
          ),
        ],
      ),
    );
  }
}

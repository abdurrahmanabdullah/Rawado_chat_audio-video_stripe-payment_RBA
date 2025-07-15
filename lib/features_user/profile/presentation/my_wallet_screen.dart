import 'package:flutter/material.dart';
import 'package:rawado/common_wigdets/custom_appbar.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/gen/colors.gen.dart';
import 'package:rawado/helpers/ui_helpers.dart';

import '../../../helpers/helper_methods.dart';

class MyWalletScreen extends StatefulWidget {
  const MyWalletScreen({super.key});

  @override
  State<MyWalletScreen> createState() => _EarningScreenState();
}

class _EarningScreenState extends State<MyWalletScreen> {
  @override
  Widget build(BuildContext context) {
    ///---- TODO: Implement Your Walet Fuctionality
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'MY WALLET',
        centerTitle: false,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
        children: [
          Text('MY WALLET',
              style: TextFontStyle.headline14StyleCabin700
                  .copyWith(color: AppColors.cA7A7A7)),
          UIHelper.verticalSpaceMedium,
          Text('\$ 00.00',
              style: TextFontStyle.headline28StyleCabin700
                  .copyWith(color: appColor())),
          UIHelper.verticalSpaceMedium,
        ],
      ),
    );
  }
}

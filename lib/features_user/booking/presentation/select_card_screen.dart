import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/common_wigdets/custom_container.dart';
import 'package:rawado/gen/assets.gen.dart';
import 'package:rawado/helpers/ui_helpers.dart';
import '../../../common_wigdets/custom_appbar.dart';
import '../../../constants/text_font_style.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/helper_methods.dart';
import '../../../helpers/navigation_service.dart';
import 'booking_summary_screen.dart';

class SelectCardScreen extends StatefulWidget {
  const SelectCardScreen({super.key});

  @override
  State<SelectCardScreen> createState() => _SelectCardScreenState();
}

class _SelectCardScreenState extends State<SelectCardScreen> {
  bool _isPaypal = false;
  bool _isMasterCard = true;
  bool _isApplePay = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'PAYMENT',
        centerTitle: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
        children: [
          BankCardWidget(
            isSelected: _isMasterCard,
            title: 'MASTERCARD',
            onTap: () {
              setState(() {
                _isMasterCard = true;
                _isApplePay = false;
                _isPaypal = false;
              });
            },
          ),
          UIHelper.verticalSpace(16.h),
          BankCardWidget(
            onTap: () {
              setState(() {
                _isPaypal = true;
                _isMasterCard = false;
                _isApplePay = false;
              });
            },
            isSelected: _isPaypal,
            title: 'PAYPAL',
            path: Assets.icons.paypal.path,
          ),
          UIHelper.verticalSpace(16.h),
          BankCardWidget(
            onTap: () {
              setState(() {
                _isApplePay = true;
                _isMasterCard = false;
                _isPaypal = false;
              });
            },
            isSelected: _isApplePay,
            title: 'APPLE PAY',
            path: Assets.icons.applePay.path,
          ),
        ],
      ),
      floatingActionButton: CustomFloatingButton(
        title: 'CONTINUE PAYMENT',
        onTap: () {
          NavigationService.navigateTo(Routes.addCardScreen);
        },
      ),
    );
  }
}

class BankCardWidget extends StatelessWidget {
  final String title;
  final String? path;
  final String? cardNumber;
  final bool isSelected;
  final VoidCallback? onTap;
  const BankCardWidget({
    super.key,
    required this.title,
    required this.isSelected,
    this.path,
    this.cardNumber,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        boarder: 40.r,
        child: Row(
          children: [
            Image.asset(
              path ?? Assets.icons.mastercard.path,
              height: 21.h,
              width: 32.w,
            ),
            UIHelper.horizontalSpace(16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextFontStyle.headline14StyleCabin500,
                ),
                CardNumberMasked(
                    cardNumber: cardNumber ?? '0783 7873 0783 7873')
              ],
            ),
            const Spacer(),
            CircleAvatar(
              radius: 10,
              backgroundColor: isSelected ? appColor() : AppColors.cA8A8A8,
              child: CircleAvatar(
                radius: 8,
                backgroundColor: AppColors.c1C1C1C,
                child: CircleAvatar(
                  radius: 6,
                  backgroundColor: isSelected ? appColor() : AppColors.c1C1C1C,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardNumberMasked extends StatelessWidget {
  final String cardNumber;

  const CardNumberMasked({super.key, required this.cardNumber});

  @override
  Widget build(BuildContext context) {
    // Mask the first 12 digits and show the last 4 digits
    String maskedNumber = cardNumber.replaceRange(0, 12, '**** **** **** ');

    return Text(
      maskedNumber,
      style:
          TextFontStyle.headline12StyleCabin.copyWith(color: AppColors.cA7A7A7),
    );
  }
}

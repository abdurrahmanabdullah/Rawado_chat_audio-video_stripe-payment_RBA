// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:rawado/constants/app_constants.dart';
import 'package:rawado/helpers/di.dart';
import 'package:svg_flutter/svg.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/helper_methods.dart';
import '../../../../helpers/navigation_service.dart';

class PriceWidget extends StatelessWidget {
  final int? price;
  final int? trainerId;
  final String? trainerName;
  const PriceWidget({
    super.key,
    this.price,
    this.trainerId,
    this.trainerName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            style: TextFontStyle.headline24StyleCabin700
                .copyWith(color: appColor()),
            text: '${price ?? '\$120'} ',
            children: [
              TextSpan(
                text: '\\HR',
                style: TextFontStyle.headline16StyleCabin
                    .copyWith(color: AppColors.cA7A7A7),
              ),
            ],
          ),
        ),
        appData.read(kKeyRoleType) != kKeyISTrainer
            ? GestureDetector(
                onTap: () {
                  NavigationService.navigateToWithArgs(Routes.massageInbox,
                      {"id": trainerId, "name": trainerName});
                },
                child: SvgPicture.asset(
                  Assets.icons.fillChat,
                  color: appColor(),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

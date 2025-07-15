import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/constants/app_constants.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../constants/text_font_style.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helpers/di.dart';
import '../../../../helpers/distance_calculator.dart';
import '../../../../helpers/helper_methods.dart';
import '../../../../helpers/ui_helpers.dart';

class TrainerInformationWidget extends StatefulWidget {
  final VoidCallback? bookNowOnTap;
  final String? trainerName;
  final String? category;
  final String? status;
  final String? charge;
  final String? distance;
  final double? lat;
  final double? long;
  const TrainerInformationWidget({
    super.key,
    this.bookNowOnTap,
    this.trainerName = 'JONE',
    this.category,
    this.status,
    this.charge,
    this.distance,
    this.lat,
    this.long,
  });

  @override
  State<TrainerInformationWidget> createState() =>
      _TrainerInformationWidgetState();
}

class _TrainerInformationWidgetState extends State<TrainerInformationWidget> {
  double? distance = 0.0;

  @override
  void initState() {
    canculateDistance();
    super.initState();
  }

  void canculateDistance() async {
    distance = await calculateDistance(context, widget.lat!, widget.long!);
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Column(
        children: [
          TrainerNameWidget(
            trainerName: widget.trainerName,
            category: widget.category ?? 'Yoga',
            status: widget.status ?? 'active',
          ),
          UIHelper.verticalSpaceSmall,
          Row(
            children: [
              SvgPicture.asset(Assets.icons.location),
              Text(
                '${distance!.toStringAsFixed(2)} KM AWAY',
                style: TextFontStyle.headline12StyleCabin500
                    .copyWith(color: AppColors.c5A5C5F),
              )
            ],
          ),
          UIHelper.verticalSpaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  style: TextFontStyle.headline16StyleCabin700
                      .copyWith(color: appColor()),
                  text: widget.charge ?? '\$120',
                  children: [
                    TextSpan(
                      text: '\\HR',
                      style: TextFontStyle.headline12StyleCabin
                          .copyWith(color: AppColors.cA7A7A7),
                    ),
                  ],
                ),
              ),
              appData.read(kKeyRoleType) == kKeyISUser
                  ? GestureDetector(
                      onTap: widget.bookNowOnTap,
                      child: Row(
                        children: [
                          Text(
                            'BOOK NOW',
                            style: TextFontStyle.headline14StyleCabin500
                                .copyWith(color: AppColors.white),
                          ),
                          UIHelper.horizontalSpaceSmall,
                          Icon(
                            Icons.arrow_forward,
                            color: AppColors.white,
                            size: 12.sp,
                          )
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}

class TrainerNameWidget extends StatelessWidget {
  final String? trainerName;
  final String? category;
  final String? status;
  const TrainerNameWidget({
    super.key,
    this.trainerName,
    this.category,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    log(' (${category!.toUpperCase()})');
    log('service status is : ${status!}');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            style: TextFontStyle.headline16StyleCabin700,
            text: trainerName!.toUpperCase(),
            children: [
              TextSpan(
                text: ' (${category!.toUpperCase()})',
                style: TextFontStyle.headline12StyleCabin
                    .copyWith(color: appColor()),
              ),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 5,
              backgroundColor:
                  status == 'active' ? AppColors.c36B37E : Colors.transparent,
            ),
            UIHelper.horizontalSpace(5),
            Text(
              status == 'active' ? 'AVAILABLE' : 'UNAVAILABLE',
              style: TextFontStyle.headline12StyleCabin
                  .copyWith(color: AppColors.cA7A7A7),
            )
          ],
        ),
      ],
    );
  }
}

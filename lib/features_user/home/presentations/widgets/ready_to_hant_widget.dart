// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/gen/colors.gen.dart';
import 'package:svg_flutter/svg.dart';
import '../../../../common_wigdets/loading_indicators.dart';
import '../../../../features_trainer/home/model/all_service_model.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../helpers/helper_methods.dart';
import '../../../../helpers/ui_helpers.dart';
import 'trainer_info_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ReadyToHuntCard extends StatelessWidget {
  final ServiceData? serviceData;
  final double width;
  final double? imageHeight;
  final String image;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  const ReadyToHuntCard({
    super.key,
    this.width = double.infinity,
    required this.image,
    required this.padding,
    this.onTap,
    this.serviceData,
    this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    // double distance = Geolocator.distanceBetween();
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: width,
          padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 4),
          decoration: BoxDecoration(
            color: AppColors.c1C1C1C,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              ImageBannerWidget(
                imageHeight: imageHeight,
                image: image,
                rating: double.parse(
                    serviceData!.totalRatingAverage!.toStringAsFixed(1)),
              ),
              UIHelper.verticalSpaceSmall,
              TrainerInformationWidget(
                trainerName: serviceData?.name!.split(' ').first ?? '',
                category: serviceData?.category!.name!,
                charge: serviceData?.charge.toString(),
                status: serviceData?.status.toString(),
                lat: double.parse(serviceData!.latitude!),
                long: double.parse(serviceData!.longitude!),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ImageBannerWidget extends StatelessWidget {
  final double? imageHeight;
  final String image;
  final double? rating;
  const ImageBannerWidget({
    super.key,
    required this.image,
    this.imageHeight,
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: CachedNetworkImage(
              width: double.infinity,
              height: imageHeight ?? 150.h,
              imageUrl: image,
              fit: BoxFit.cover,
              placeholder: (context, url) => shimmer(
                  context: context,
                  size: double.infinity,
                  color: Colors.tealAccent),
              errorWidget: (context, url, error) => Icon(
                Icons.error,
                color: Colors.redAccent,
                size: 50.sp,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          bottom: 0,
          child: Container(
            // width: 245,
            // height: 129,
            decoration: ShapeDecoration(
              color: AppColors.c111111.withOpacity(.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        Positioned(
          right: 12.sp,
          top: 12.sp,
          child: Row(
            children: [
              SvgPicture.asset(
                Assets.images.star,
                color: appColor(),
              ),
              Text(
                rating?.toString() ?? '0.0',
                style: TextFontStyle.headline12StyleCabin,
              )
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/common_wigdets/custom_container.dart';
import 'package:rawado/gen/assets.gen.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../common_wigdets/loading_indicators.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helpers/helper_methods.dart';
import '../../../../helpers/ui_helpers.dart';

class ReviewCardWidget extends StatelessWidget {
  final String? image;
  final DateTime? createdtime;
  final String? userName;
  final String? reviewText;
  final double? rating;
  const ReviewCardWidget({
    super.key,
    this.image,
    this.createdtime,
    this.userName,
    this.reviewText,
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              image != null
                  ? CircleAvatar(
                      backgroundColor: AppColors.white,
                      child: CachedNetworkImage(
                        height: 50.h,
                        width: 50.h,
                        imageUrl: image!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            loadingIndicatorCircle(context: context),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          color: Colors.redAccent,
                          size: 25.sp,
                        ),
                      ))
                  : Image.asset(
                      Assets.images.profilePicture.path,
                      height: 50.h,
                      width: 50.h,
                    ),
              UIHelper.horizontalSpace(17.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userName ?? 'FLORES, JUANITA',
                      style: TextFontStyle.headline14StyleCabin500),
                  PannableRatingBar(
                    rate: rating ?? 4.5,
                    items: List.generate(
                        5,
                        (index) => RatingWidget(
                              selectedColor: appColor(),
                              unSelectedColor: AppColors.cA7A7A7,
                              child: const Icon(
                                Icons.star,
                                size: 20,
                              ),
                            )),
                    onChanged: (value) {},
                  ),
                ],
              ),
              const Spacer(),
              Text(timeago.format(createdtime!),
                  style: TextFontStyle.headline12StyleCabin
                      .copyWith(color: AppColors.cA7A7A7)),
            ],
          ),
          UIHelper.verticalSpace(16.h),
          SizedBox(
            width: 323,
            child: Text(
                reviewText ??
                    'JOHN IS A PASSIONATE AND DEDICATED PERSONAL TRAINER WITH OVER FIVE YEARS OF EXPERIENCE IN HELPING CLIENTS ACHIEVE THEIR FITNESS GOALS.',
                style: TextFontStyle.headline14StyleCabin
                    .copyWith(color: AppColors.cA7A7A7)),
          )
        ],
      ),
    );
  }
}

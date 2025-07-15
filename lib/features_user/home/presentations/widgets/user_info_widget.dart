// ignore_for_file: deprecated_member_use
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/helpers/all_routes.dart';
import 'package:rawado/helpers/helper_methods.dart';
import 'package:rawado/helpers/navigation_service.dart';
import 'package:svg_flutter/svg_flutter.dart';
import '../../../../common_wigdets/loading_indicators.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helpers/ui_helpers.dart';

class UserInfoSection extends StatelessWidget {
  final String? name;
  final String? image;
  final VoidCallback? onTap;
  const UserInfoSection({
    super.key,
    this.name,
    this.image, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    /// Method to get the greeting based on the current time
    String getGreeting() {
      final hour = DateTime.now().hour;
      if (hour >= 5 && hour < 12) {
        return 'GOOD MORNING';
      } else if (hour >= 12 && hour < 15) {
        return 'GOOD NOON';
      } else if (hour >= 15 && hour < 17) {
        return 'GOOD AFTERNOON';
      } else if (hour >= 17 && hour < 20) {
        return 'GOOD EVENING';
      } else {
        return 'GOOD NIGHT';
      }
    }

    return GestureDetector(
      onTap:onTap,
      child: StreamBuilder(
          stream: null,
          builder: (context, snapshot) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.cCFCFCF,
                  radius: 25.r,
                  child: image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(25.r),
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
                          ),
                        )
                      : Image.asset(Assets.images.avator.path),
                ),
                UIHelper.horizontalSpaceSmall,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getGreeting(),
                      style: TextFontStyle.headline12StyleCabin,
                    ),
                    SizedBox(
                      width: 220.w,
                      child: Text(
                        name ?? 'JONE',
                        style: TextFontStyle.headline16StyleCabin700,
                      ),
                    )
                  ],
                ),
                UIHelper.horizontalSpaceMedium,
                GestureDetector(
                    onTap: () {
                      NavigationService.navigateTo(Routes.notification);
                    },
                    child: SvgPicture.asset(
                      Assets.icons.notification,
                      color: appColor(),
                    ))
              ],
            );
          }),
    );
  }
}

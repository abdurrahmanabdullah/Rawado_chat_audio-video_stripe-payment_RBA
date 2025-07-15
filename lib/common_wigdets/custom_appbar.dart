import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';
import '../gen/assets.gen.dart';
import '../gen/colors.gen.dart';
import '../helpers/navigation_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? action;
  final bool? centerTitle;
  final bool isLeading;
  const CustomAppBar({
    super.key,
    this.title,
    this.action,
    this.centerTitle = false,
    this.isLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.scaffoldColor,
      leading: isLeading
          ? Padding(
              padding: EdgeInsets.all(16.sp),
              child: GestureDetector(
                onTap: () => NavigationService.goBack,
                child: SvgPicture.asset(
                  Assets.icons.backButton,
                ),
              ),
            )
          : const SizedBox.shrink(),
      centerTitle: centerTitle,
      title: Text(title ?? ''),
      actions: action ?? [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

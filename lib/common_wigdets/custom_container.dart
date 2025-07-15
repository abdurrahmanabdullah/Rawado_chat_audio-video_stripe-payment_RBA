import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/gen/colors.gen.dart';

class CustomContainer extends StatelessWidget {
  final Color? color;
  final double? width;
  final double? height;
  final Widget? child;
  final double? boarder;
  final EdgeInsets? paddingEdgeInsets;
  const CustomContainer(
      {super.key,
      this.width = double.infinity,
      this.height,
      this.child,
      this.boarder = 12,
      this.color = AppColors.c1C1C1C,
      this.paddingEdgeInsets =
          const EdgeInsets.symmetric(horizontal: 10, vertical: 14)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: paddingEdgeInsets,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(boarder ?? 12.r),
      ),
      child: child,
    );
  }
}

import 'package:flutter/material.dart';

import '../constants/text_font_style.dart';
import '../gen/colors.gen.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const SectionHeader({
    super.key,
    this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextFontStyle.headline16StyleCabin700),
        GestureDetector(
          onTap: onTap,
          child: Text(
            'SEE ALL',
            style: TextFontStyle.headline12StyleCabin
                .copyWith(color: AppColors.c5A5C5F),
          ),
        )
      ],
    );
  }
}

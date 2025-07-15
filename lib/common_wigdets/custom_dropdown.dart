import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/constants/text_font_style.dart';

import '../gen/colors.gen.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final String Function(T) itemToString;
  final void Function(T?) onChanged;
  final Color borderColor;
  final Color dropdownIconColor;
  final BorderRadius borderRadius;
  final double? menuWidth;
  final String? hint;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.itemToString,
    required this.onChanged,
    this.borderColor = Colors.transparent,
    this.dropdownIconColor = AppColors.c5A5C5F,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.menuWidth = 300,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
      decoration: BoxDecoration(
        color: AppColors.c1C1C1C,
        border: Border.all(color: borderColor),
        borderRadius: borderRadius,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isDense: false,
          dropdownColor: AppColors.c1C1C1C,
          borderRadius: BorderRadius.circular(16.r),
          hint: Text(
            hint ?? '',
            style: TextFontStyle.headline16StyleCabin
                .copyWith(color: AppColors.c5A5C5F),
          ),
          // menuWidth: menuWidth,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          value: selectedItem,
          onChanged: onChanged,
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                itemToString(item),
                style: TextFontStyle.headline14StyleCabin500
                    .copyWith(color: AppColors.cCFCFCF),
              ),
            );
          }).toList(),
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down, color: dropdownIconColor),
        ),
      ),
    );
  }
}

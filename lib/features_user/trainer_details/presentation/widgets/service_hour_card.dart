import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/common_wigdets/custom_container.dart';
import 'package:rawado/gen/assets.gen.dart';
import 'package:svg_flutter/svg.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../helpers/ui_helpers.dart';

class ServiceHourCard extends StatelessWidget {
  final String? day;
  final String? startTime;
  final String? endTime;
  const ServiceHourCard({
    super.key,
    this.day,
    this.startTime,
    this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.icons.arm),
              UIHelper.horizontalSpace(12.w),
              Text(day ?? 'SUN', style: TextFontStyle.headline12StyleCabin),
            ],
          ),
          Text(_convertToAmPm('$startTime - $endTime'),
              style: TextFontStyle.headline12StyleCabin)
        ],
      ),
    );
  }

  /// Converts 24-hour format to AM/PM format
  String _convertToAmPm(String timeRange) {
    final times = timeRange.split(' - ');
    final startTime = _formatToAmPm(times[0]);
    final endTime = _formatToAmPm(times[1]);
    return '$startTime - $endTime';
  }

  /// Converts individual time to AM/PM format
  String _formatToAmPm(String time) {
    final hour = int.parse(time.split(':')[0]);
    final minute = int.parse(time.split(':')[1]);

    final period = hour >= 12 ? 'PM' : 'AM';
    final adjustedHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '${adjustedHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }
}

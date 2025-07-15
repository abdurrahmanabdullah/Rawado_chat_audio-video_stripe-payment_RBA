import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/gen/colors.gen.dart';

import '../../../../helpers/helper_methods.dart';

class CustomBarChart extends StatefulWidget {
  const CustomBarChart({super.key});

  @override
  State<CustomBarChart> createState() => _CustomBarChartState();
}

class _CustomBarChartState extends State<CustomBarChart> {
  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   backgroundColor: Colors.black,
        //   body:
        Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BarChartTitleWidget(),
          SizedBox(height: 16.h),
          AspectRatio(
            aspectRatio: 1.5,
            child: BarChart(
              BarChartData(
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return Text(
                              value
                                  .toInt()
                                  .toString(), // Displaying the value on Y-axis
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 12.sp),
                            );
                          },
                          interval: 5)),
                  bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      const days = [
                        'SAT',
                        'MON',
                        'TUE',
                        'WED',
                        'THU',
                        'FRI',
                        'SAT'
                      ];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          days[value.toInt()],
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                      );
                    },
                  )),
                ),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                barGroups: [
                  makeGroupData(0, 5, isTouched: false),
                  makeGroupData(1, 10, isTouched: false),
                  makeGroupData(2, 11, isTouched: false),
                  makeGroupData(3, 20, isTouched: true), // Highlighted bar
                  makeGroupData(4, 13, isTouched: false),
                  makeGroupData(5, 30, isTouched: false),
                  makeGroupData(6, 10, isTouched: false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    // );
  }

  BarChartGroupData makeGroupData(int x, double y, {bool isTouched = false}) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: isTouched ? appColor() : Colors.grey,
          width: 16.w,
          borderRadius: BorderRadius.circular(4.r),
        ),
      ],
    );
  }
}

class BarChartTitleWidget extends StatelessWidget {
  const BarChartTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SEP 1 - SEP 8',
              style: TextFontStyle.headline12StyleCabin500
                  .copyWith(color: AppColors.cA7A7A7),
            ),
            SizedBox(height: 4.h),
            Text(
              '\$470',
              style: TextFontStyle.headline14StyleCabin700
                  .copyWith(color: appColor()),
            ),
            SizedBox(height: 12.h),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'WEEKLY',
                  style: TextStyle(color: Colors.grey[300], fontSize: 14.sp),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.grey[300]),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/common_wigdets/custom_appbar.dart';
import 'package:rawado/common_wigdets/custom_container.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/features_trainer/earning/presentation/widgets/custom_chart_widget.dart';
import 'package:rawado/gen/colors.gen.dart';
import 'package:rawado/helpers/ui_helpers.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../helpers/helper_methods.dart';

class EarningScreen extends StatefulWidget {
  const EarningScreen({super.key});

  @override
  State<EarningScreen> createState() => _EarningScreenState();
}

class _EarningScreenState extends State<EarningScreen> {
  List<String> title = [
    'TAOTAL EARNING',
    'YEARLY EARNING',
    'MONTHLY EARNING',
    'WEEKLY EARNING',
    'DAILY EARNING',
  ];
  //Initialize the data source.
  List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(x: 'SAT', y: 1600),
    ChartSampleData(x: 'SUN', y: 500),
    ChartSampleData(x: 'MUN', y: 1200),
    ChartSampleData(x: 'TUE', y: 1900, color: appColor()),
    ChartSampleData(x: 'WED', y: 300),
    ChartSampleData(x: 'THU', y: 1100),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'EARNING',
        centerTitle: false,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
        children: [
          Text('MY WALLET',
              style: TextFontStyle.headline14StyleCabin700
                  .copyWith(color: AppColors.cA7A7A7)),
          UIHelper.verticalSpaceMedium,
          Text('\$ 18,275.00',
              style: TextFontStyle.headline28StyleCabin700
                  .copyWith(color: appColor())),
          UIHelper.verticalSpaceMedium,
          SfBarChartWidget(chartData: chartData),
          UIHelper.verticalSpace(24.h),
          ListView.builder(
            itemCount: title.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 18.h),
                child: EarnigDetailsWidget(
                  title: title[index],
                  subTitle: '\$ 18,275.00',
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class SfBarChartWidget extends StatelessWidget {
  const SfBarChartWidget({
    super.key,
    required this.chartData,
  });

  final List<ChartSampleData> chartData;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      boarder: 16.r,
      child: Column(
        children: [
          const BarChartTitleWidget(),
          UIHelper.verticalSpace(16.h),
          SfCartesianChart(
            plotAreaBorderWidth: 0,
            borderWidth: 0,
            borderColor: Colors.transparent,
            enableSideBySideSeriesPlacement: false,
            primaryXAxis: CategoryAxis(
              // axisLine: const AxisLine(color: Colors.black),
              // title: AxisTitle(text: 'Climb Grade'),
              isVisible: true,
              majorTickLines: const MajorTickLines(size: 0),
              majorGridLines: const MajorGridLines(width: 0),
              labelStyle: TextFontStyle.headline12StyleCabin500
                  .copyWith(color: AppColors.cA7A7A7),
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              labelPosition: ChartDataLabelPosition.outside,
              labelsExtent: 40,
            ),
            primaryYAxis: NumericAxis(
              axisLine: const AxisLine(width: 0),
              // title: AxisTitle(text: 'Number Of Climb'),
              isVisible: true,

              majorTickLines: const MajorTickLines(size: 0),
              majorGridLines:
                  const MajorGridLines(width: 1, color: AppColors.c292929),
              minimum: 0,
              interval: 500,
              labelStyle: TextFontStyle.headline12StyleCabin500
                  .copyWith(color: AppColors.cA7A7A7),
            ),
            series: <ColumnSeries>[
              ColumnSeries<ChartSampleData, String>(
                borderRadius: BorderRadius.circular(4.r),
                color: appColor(),
                // Binding the chartData to the dataSource of the column series.
                dataSource: chartData,
                spacing: 0.0,

                xValueMapper: (ChartSampleData sales, _) => sales.x,
                yValueMapper: (ChartSampleData sales, _) => sales.y,
                pointColorMapper: (ChartSampleData sales, _) => sales.color,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChartSampleData {
  final String? x;
  final int? y;
  final Color? color;

  ChartSampleData({this.x, this.y, this.color = AppColors.c5A5C5F});
}

class EarnigDetailsWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  const EarnigDetailsWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextFontStyle.headline12StyleCabin
              .copyWith(color: AppColors.cA7A7A7),
        ),
        Text(
          subTitle,
          style: TextFontStyle.headline12StyleCabin.copyWith(color: appColor()),
        )
      ],
    );
  }
}

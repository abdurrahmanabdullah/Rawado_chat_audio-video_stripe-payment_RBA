import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rawado/common_wigdets/custom_appbar.dart';
import 'package:rawado/common_wigdets/custom_container.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/gen/colors.gen.dart';
import 'package:rawado/helpers/all_routes.dart';
import 'package:rawado/helpers/dateuitl.dart';
import 'package:rawado/helpers/navigation_service.dart';
import 'package:rawado/helpers/ui_helpers.dart';
import 'package:rawado/networks/api_acess.dart';

import '../../../common_wigdets/loading_indicators.dart';
import '../../../common_wigdets/no_data_found.dart';

class TrainerScheduleScreen extends StatefulWidget {
  const TrainerScheduleScreen({super.key});

  @override
  State<TrainerScheduleScreen> createState() => _TrainerScheduleScreenState();
}

class _TrainerScheduleScreenState extends State<TrainerScheduleScreen> {
  String? selectedItem;

  final List<String> items = [
    'WEEK',
    'MONTH',
    'YEAR',
  ];

  @override
  void initState() {
    getTrainerBookingListRXObj.getBookingList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isLeading: false,
        centerTitle: false,
        title: 'BOOKING LIST',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
          child: Column(
            // shrinkWrap: true,
            // physics: const BouncingScrollPhysics(),
            // padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('SERVICE HOUR',
                      style: TextFontStyle.headline14StyleCabin500
                          .copyWith(color: AppColors.cCFCFCF)),
                  // SizedBox(
                  //   width: 150.w,
                  //   height: 30.h,
                  //   child: CustomDropdown<String>(
                  //       borderRadius: BorderRadius.circular(40.r),
                  //       hint: 'WEEK',
                  //       items: items,
                  //       selectedItem: selectedItem,
                  //       itemToString: (items) => items,
                  //       onChanged: (value) {
                  //         setState(() {
                  //           selectedItem = value;
                  //         });
                  //       }),
                  // ),
                ],
              ),
              UIHelper.verticalSpaceSmall,
              StreamBuilder(
                  stream: getTrainerBookingListRXObj.dataFetcher,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData && snapshot.data != null) {
                      var response = snapshot.data!;
                      var data = response.data!;
                      if (data.isNotEmpty) {
                        return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              var bookingData = data[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: TrainerBookingListItem(
                                  trainerName: bookingData.booking!.user!.name!,
                                  startTime: bookingData.startTime,
                                  endTime: bookingData.endTime,
                                  date: DateFormat('yyyy-MM-dd')
                                      .format(bookingData.dateFull!),
                                  onTap: () {
                                    NavigationService.navigateToWithObject(
                                        Routes.bookingRequestSummary,
                                        bookingData);
                                  },
                                ),
                              );
                            });
                      } else {
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 250.0),
                                child: NotFoundWidget(),
                              ),
                            ],
                          ),
                        );
                        // return Center(
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Text(
                        //         'NO DATA AVAILABLE',
                        //         textAlign: TextAlign.center,
                        //         style: TextFontStyle.headline16StyleCabin700,
                        //       ),
                        //     ],
                        //   ),
                        // );
                      }
                    } else {
                      return Center(
                        child: loadingIndicatorCircle(context: context),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class TrainerBookingListItem extends StatelessWidget {
  final VoidCallback? onTap;
  final String? trainerName;
  final String? serviceType;
  final String? startTime;
  final String? endTime;
  final String? date;
  const TrainerBookingListItem({
    super.key,
    this.onTap,
    this.trainerName,
    this.serviceType,
    this.startTime,
    this.endTime,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        boarder: 12.r,
        height: 48.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(trainerName?.split(' ').first ?? 'RAWADO',
                style: TextFontStyle.headline12StyleCabin
                    .copyWith(color: AppColors.cCFCFCF)),
            Text(serviceType ?? 'YOGA',
                style: TextFontStyle.headline12StyleCabin
                    .copyWith(color: AppColors.cCFCFCF)),
            Text(DateFormatedUtils.convertToAmPm('$startTime - $endTime'),
                style: TextFontStyle.headline12StyleCabin
                    .copyWith(color: AppColors.cCFCFCF)),
            Text(date ?? '08-10-2024',
                style: TextFontStyle.headline12StyleCabin
                    .copyWith(color: AppColors.cCFCFCF)),
          ],
        ),
      ),
    );
  }
}

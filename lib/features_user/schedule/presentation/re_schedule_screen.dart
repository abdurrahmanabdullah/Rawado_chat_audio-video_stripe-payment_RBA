import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rawado/common_wigdets/custom_container.dart';
import 'package:rawado/common_wigdets/loading_indicators.dart';
import 'package:rawado/helpers/all_routes.dart';
import 'package:rawado/helpers/navigation_service.dart';
import 'package:rawado/helpers/toast.dart';
import 'package:rawado/helpers/ui_helpers.dart';
import '../../../common_wigdets/auth_button.dart';
import '../../../common_wigdets/custom_appbar.dart';
import '../../../common_wigdets/no_data_found.dart';
import '../../../constants/text_font_style.dart';
import '../../../helpers/dateuitl.dart';
import '../../../helpers/helper_methods.dart';
import '../../../networks/api_acess.dart';
import '../../../provider/booking_porvider.dart';
import '../../booking/presentation/booking_summary_screen.dart';

class ReScheduleScreen extends StatefulWidget {
  const ReScheduleScreen({super.key});

  @override
  State<ReScheduleScreen> createState() => _ReScheduleScreenState();
}

class _ReScheduleScreenState extends State<ReScheduleScreen> {
  @override
  void initState() {
    getAllBookedScheduleRXObj.getBookedSchedule();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        centerTitle: true,
        title: 'MY SESSION',
        isLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
                stream: getAllBookedScheduleRXObj.dataFetcher,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    var response = snapshot.data!;
                    var data = response.data!;
                    if (data.isNotEmpty) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var scheduleData = data[index];

                          return Padding(
                            padding:
                                EdgeInsets.all(UIHelper.kDefaulutPadding()),
                            child: ReScheduleWidget(
                              time:
                                  '${scheduleData.startTime} - ${scheduleData.endTime}',
                              date: DateFormat('yyyy-MM-dd')
                                  .format(scheduleData.dateFull!),
                              trainerName:
                                  scheduleData.service!.name!.toUpperCase(),
                              status: scheduleData.status!.toUpperCase(),
                              buttonName: scheduleData.status!.toUpperCase(),
                              cancleOnTap: () => ToastUtil.showLongToast(
                                  "CANCLE FEATURE COMMING SOON"),
                              reScheduleOnTap: () {
                                log('onTap');
                                // scheduleData.status == 'pending'
                                context.read<BookingPorvider>().setBookingInfo(
                                    id: scheduleData.service!.id,
                                    trainerName: scheduleData.service!.name,
                                    address: scheduleData.location,
                                    serviceType: 'YOGA',
                                    charge: scheduleData.service!.charge);
                                NavigationService.navigateToWithObject(
                                    Routes.boookingSchedule, true);
                                // : null;
                              },
                            ),
                          );
                        },
                        itemCount: data.length,
                      );
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

                      // Center(
                      //   child: Text(
                      //     'NO BOOKING REQUEST AVAILABLE',
                      //     style: TextFontStyle.headline16StyleCabin700,
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
    );
  }
}

class ReScheduleWidget extends StatelessWidget {
  final VoidCallback? cancleOnTap;
  final VoidCallback? onTap;
  final VoidCallback? reScheduleOnTap;
  final String buttonName;
  final String? trainerName;
  final String? location;
  final String? service;
  final String? status;
  final String? date;
  final String? time;
  const ReScheduleWidget({
    super.key,
    required this.buttonName,
    this.trainerName,
    this.location,
    this.service,
    this.status,
    this.cancleOnTap,
    this.reScheduleOnTap,
    this.onTap,
    this.date,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      paddingEdgeInsets: EdgeInsets.symmetric(horizontal: 12.h, vertical: 16.w),
      boarder: 12.r,
      child: Column(
        children: [
          BookingSummuryWidget(
              title: 'TRAINER NAME: ', subTitle: trainerName ?? 'Rawado Deo'),
          UIHelper.verticalSpace(16.h),
          BookingSummuryWidget(
              title: 'LOCATION:  ', subTitle: location ?? 'Beli, Indonesia'),
          UIHelper.verticalSpace(16.h),
          BookingSummuryWidget(title: 'SERVICE: ', subTitle: service ?? 'Yoga'),
          UIHelper.verticalSpace(16.h),
          BookingSummuryWidget(
              title: 'STATUS: ', subTitle: status ?? 'pending'),
          UIHelper.verticalSpace(16.h),
          BookingSummuryWidget(title: 'DATE: ', subTitle: date ?? 'N/A'),
          UIHelper.verticalSpace(16.h),
          BookingSummuryWidget(
              title: 'SERVICE TIME: ',
              subTitle: DateFormatedUtils.convertToAmPm(time!)),
          UIHelper.verticalSpace(16.h),
          status == 'reject'
              ? const SizedBox.shrink()
              : status == 'complete'
                  ? AppCustomeButton(
                      name: buttonName,
                      onCallBack: () {
                        if (onTap == null) {
                          log('onTap null');

                          return;
                        }
                        log('onTap call');

                        onTap!();
                      },
                      height: 54.h,
                      minWidth: double.infinity,
                      borderRadius: 40.r,
                      color: appColor(),
                      textStyle: TextFontStyle.headline16StyleCabin
                          .copyWith(color: appTextColor()),
                      context: context)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: AppCustomeButton(
                              name: 'CANCEL',
                              onCallBack: () {
                                if (cancleOnTap == null) {
                                  log('onTap null');

                                  return;
                                }
                                log('onTap call');

                                cancleOnTap!();
                              },
                              height: 54.h,
                              minWidth: double.infinity,
                              borderRadius: 40.r,
                              color: appColor(),
                              // borderSideColor: appColor(),
                              textStyle: TextFontStyle.headline16StyleCabin
                                  .copyWith(color: appTextColor()),
                              context: context),
                        ),
                        // UIHelper.horizontalSpaceSmall,
                        // Flexible(
                        //   flex: 1,
                        //   child: AppCustomeButton(
                        //       name: 'RESCHEDULE',
                        //       onCallBack: () {
                        //         if (reScheduleOnTap == null) {
                        //           log('onTap null');

                        //           return;
                        //         }
                        //         log('onTap call');

                        //         reScheduleOnTap!();
                        //       },
                        //       height: 54.h,
                        //       minWidth: double.infinity,
                        //       borderRadius: 40.r,
                        //       color: appColor(),
                        //       textStyle: TextFontStyle.headline16StyleCabin
                        //           .copyWith(color: appTextColor()),
                        //       context: context),
                        // ),
                      ],
                    )
        ],
      ),
    );
  }
}

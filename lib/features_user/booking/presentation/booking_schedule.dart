import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rawado/common_wigdets/custom_appbar.dart';
import 'package:rawado/helpers/all_routes.dart';
import 'package:rawado/helpers/navigation_service.dart';
import 'package:rawado/helpers/toast.dart';
import 'package:rawado/networks/api_acess.dart';
import '../../../common_wigdets/custom_container.dart';
import '../../../common_wigdets/custom_dropdown.dart';
import '../../../constants/text_font_style.dart';
import '../../../features_trainer/service/presentation/widgets/location_select_bottomsheet.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/helper_methods.dart';
import '../../../helpers/ui_helpers.dart';
import '../../../provider/address_provider.dart';
import '../../../provider/booking_porvider.dart';
import '../../profile/presentation/profile_screen.dart';
import '../model/service_schedule_time_response.dart';
import 'booking_summary_screen.dart';

class BookingScheduleScreen extends StatefulWidget {
  final bool isReSchedule;
  const BookingScheduleScreen({super.key, this.isReSchedule = false});

  @override
  State<BookingScheduleScreen> createState() => _BookingScheduleScreenState();
}

class _BookingScheduleScreenState extends State<BookingScheduleScreen> {
  String? selectedStartTime;
  String? selectedEndTime;
  DateTime? selectedDate;

  @override
  void initState() {
    // getCurrentLocation();
    super.initState();
  }

  void getCurrentLocation() async {
    await getCurrentAddressFromLatLng(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.isReSchedule ? 'RE SCHEDULE' : 'BOOKING SCHEDULE',
        centerTitle: false,
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
        children: [
          ////.......................... Select Date
          Text(
            'DATE',
            style: TextFontStyle.headline16StyleCabin500
                .copyWith(color: AppColors.cA7A7A7),
          ),
          UIHelper.verticalSpace(12.h),
          _buildDate(),
          UIHelper.verticalSpace(18.h),

          ///.......................Service Start Time
          // Text(
          //   'SERVICE START TIME',
          //   style: TextFontStyle.headline14StyleCabin500
          //       .copyWith(color: AppColors.cA7A7A7),
          // ),
          // UIHelper.verticalSpace(8.h),
          // _buildStartTime(context),
          // UIHelper.verticalSpace(18.h),

          ///.......................Service Time
          Text(
            'SERVICE START TIME',
            style: TextFontStyle.headline14StyleCabin500
                .copyWith(color: AppColors.cA7A7A7),
          ),
          UIHelper.verticalSpace(8.h),
          _buildScheduleTime(context),
          UIHelper.verticalSpace(18.h),

          // Text(
          //   'SERVICE END TIME',
          //   style: TextFontStyle.headline14StyleCabin500
          //       .copyWith(color: AppColors.cA7A7A7),
          // ),
          // UIHelper.verticalSpace(8.h),
          // _buildEndTIme(context),

          // UIHelper.verticalSpace(18.h),

          ///.................. TODO(Need To Intrigration Map) Location Section
          !widget.isReSchedule
              ? Text(
                  'YOUR ADDRESS',
                  style: TextFontStyle.headline14StyleCabin500
                      .copyWith(color: AppColors.cA7A7A7),
                )
              : const SizedBox.shrink(),
          UIHelper.verticalSpace(8.h),
          !widget.isReSchedule
              ? buildAddressSection()
              : const SizedBox.shrink(),
          UIHelper.verticalSpace(20.h),
        ],
      ),
      floatingActionButton: CustomFloatingButton(
          title: 'CONTINUE',
          onTap: () {
            if (context.read<BookingPorvider>().date == null) {
              ToastUtil.showLongToast('Please Select Date'.toUpperCase());
            } else if (context.read<BookingPorvider>().serviceTime == null) {
              ToastUtil.showLongToast(
                  'Please Select Service Time'.toUpperCase());
            }

            // else if (context.read<BookingPorvider>().endTime == null) {
            //   ToastUtil.showLongToast('Please End Time'.toUpperCase());
            // }

            else if (context.read<BookingPorvider>().address == null) {
              if (!widget.isReSchedule) {
                ToastUtil.showLongToast(
                    'Please Select Your Address'.toUpperCase());
              }
            } else {
              log('>>>>>>>>>>>>>>>>>>>>>>>>>>');
              log(widget.isReSchedule.toString());
              log('>>>>>>>>>>>>>>>>>>>>>>>>>>');
              NavigationService.navigateToWithObject(
                  Routes.bookingSummary, widget.isReSchedule);
            }
          }),
    );
  }

  Consumer<BookingPorvider> _buildDate() {
    return Consumer<BookingPorvider>(builder: (context, provider, _) {
      return ProfileButton(
        onTap: () async {
          selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365)),
          );

          if (selectedDate != null) {
            // if (provider.serviceTime != null) {
            provider.setSelectedDate(
                DateFormat('yyyy-MM-dd').format(selectedDate!));
            // }
            provider.removeServiceTime();
            getServiceScheduleRX.schedule(
                provider.id!, DateFormat('yyyy-MM-dd').format(selectedDate!));
          }
        },
        title: provider.date ?? DateFormat('yyyy-MM-dd').format(DateTime.now()),
        imagePath: Assets.icons.calendar,
      );
    });
  }

  Widget _buildScheduleTime(BuildContext context) {
    return StreamBuilder(
      stream: getServiceScheduleRX.getServiceScheduleData,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          DioException error = snapshot.error as DioException;
          return Center(
            child: Text('Error: $error'),
          );
        } else if (snapshot.data == null) {
          return CustomContainer(
            boarder: 40.r,
            child: Text(
              textAlign: TextAlign.left,
              '   SELECT DATE FIRST',
              style: TextFontStyle.headline16StyleCabin500
                  .copyWith(color: AppColors.cA7A7A7),
            ),
          );
        } else if (snapshot.hasData) {
          ServiceScheduleTimeResponse data = snapshot.data;

          var scheduleList = data.data!;
          if (scheduleList.isEmpty) {
            return CustomContainer(
              boarder: 40.r,
              child: Text(
                textAlign: TextAlign.left,
                ' No Schedule Found.'.toUpperCase(),
                style: TextFontStyle.headline16StyleCabin500
                    .copyWith(color: AppColors.cA7A7A7),
              ),
            );
          }
          return Consumer<BookingPorvider>(builder: (context, provider, _) {
            // Convert the 24-hour format into AM/PM format for display
            var dropdownItems = scheduleList.map((time) {
              return {
                'original': time,
                'display': _convertToAmPm(time),
              };
            }).toList();

            return CustomDropdown<String>(
              borderRadius: BorderRadius.circular(40.r),
              hint: 'SELECT START TIME',
              items: dropdownItems.map((item) => item['display']!).toList(),
              selectedItem: provider.serviceTime != null
                  ? _convertToAmPm(provider.serviceTime!)
                  : null,
              itemToString: (displayValue) => displayValue,
              onChanged: (displayValue) {
                // Find the original value from the selected display value
                var selectedItem = dropdownItems.firstWhere(
                    (item) => item['display'] == displayValue)['original'];
                selectedStartTime = selectedItem!;
                context
                    .read<BookingPorvider>()
                    .setServiceTime(selectedStartTime!);
              },
            );
          });
        } else {
          return const Center(
            child: Text('Loading...'),
          );
        }
      },
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

  // Widget _buildScheduleTime(BuildContext context) {
  //   return StreamBuilder(
  //       stream: getServiceScheduleRX.getServiceScheduleData,
  //       builder: (context, snapshot) {
  //         if (snapshot.hasError) {
  //           DioException error = snapshot.error as DioException;
  //           return Center(
  //             child: Text('Error: $error'),
  //           );
  //         } else if (snapshot.data == null) {
  //           return CustomContainer(
  //             boarder: 40.r,
  //             child: Text(
  //               textAlign: TextAlign.left,
  //               '   SELECT DATE FIRST',
  //               style: TextFontStyle.headline16StyleCabin500
  //                   .copyWith(color: AppColors.cA7A7A7),
  //             ),
  //           );
  //         } else if (snapshot.hasData) {
  //           ServiceScheduleTimeResponse data = snapshot.data;

  //           var scheduleList = data.data!;
  //           if (scheduleList.isEmpty) {
  //             return CustomContainer(
  //               boarder: 40.r,
  //               child: Text(
  //                 textAlign: TextAlign.left,
  //                 ' No Schedule Found.'.toUpperCase(),
  //                 style: TextFontStyle.headline16StyleCabin500
  //                     .copyWith(color: AppColors.cA7A7A7),
  //               ),
  //             );
  //           }
  //           return Consumer<BookingPorvider>(builder: (context, provider, _) {
  //             return CustomDropdown<String>(
  //                 borderRadius: BorderRadius.circular(40.r),
  //                 hint: 'SELECT ENSTARTD TIME',
  //                 items: scheduleList,
  //                 selectedItem: provider.serviceTime,
  //                 itemToString: (scheduleList) => scheduleList,
  //                 onChanged: (value) {
  //                   selectedStartTime = value!;
  //                   context
  //                       .read<BookingPorvider>()
  //                       .setServiceTime(selectedStartTime!);
  //                 });
  //           });
  //         } else {
  //           return const Center(
  //             child: Text('Loading...'),
  //           );
  //         }
  //       });
  // }

  // Widget _buildStartTime(BuildContext context) {
  //   return Consumer<BookingPorvider>(builder: (context, provider, _) {
  //     return CustomDropdown<String>(
  //         borderRadius: BorderRadius.circular(40.r),
  //         hint: 'SELECT ENSTARTD TIME',
  //         items: times,
  //         selectedItem: provider.startTime,
  //         itemToString: (time) => time,
  //         onChanged: (value) {
  //           selectedStartTime = value!;
  //           context.read<BookingPorvider>().setStartTime(selectedStartTime!);
  //         });
  //   });
  // }

  // Widget _buildEndTIme(BuildContext context) {
  //   return Consumer<BookingPorvider>(builder: (context, provider, _) {
  //     return CustomDropdown<String>(
  //         borderRadius: BorderRadius.circular(40.r),
  //         hint: 'SELECT END TIME',
  //         items: times,
  //         selectedItem: provider.endTime,
  //         itemToString: (time) => time,
  //         onChanged: (value) {
  //           selectedEndTime = value!;
  //           context.read<BookingPorvider>().setEndTime(selectedEndTime!);
  //         });
  //   });
  // }

  Consumer<AddressProvider> buildAddressSection() {
    return Consumer<AddressProvider>(builder: (context, address, _) {
      return GestureDetector(
        onTap: () {
          log('onTap location');
          getCurrentLocation();
          showBottom(context);
        },
        child: CustomContainer(
          height: 54.h,
          boarder: 40.r,
          paddingEdgeInsets:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Text(
            address.address ?? 'FIND YOUR CURRENT ADDRESS! CLICK HERE',
            style: TextFontStyle.headline16StyleCabin500
                .copyWith(color: AppColors.c5A5C5F),
          ),
        ),
      );
    });
  }

  void showBottom(BuildContext context) {
    showModalBottomSheet(
      elevation: 0,
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (builder) {
        return LocationBottomSheet(
          onTapConfirm: () {
            NavigationService.goBack;
            NavigationService.navigateToReplacement(Routes.gpsSearch);
          },
          buttonName: 'CHANGE LOCATION',
        );
      },
    );
  }
}

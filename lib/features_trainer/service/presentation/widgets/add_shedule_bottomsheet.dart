import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/common_wigdets/custom_dropdown.dart';
import 'package:rawado/helpers/loading_helper.dart';
import 'package:rawado/helpers/navigation_service.dart';
import 'package:rawado/networks/api_acess.dart';
import '../../../../../constants/text_font_style.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../helpers/ui_helpers.dart';
import '../../../../common_wigdets/auth_button.dart';
import '../../../../constants/app_constants.dart';
import '../../../../helpers/helper_methods.dart';

class AddSheduleSheetWidget extends StatefulWidget {
  final Function()? onTapConfirm;
  final int serviceID;
  const AddSheduleSheetWidget({
    super.key,
    this.onTapConfirm,
    required this.serviceID,
  });

  @override
  State<AddSheduleSheetWidget> createState() => _AddSheduleSheetWidgetState();
}

class _AddSheduleSheetWidgetState extends State<AddSheduleSheetWidget> {
  String? selectedWeek;
  String? selectedStartTime;
  String? selectedEndTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.c222222,
          borderRadius: BorderRadius.vertical(top: Radius.circular(42.sp))),
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Center(
            child: Container(
              height: 5.h,
              width: 135.w,
              decoration: BoxDecoration(
                  color: appColor(),
                  borderRadius: BorderRadius.all(Radius.circular(100.sp))),
            ),
          ),
          UIHelper.verticalSpaceMedium,
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: UIHelper.kDefaulutPadding()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SELECT WEEK',
                  style: TextFontStyle.headline14StyleCabin500
                      .copyWith(color: AppColors.cA7A7A7),
                ),
                UIHelper.verticalSpace(8.h),
                CustomDropdown<String>(
                    hint: 'SELECT WEEK',
                    items: weekNames,
                    selectedItem: selectedWeek,
                    itemToString: (weekNames) => weekNames,
                    onChanged: (value) {
                      setState(() {
                        selectedWeek = value!;
                      });
                    }),
                UIHelper.verticalSpace(20.h),
                Text(
                  'SELECT START TIME',
                  style: TextFontStyle.headline14StyleCabin500
                      .copyWith(color: AppColors.cA7A7A7),
                ),
                UIHelper.verticalSpace(8.h),
                CustomDropdown<String>(
                    hint: 'SELECT START TIME',
                    items: times,
                    selectedItem: selectedStartTime,
                    itemToString: (time) => time,
                    onChanged: (value) {
                      setState(() {
                        selectedStartTime = value!;
                      });
                    }),
                UIHelper.verticalSpace(20.h),
                Text(
                  'SERVICE END TIME',
                  style: TextFontStyle.headline14StyleCabin500
                      .copyWith(color: AppColors.cA7A7A7),
                ),
                UIHelper.verticalSpace(8.h),
                CustomDropdown<String>(
                    hint: 'SELECT END TIME',
                    items: times,
                    selectedItem: selectedEndTime,
                    itemToString: (time) => time,
                    onChanged: (value) {
                      setState(() {
                        selectedEndTime = value!;
                      });
                    }),
                UIHelper.verticalSpace(20.h),
                UIHelper.verticalSpaceMediumLarge,
                AppCustomeButton(
                  color: appColor(),
                  borderRadius: 40.sp,
                  context: context,
                  height: 54.h,
                  minWidth: double.infinity,
                  name: 'ADD',
                  onCallBack: () async {
                    // heldle login function\
                    Map body = {
                      'service_id': widget.serviceID,
                      'date_name': selectedWeek!.toLowerCase(),
                      'start_time': selectedStartTime,
                      'end_time': selectedEndTime,
                    };

                    log('body response: $body');
                    await postAddScheduleRXObj
                        .scheduleCreate(body)
                        .waitingForFuture();
                    await getAvailableServiceRXObj
                        .getAvailableService(widget.serviceID);

                    await getTrainerAllServicesRXObj.getAllServices();
                    NavigationService.goBack;
                  },
                  textStyle: TextFontStyle.headline16StyleCabin
                      .copyWith(color: appTextColor()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

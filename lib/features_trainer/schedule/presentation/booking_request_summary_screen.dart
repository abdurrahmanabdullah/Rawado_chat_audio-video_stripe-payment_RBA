import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rawado/gen/assets.gen.dart';
import 'package:rawado/helpers/dateuitl.dart';
import 'package:rawado/helpers/ui_helpers.dart';
import '../../../common_wigdets/custom_appbar.dart';
import '../../../common_wigdets/custom_container.dart';
import '../../../common_wigdets/loading_indicators.dart';
import '../../../constants/text_font_style.dart';
import '../../../features_user/booking/presentation/booking_summary_screen.dart';
import '../../../gen/colors.gen.dart';
import '../model/trainer_booking_list.dart';

class TrainerBookingRequestSummaryScreen extends StatefulWidget {
  final TrainerBookingData? bookingData;

  const TrainerBookingRequestSummaryScreen({super.key, this.bookingData});

  @override
  State<TrainerBookingRequestSummaryScreen> createState() =>
      _TrainerBookingRequestSummaryScreenState();
}

class _TrainerBookingRequestSummaryScreenState
    extends State<TrainerBookingRequestSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        centerTitle: false,
        title: 'BOOKING REQUEST SUMMARY',
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
        children: [
          CustomContainer(
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.white,
                      radius: 30.r,
                      child: widget.bookingData!.booking!.user?.avatar != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(30.r),
                              child: CachedNetworkImage(
                                height: 60.h,
                                width: 60.h,
                                imageUrl:
                                    widget.bookingData!.booking!.user!.avatar!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    loadingIndicatorCircle(context: context),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.error,
                                  color: Colors.redAccent,
                                  size: 25.sp,
                                ),
                              ),
                            )
                          : Image.asset(
                              Assets.images.profilePicture.path,
                            ),
                    ),
                    UIHelper.horizontalSpaceSmall,
                    Text(
                      widget.bookingData!.booking!.user?.name ?? 'NA',
                      style: TextFontStyle.headline16StyleCabin700,
                    )
                  ],
                ),
                UIHelper.verticalSpaceSmall,
                BookingSummuryWidget(
                  title: 'ADDRESS:',
                  subTitle: widget.bookingData!.location ?? 'NA',
                ),
                UIHelper.verticalSpaceSmall,
                BookingSummuryWidget(
                  title: 'BOOKING DATE:',
                  subTitle: DateFormat('yyyy-MM-d')
                      .format(widget.bookingData!.dateFull!),
                ),
                UIHelper.verticalSpaceSmall,
                BookingSummuryWidget(
                  title: 'BOOKING TIME:',
                  subTitle: DateFormatedUtils.convertToAmPm(
                      '${widget.bookingData!.startTime} - ${widget.bookingData!.endTime}'),
                ),
                UIHelper.verticalSpaceSmall,
                const BookingSummuryWidget(
                  title: 'SERVICE:',
                  subTitle: 'YOGA',
                ),
                UIHelper.verticalSpaceSmall,
                const BookingSummuryWidget(
                  title: 'SERVICE DURATION:',
                  subTitle: '1 HOUR',
                ),
                UIHelper.verticalSpaceSmall,
                BookingSummuryWidget(
                  title: 'PAYMENT:',
                  subTitle: '\$${widget.bookingData!.service!.charge}',
                ),
                UIHelper.verticalSpaceSmall,
                BookingSummuryWidget(
                  title: 'STATUS:',
                  subTitle: widget.bookingData!.status!.toUpperCase(),
                ),
                UIHelper.verticalSpaceSmall,
                UIHelper.verticalSpaceSmall,
                UIHelper.verticalSpaceSmall,
                // widget.bookingData!.status == 'pending'
                //     ? BookingSummaryButton(
                //         padding: EdgeInsets.zero,
                //         leftButtonName: 'DICLINE',
                //         rightButtonName: 'ACCPET',
                //         rightOnTap: () {
                //           getPopUp(context, (p0) {
                //             return PaymentSuccessfulWidget(
                //               imagePath: Assets.images.success.path,
                //               title: 'APPOINTMENT BOOKED',
                //               subTitle:
                //                   'YOUR BOOKING HAS BEEN SUCCESSFULLY DONE.',
                //             );
                //           });
                //         },
                //       )
                //     : AppCustomeButton(
                //         name: 'RESCHEDULE',
                //         onCallBack: () {
                //           NavigationService.navigateTo(Routes.appointment);
                //         },
                //         height: 54.h,
                //         minWidth: double.infinity,
                //         borderRadius: 40.r,
                //         color: appColor(),
                //         textStyle: TextFontStyle.headline16StyleCabin
                //             .copyWith(color: appTextColor()),
                //         context: context)
              ],
            ),
          ),
        ],
      ),
      // floatingActionButton: BookingSummaryButton(
      //   leftButtonName: 'DICLINE',
      //   rightButtonName: 'ACCPET',
      //   rightOnTap: () {
      //     getPopUp(context, (p0) {
      //       return PaymentSuccessfulWidget(
      //         imagePath: Assets.images.success.path,
      //         title: 'APPOINTMENT BOOKED',
      //         subTitle: 'YOUR BOOKING HAS BEEN SUCCESSFULLY DONE.',
      //       );
      //     });
      //   },
      // ),
    );
  }
}

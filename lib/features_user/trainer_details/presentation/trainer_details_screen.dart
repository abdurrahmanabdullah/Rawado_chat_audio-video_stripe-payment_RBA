import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rawado/common_wigdets/auth_button.dart';
import 'package:rawado/common_wigdets/custom_appbar.dart';
import 'package:rawado/features_user/home/presentations/widgets/ready_to_hant_widget.dart';
import 'package:rawado/features_trainer/home/model/all_service_model.dart';
import 'package:rawado/helpers/all_routes.dart';
import 'package:rawado/helpers/navigation_service.dart';
import 'package:rawado/provider/booking_porvider.dart';
import '../../../constants/text_font_style.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/helper_methods.dart';
import '../../../helpers/ui_helpers.dart';
import '../../home/presentations/widgets/trainer_info_widget.dart';
import 'widgets/price_card_widget.dart';
import 'widgets/review_card_widget.dart';
import 'widgets/service_hour_card.dart';

class TrainerDetailsScreen extends StatefulWidget {
  final ServiceData? serviceData;
  const TrainerDetailsScreen({super.key, this.serviceData});

  @override
  State<TrainerDetailsScreen> createState() => _TrainerDetailsScreenState();
}

class _TrainerDetailsScreenState extends State<TrainerDetailsScreen> {
  final ValueNotifier<bool> _isExpended = ValueNotifier(false);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'TRAINER DETAILS',
      ),
      body: ListView(
        padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          ///........ Tranning Image Banner Section
          ImageBannerWidget(
            image: widget.serviceData!.images!.first.image!,
            rating: double.parse(
                widget.serviceData!.totalRatingAverage!.toStringAsFixed(1)),
          ),
          UIHelper.verticalSpace(12.h),

          ///............ Trainer Name Section
          TrainerNameWidget(
              status: widget.serviceData!.status,
              trainerName: widget.serviceData!.name,
              category: widget.serviceData!.category!.name!),
          UIHelper.verticalSpace(12.h),

          ///............. Trainer Service Hour
          PriceWidget(
            price: widget.serviceData?.charge,
            trainerId: widget.serviceData!.userId,
            trainerName: widget.serviceData!.name,
          ),
          UIHelper.verticalSpaceMedium,

          //................ Descriptions
          Text('DESCRIPTION', style: TextFontStyle.headline16StyleCabin700),
          UIHelper.verticalSpace(12.h),
          ValueListenableBuilder<bool>(
              valueListenable: _isExpended,
              builder: (context, isExpended, _) {
                return GestureDetector(
                    onTap: () {
                      _isExpended.value = !_isExpended.value;
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          overflow: isExpended
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                          maxLines: isExpended
                              ? null
                              : 3, // Limit to 3 lines if not expanded

                          widget.serviceData?.description ?? "NA",
                          style: TextFontStyle.headline14StyleCabin
                              .copyWith(color: AppColors.cB0B0B0),
                        ),
                        Text(
                          textAlign: TextAlign.left,
                          isExpended ? 'SHOW LESS' : 'SEE ALL',
                          style: TextFontStyle.headline14StyleCabin
                              .copyWith(color: appColor()),
                        ),
                      ],
                    ));
              }),
          UIHelper.verticalSpace(24.h),

          // Service Hour
          Text('SERVICE HOUR', style: TextFontStyle.headline16StyleCabin700),
          UIHelper.verticalSpace(14.h),
          widget.serviceData!.serviceAvailables!.isNotEmpty
              ? _buildServiceCard(widget.serviceData!.serviceAvailables!)
              : Center(
                  child: Text('SERVICE NOT AVAILABLE',
                      style: TextFontStyle.headline16StyleCabin700),
                ),
          UIHelper.verticalSpace(24.h),

          //................. User Review
          Text('USER REVIEW', style: TextFontStyle.headline16StyleCabin700),
          UIHelper.verticalSpace(24.h),
          _buildReviewSection(widget.serviceData!.reviews!),
          UIHelper.horizontalSpaceLarge,
          UIHelper.horizontalSpaceLarge,
          UIHelper.horizontalSpaceLarge,
          UIHelper.horizontalSpaceLarge,
          UIHelper.verticalSpace(100.h),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: AppCustomeButton(
            name: 'BOOK NOW',
            onCallBack: () {
              context.read<BookingPorvider>().setBookingInfo(
                  id: widget.serviceData!.id,
                  trainerName: widget.serviceData!.name,
                  address: widget.serviceData!.location,
                  serviceType: widget.serviceData!.category!.name!.toString(),
                  charge: widget.serviceData!.charge);
              NavigationService.navigateToWithObject(
                  Routes.boookingSchedule, false);
            },
            height: 56.h,
            minWidth: double.infinity,
            borderRadius: 40.r,
            color: appColor(),
            textStyle: TextFontStyle.headline14StyleCabin700
                .copyWith(color: appTextColor()),
            context: context),
      ),
    );
  }

  Widget _buildReviewSection(List<Reviews> reviews) {
    return reviews.isNotEmpty
        ? ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              var review = reviews[index];
              return Padding(
                  padding: EdgeInsets.only(bottom: 16.sp),
                  child: ReviewCardWidget(
                    image: review.user?.avatar,
                    rating: double.parse(review.rating.toString()),
                    userName: review.user?.name,
                    reviewText: review.message,
                    createdtime: review.createdAt,
                  ));
            })
        : Center(
            child: Padding(
              padding: EdgeInsets.only(top: 16.sp, bottom: 30.sp),
              child: Text('NO REVIEW AVAILABLE',
                  style: TextFontStyle.headline16StyleCabin700),
            ),
          );
  }

  ListView _buildServiceCard(List<ServiceAvailable> serviceAvailableList) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: serviceAvailableList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 8.sp),
            child: ServiceHourCard(
              day: dateName(serviceAvailableList[index].dateName!),
              startTime: serviceAvailableList[index].startTime,
              endTime: serviceAvailableList[index].endTime,
            ),
          );
        });
  }



  String dateName(String day) {
    late String name;
    switch (day) {
      case 'saturday':
        name = "SAT";
        break;
      case 'sunday':
        name = "SUN";
        break;
      case 'monday':
        name = "MON";
        break;
      case 'tuesday':
        name = "TUES";
        break;
      case 'wednesday':
        name = "WED";
        break;
      case 'thursday':
        name = "THU";
        break;
      case 'friday':
        name = "FRI";
        break;

      default:
        name = "";
        break;
    }
    return name;
  }
}

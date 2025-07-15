import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/common_wigdets/auth_button.dart';
import 'package:rawado/common_wigdets/custom_appbar.dart';
import 'package:rawado/common_wigdets/loading_indicators.dart';
import 'package:rawado/features_user/home/presentations/widgets/ready_to_hant_widget.dart';
import 'package:rawado/features_trainer/service/presentation/widgets/add_shedule_bottomsheet.dart';
import 'package:rawado/gen/assets.gen.dart';
import 'package:rawado/networks/api_acess.dart';
import 'package:svg_flutter/svg_flutter.dart';
import '../../../constants/text_font_style.dart';
import '../../../features_user/home/presentations/widgets/trainer_info_widget.dart';
import '../../../features_user/trainer_details/presentation/widgets/price_card_widget.dart';
import '../../../features_user/trainer_details/presentation/widgets/service_hour_card.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/helper_methods.dart';
import '../../../helpers/ui_helpers.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final int? id;
  const ServiceDetailsScreen({super.key, this.id});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  final ValueNotifier<bool> _isExpended = ValueNotifier(false);

  List<String> day = [
    'SUN',
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
  ];

  @override
  void initState() {
    // log('servce id is : ${widget.serviceResponse!.data!.id!}');
    loadData();
    super.initState();
  }

  void loadData() async {
    getServiceDetailsRXObj.getServiceDetails(widget.id!);
    getAvailableServiceRXObj.getAvailableService(widget.id!);
  }

  @override
  void dispose() {
    getServiceDetailsRXObj.clean();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  getServiceDetailsRXObj.getServiceDetails(widget.serviceResponse.data!.id!);
    return Scaffold(
      // App Bar
      appBar: const CustomAppBar(
        title: 'TRAINER DETAILS',
      ),

      // Screen Body
      body: StreamBuilder(
          stream: getServiceDetailsRXObj.getServiceDetaisData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: loadingIndicatorCircle(context: context));
            }
            // if Snapshow has Error
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            // if Snapshot has Data
            else if (snapshot.hasData && snapshot.data != null) {
              var response = snapshot.data!;
              var data = response.data;
              if (data == null) {
                return Center(child: loadingIndicatorCircle(context: context));
              } else {
                return GestureDetector(
                
                  child: ListView(
                    padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      // Tranning Image Banner Section
                      ImageBannerWidget(
                        image: data.images!.first.image!,
                        rating: 0,
                      ),
                      UIHelper.verticalSpace(12.h),
                  
                      // Trainer Name Section
                      TrainerNameWidget(
                          trainerName: data.name!.toUpperCase(),
                          category: data.category!.name!.toUpperCase(),
                          status: data.status),
                      UIHelper.verticalSpace(12.h),
                  
                      // Trainer Service Hour
                      PriceWidget(
                        price: data.charge,
                      ),
                      UIHelper.verticalSpaceMedium,
                  
                      // Descriptions
                      Text('DESCRIPTION',
                          style: TextFontStyle.headline16StyleCabin700),
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
                  
                                      data.description?.toUpperCase() ?? "NA",
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
                      Text('SERVICE HOUR',
                          style: TextFontStyle.headline16StyleCabin700),
                      UIHelper.verticalSpace(14.h),
                  
                      // Service Hour List
                      _buildServiceCard(),
                      UIHelper.verticalSpace(24.h),
                  
                      // Add Service Button
                      AppCustomeButton(
                          isIcon: true,
                          name: 'ADD YOUR SCHEDULE',
                          onCallBack: () {
                            showBottom(context, widget.id!);
                            // NavigationService.navigateTo(Routes.addService);
                          },
                          height: 54.h,
                          minWidth: double.infinity,
                          borderRadius: 40.r,
                          color: appColor(),
                          textStyle: TextFontStyle.headline16StyleCabin700
                              .copyWith(color: appTextColor()),
                          context: context),
                      UIHelper.verticalSpace(20.h),
                  
                      Row(
                        children: [
                          SvgPicture.asset(Assets.icons.about),
                          UIHelper.horizontalSpaceSmall,
                          SizedBox(
                            width: 280.w,
                            child: Text(
                                'USERS WON’T SEE THE DETAILS BEFORE ADMINS APPROVAL',
                                style: TextFontStyle.headline14StyleCabin500),
                          ),
                        ],
                      ),
                  
                      UIHelper.verticalSpace(20.h),
                  
                      // User Review
                      // Text('USER REVIEW',
                      //     style: TextFontStyle.headline16StyleCabin700),
                      // UIHelper.verticalSpace(24.h),
                  
                      // Review Widget
                      // _buildReviewSection()
                    ],
                  ),
                );
              }
            }

            // else
            else {
              return Center(
                child: loadingIndicatorCircle(context: context),
              );
            }
          }),
    );
  }

  // ListView _buildReviewSection() {
  //   return ListView.builder(
  //       padding: EdgeInsets.zero,
  //       shrinkWrap: true,
  //       physics: const NeverScrollableScrollPhysics(),
  //       itemCount: 5,
  //       itemBuilder: (context, index) {
  //         return Padding(
  //             padding: EdgeInsets.only(bottom: 16.sp),
  //             child: const ReviewCardWidget());
  //       });
  // }

  Widget _buildServiceCard() {
    log('caall');
    return StreamBuilder(
        stream: getAvailableServiceRXObj.dataFetcher,
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
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var service = data[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.sp),
                      child: ServiceHourCard(
                        day: dateName(service.dateName!),
                        startTime: service.startTime,
                        endTime: service.endTime,
                      ),
                    );
                  });
            } else {
              return Center(
                  child: Text(response.message ?? 'SERVICE NOT AVAILABLE',
                      style: TextFontStyle.headline16StyleCabin700
                          .copyWith(color: AppColors.white)));
            }
          } else {
            return Center(
              child: loadingIndicatorCircle(context: context),
            );
          }
        });
  }

  void showBottom(BuildContext context, int id) {
    showModalBottomSheet(
      elevation: 0,
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (builder) {
        return AddSheduleSheetWidget(
          serviceID: id,
        );
      },
    );
  }
}

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/common_wigdets/custom_textfiled.dart';
import 'package:rawado/common_wigdets/loading_indicators.dart';
import 'package:rawado/features_trainer/home/model/all_service_model.dart';
import 'package:rawado/features_user/profile/model/profile_details_model.dart';
import 'package:rawado/features_user/trainer_details/presentation/trainer_details_screen.dart';
import 'package:rawado/helpers/all_routes.dart';
import 'package:rawado/helpers/di.dart';
import 'package:rawado/helpers/navigation_service.dart';
import 'package:rawado/networks/api_acess.dart';
import '../../../common_wigdets/no_data_found.dart';
import '../../../common_wigdets/section_header.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/text_font_style.dart';
import '../../../gen/assets.gen.dart';
import '../../../helpers/ui_helpers.dart';
import 'widgets/explore_banner_widget.dart';
import 'widgets/ready_to_hant_widget.dart';
import 'widgets/user_info_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var name = appData.read(kKeyUserName);

  @override
  void initState() {
    fetchData();
    // getCustomerAllServicesRXObj.getAllServices();
    // getProfileDetailsRXObj.getprofileDetails();
    super.initState();
  }

  Future<void> fetchData() async {
    await getCustomerAllServicesRXObj.getAllServices();
    await getProfileDetailsRXObj.getprofileDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              children: [
                UIHelper.verticalSpaceLarge,

                // Profile Section
                _buildUserProfileSection(),
                UIHelper.verticalSpaceMedium,

                // Search Text Filed
                _searchFiled(),
                UIHelper.verticalSpaceMedium,

                // Banner Seection
                const ExploreBanner(),

                UIHelper.verticalSpaceMediumLarge,

                SectionHeader(
                  onTap: () {
                    NavigationService.navigateTo(Routes.seeAll);
                  },
                  title: 'READY TO HUNT',
                ),

                UIHelper.verticalSpace(16.sp),
                // Rady to hunt section
                _buildReadyToHunT(),
                UIHelper.verticalSpaceMediumLarge,
                SectionHeader(
                  onTap: () {
                    NavigationService.navigateTo(Routes.seeAll);
                  },
                  title: 'RECOMMENDED TRAINER',
                ),

                // recommended trainer section
                _buildRecomandedTrainer(),
                UIHelper.verticalSpaceLarge
              ],
            ),
          ),
        ),
      ),
    );
  }

  CustomTextFormField _searchFiled() {
    return CustomTextFormField(
      onTap: () {
        NavigationService.navigateTo(Routes.navigationScreenWithArgs);
      },
      isReadOnly: true,
      hintText: 'SEARCH FITNESS TRAINER...',
      isPrefixIcon: true,
      iconpath: Assets.icons.search,
    );
  }

  StreamBuilder<AllServiceResponse> _buildRecomandedTrainer() {
    return StreamBuilder(
        stream: getCustomerAllServicesRXObj.dataFetcher,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}',
                  style: TextFontStyle.headline16StyleCabin700),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            var response = snapshot.data!;
            var data = response.data!.reversed.toList().take(6).toList();
            return data.isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var service = data[index];
                      return ReadyToHuntCard(
                        serviceData: service,
                        onTap: () => NavigationService.navigateToWithObject(
                            Routes.trainerDetails, service),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        image: service.images!.first.image!,
                        width: 253.w,
                      );
                    },
                  )
                : const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: NotFoundWidget(),
                  );
            // Center(
            //     child: Padding(
            //       padding: EdgeInsets.only(top: 16.sp, bottom: 30.sp),
            //       child: Text('SERVICE NOT AVAILABLE',
            //           style: TextFontStyle.headline16StyleCabin700),
            //     ),
            //   );
          } else {
            return Center(
              child: loadingIndicatorCircle(context: context),
            );
          }
        });
  }

  StreamBuilder<AllServiceResponse> _buildReadyToHunT() {
    return StreamBuilder(
        stream: getCustomerAllServicesRXObj.dataFetcher,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            var response = snapshot.data!;
            var data = response.data!.reversed.toList().take(6).toList();
            return SizedBox(
              height: 260.h,
              child: data.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) {
                        var service = data[index];
                        return ReadyToHuntCard(
                          imageHeight: 135.h,
                          serviceData: service,
                          onTap: () {
                            // NavigationService.navigateToWithObject(
                            //     Routes.trainerDetails, service);

                            // Navigator.pushNamed(context, Routes.trainerDetails,
                            //     arguments: service);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TrainerDetailsScreen(
                                          serviceData: service,
                                        )));
                          },
                          padding: EdgeInsets.only(right: 20.h),
                          image: service.images!.first.image!,
                          width: 253.w,
                        );
                      },
                    )
                  : const NotFoundWidget(),
              // Center(
              //     child: Text('SERVICE NOT AVAILABLE',
              //         style: TextFontStyle.headline16StyleCabin700),
              //   ),
            );
          } else {
            return Center(
              child: loadingIndicatorCircle(context: context),
            );
          }
        });
  }

  StreamBuilder<ProfileDetailsModel> _buildUserProfileSection() {
    return StreamBuilder(
        stream: getProfileDetailsRXObj.dataFetcher,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            DioException error = snapshot.error as DioException;
            return Center(
              child: Text('Error: ${error.message}'),
            );
          } else if (snapshot.hasData) {
            var profile = snapshot.data!;
            return UserInfoSection(
              onTap: () {
                log('onTap');
                NavigationService.navigateTo(Routes.navigatonProfileScreen);
              },
              name: profile.data!.name,
              image: profile.data?.avatar,
            );
          } else {
            return Center(
              child: loadingIndicatorCircle(context: context),
            );
          }
        });
  }
}

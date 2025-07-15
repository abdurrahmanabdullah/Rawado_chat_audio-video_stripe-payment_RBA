import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/common_wigdets/auth_button.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/features_trainer/home/model/all_service_model.dart';
import 'package:rawado/features_user/profile/model/profile_details_model.dart';
import 'package:rawado/gen/colors.gen.dart';
import 'package:rawado/helpers/all_routes.dart';
import 'package:rawado/helpers/navigation_service.dart';

import '../../../common_wigdets/loading_indicators.dart';
import '../../../features_user/home/presentations/widgets/ready_to_hant_widget.dart';
import '../../../features_user/home/presentations/widgets/user_info_widget.dart';
import '../../../gen/assets.gen.dart';
import '../../../helpers/ui_helpers.dart';
import '../../../networks/api_acess.dart';

class TrainerHomeScreen extends StatefulWidget {
  const TrainerHomeScreen({super.key});

  @override
  State<TrainerHomeScreen> createState() => _TrainerHomeScreenState();
}

class _TrainerHomeScreenState extends State<TrainerHomeScreen> {
  @override
  void initState() {
    getProfileDetailsRXObj.getprofileDetails();
    getTrainerAllServicesRXObj.getAllServices();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(16.sp),
        physics: const BouncingScrollPhysics(),
        children: [
          UIHelper.verticalSpaceMedium,

          // Home Profile Information
          _buildTrainerProfile(),
          UIHelper.verticalSpaceMedium,

          // Search Text Filed
          // CustomTextFormField(
          //   hintText: 'SEARCH FITNESS TRAINER...',
          //   isPrefixIcon: true,
          //   iconpath: Assets.icons.search,
          // ),
          UIHelper.verticalSpaceMediumLarge,

          // Trainer Servicce Data
          Text('MY SERVICE', style: TextFontStyle.headline16StyleCabin700),

          _buildDisplayService(),
          UIHelper.verticalSpaceSmall,

          // Add service Button
          AppCustomeButton(
              isIcon: true,
              name: 'ADD YOUR SERVICE',
              onCallBack: () {
                NavigationService.navigateTo(Routes.addService);
              },
              height: 54.h,
              minWidth: double.infinity,
              borderRadius: 40.r,
              color: AppColors.c1C1C1C,
              textStyle: TextFontStyle.headline16StyleCabin700,
              context: context),
          UIHelper.verticalSpaceLarge,
          UIHelper.verticalSpaceLarge,
        ],
      ),
    );
  }

  StreamBuilder<AllServiceResponse> _buildDisplayService() {
    return StreamBuilder(
        stream: getTrainerAllServicesRXObj.dataFetcher,
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
                  var service = data[index];
                  return ReadyToHuntCard(
                    serviceData: service,
                    onTap: () async {
                      // await getServiceDetailsRXObj
                      //     .getServiceDetails(service.id!);
                      // await getAvailableServiceRXObj
                      //     .getAvailableService(service.id!);
                      NavigationService.navigateToWithObject(
                          Routes.serviceDetails, service.id);
                    },
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    image: service.images!.first.image!,
                    width: 253.w,
                  );
                },
              );
            } else {
              return Image.asset(Assets.images.amico.path);
            }
          } else {
            return Center(
              child: loadingIndicatorCircle(context: context),
            );
          }
        });
  }

  StreamBuilder<ProfileDetailsModel> _buildTrainerProfile() {
    return StreamBuilder(
        stream: getProfileDetailsRXObj.dataFetcher,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var profile = snapshot.data!;
            return UserInfoSection(
              onTap: () {
                NavigationService.navigateTo(Routes.navigatonProfileScreen);
              },
              name: profile.data!.name,
              image: profile.data?.avatar,
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text(
                'NO DATA FOUND',
                style: TextFontStyle.authButton16StyleCabin,
              ),
            );
          } else {
            return Center(
              child: loadingIndicatorCircle(context: context),
            );
          }
        });
  }
}

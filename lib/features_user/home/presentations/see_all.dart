import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/common_wigdets/loading_indicators.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/features_trainer/home/model/all_service_model.dart';
import 'package:rawado/features_user/home/presentations/widgets/ready_to_hant_widget.dart';
import 'package:rawado/gen/colors.gen.dart';
import 'package:rawado/helpers/all_routes.dart';
import 'package:rawado/helpers/navigation_service.dart';
import 'package:rawado/networks/api_acess.dart';
import 'package:svg_flutter/svg.dart';

import '../../../common_wigdets/custom_appbar.dart';
import '../../../common_wigdets/no_data_found.dart';
import '../../../gen/assets.gen.dart';
import '../../../helpers/distance_calculator.dart';
import '../../../helpers/ui_helpers.dart';

class SeeAllScreen extends StatefulWidget {
  const SeeAllScreen({super.key});

  @override
  State<SeeAllScreen> createState() => _ManuallySearchScreenState();
}

class _ManuallySearchScreenState extends State<SeeAllScreen> {
  @override
  void initState() {
    super.initState();
    getCustomerAllServicesRXObj.getAllServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isLeading: true,
        title: 'TRAINER LIST',
      ),
      body: ListView(
        padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [UIHelper.verticalSpaceSmall, _buildServiceResultCard()],
      ),
    );
  }

  Widget _buildServiceResultCard() {
    return StreamBuilder(
        stream: getCustomerAllServicesRXObj.dataFetcher,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            var error = snapshot.error as AllServiceResponse;
            return Center(
              child: Text(
                'Error: ${error.message}',
                style: TextFontStyle.authButton16StyleCabin,
              ),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            var trainerList = snapshot.data!.data!.reversed.toList();

            return trainerList.isNotEmpty
                ? _buildTrainerList(trainerList)
                : const NotFoundWidget();
          } else {
            return Center(
              child: loadingIndicatorCircle(context: context),
            );
          }
        });
  }

  ListView _buildTrainerList(List<ServiceData> trainerList) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: trainerList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 16.sp),
            child: SearchResultCard(
              serviceData: trainerList[index],
              onTap: () {
                NavigationService.navigateToReplacementWithObj(
                    Routes.trainerDetails, trainerList[index]);
              },
            ),
          );
        });
  }
}

class SearchResultCard extends StatefulWidget {
  final VoidCallback? onTap;
  final ServiceData? serviceData;
  const SearchResultCard({
    super.key,
    this.onTap,
    this.serviceData,
  });

  @override
  State<SearchResultCard> createState() => _SearchResultCardState();
}

class _SearchResultCardState extends State<SearchResultCard> {
  double? distance = 0.0;

  @override
  void initState() {
    canculateDistance();
    super.initState();
  }

  void canculateDistance() async {
    distance = await calculateDistance(
        context,
        double.parse(widget.serviceData!.latitude!),
        double.parse(widget.serviceData!.longitude!));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: AppColors.c1C1C1C,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: 91.w,
                height: 94.h,
                child: ImageBannerWidget(
                  image: widget.serviceData!.images!.first.image!,
                  rating: double.parse(widget.serviceData!.totalRatingAverage!
                      .toStringAsFixed(1)),
                )),
            UIHelper.horizontalSpaceSmall,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NameSection(
                  name: widget.serviceData!.name,
                  type: widget.serviceData!.category!.name,
                  status: widget.serviceData!.status,
                ),
                UIHelper.verticalSpaceSmall,
                Row(
                  children: [
                    SvgPicture.asset(Assets.icons.location),
                    Text(
                      '${distance!.toStringAsFixed(2)} KM AWAY',
                      style: TextFontStyle.headline12StyleCabin500
                          .copyWith(color: AppColors.c5A5C5F),
                    )
                  ],
                ),
                UIHelper.verticalSpaceSmall,
                SizedBox(
                  width: 210.w,
                  child: Text(
                    textAlign: TextAlign.justify,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    widget.serviceData?.description ??
                        "12 YEARS EXPERIENCE AS A PERSONAL FITNESS TRAINER WORK...",
                    style: TextFontStyle.headline14StyleCabin
                        .copyWith(color: AppColors.cB0B0B0),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class NameSection extends StatelessWidget {
  final String? name;
  final String? type;
  final String? status;
  const NameSection({
    super.key,
    this.name,
    this.type,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            style: TextFontStyle.headline16StyleCabin700,
            text: name?.split(' ').first ?? 'N/A ',
            children: [
              TextSpan(
                text: ' ($type)',
                style: TextFontStyle.headline12StyleCabin
                    .copyWith(color: AppColors.purpleTheamColor),
              ),
            ],
          ),
        ),
        UIHelper.horizontalSpaceMedium,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 5,
              backgroundColor: AppColors.c36B37E,
            ),
            UIHelper.horizontalSpace(5),
            Text(
              status?.toUpperCase() ?? 'AVAILABLE',
              style: TextFontStyle.headline12StyleCabin
                  .copyWith(color: AppColors.cA7A7A7),
            )
          ],
        ),
      ],
    );
  }
}

class NoSearchResultWidget extends StatelessWidget {
  const NoSearchResultWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UIHelper.verticalSpace(130.h),
        SvgPicture.asset(Assets.icons.graySearch),
        UIHelper.verticalSpaceSmall,
        Text(
          'RECENT SEARCHES',
          style: TextFontStyle.headline16StyleCabin700,
          textAlign: TextAlign.center,
        ),
        UIHelper.verticalSpaceSmall,
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.sp),
            child: Text(
                "YOUR RECENT SEARCHES WILL APPEAR HERE, SO YOU CAN EASILY RUN YOUR FAVORITE SEARCHES",
                textAlign: TextAlign.center,
                style: TextFontStyle.headline14StyleCabin))
      ],
    );
  }
}

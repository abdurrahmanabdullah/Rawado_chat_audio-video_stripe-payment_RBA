// ignore_for_file: unnecessary_null_comparison
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/common_wigdets/custom_appbar.dart';
import 'package:rawado/common_wigdets/custom_container.dart';
import 'package:rawado/common_wigdets/loading_indicators.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/features_trainer/review/model/trainer_rating_response.dart';
import 'package:rawado/features_trainer/review/model/user_review_response.dart';
import 'package:rawado/gen/assets.gen.dart';
import 'package:rawado/gen/colors.gen.dart';
import 'package:rawado/helpers/toast.dart';
import 'package:rawado/helpers/ui_helpers.dart';
import 'package:svg_flutter/svg.dart';
import '../../../common_wigdets/no_data_found.dart';
import '../../../features_user/trainer_details/presentation/widgets/review_card_widget.dart';
import '../../../helpers/helper_methods.dart';
import '../../../networks/api_acess.dart';

class TrainerReviewScreen extends StatefulWidget {
  const TrainerReviewScreen({super.key});

  @override
  State<TrainerReviewScreen> createState() => _TrainerReviewScreenState();
}

class _TrainerReviewScreenState extends State<TrainerReviewScreen> {
  double rating = 0.0;

  final ScrollController scrollController = ScrollController();
  bool hasMoreData = true;
  int currentPage = 1;
  int totalPage = 1;
  List<ReviewData>? review;
  // Data? data;
  List<ReviewData>? filteredReviewData;

  bool isLoading = true;
  String? errorMessage;

  _loadMoreData() {
    if (currentPage < totalPage) {
      setState(() {
        isLoading = true;
        currentPage++;
      });
      _fetchCarData(page: currentPage);
    } else {
      ToastUtil.showShortToast('No More Data');
    }
  }

  _fetchCarData({int page = 1}) async {
    log('pagination call');
    setState(() {
      isLoading = true;
    });

    try {
      UserReviewResponse? response = await getUserReviewRXObj.userReview(page);
      if (response != null && response.status == true) {
        List<ReviewData> reviewData = response.data?.data ?? [];
        setState(() {
          if (page == 1) {
            // review = reviewData;
            filteredReviewData = reviewData;
            // data = response.data;
          } else {
            // review?.addAll(reviewData);
            filteredReviewData?.addAll(reviewData);
          }
          isLoading = false;
          totalPage = response.data?.lastPage ?? 1;
        });
      } else {
        setState(() {
          errorMessage = response.message ?? 'Failed to load data';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _fetchCarData(page: currentPage);

    // scrollController.addListener(() {
    //   if (scrollController.position.pixels ==
    //           scrollController.position.maxScrollExtent &&
    //       !isLoading &&
    //       hasMoreData) {
    //     _loadMoreData();
    //   }
    // });

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoading &&
          hasMoreData) {
        ToastUtil.showShortToast('Loading');
        _loadMoreData();
      }
    });

    getTrainerRatingRXObj.trainerRating();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'REVIEW',
        centerTitle: false,
      ),
      body: ListView(
        controller: scrollController,
        padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          ///..................................All Rating Analysis
          StreamBuilder<TrainerRatingResponse>(
              stream: getTrainerRatingRXObj.dataFetcher,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Something Wants Wrong'.toUpperCase(),
                      style: TextFontStyle.authButton16StyleCabin,
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data != null) {
                  var ratings = snapshot.data!.data!;

                  ///....................  Rating Analysis
                  return CustomContainer(
                    child: TotalRatingWidget(ratings: ratings),
                  );
                } else {
                  return Center(
                    child: loadingIndicatorCircle(context: context),
                  );
                }
              }),
          UIHelper.verticalSpaceMediumLarge,

          // User Review
          Text('USER REVIEW', style: TextFontStyle.headline16StyleCabin700),
          UIHelper.verticalSpace(24.h),
          _buildReviewSection(scrollController, filteredReviewData ?? [])
        ],
      ),
    );
  }
}

class TotalRatingWidget extends StatelessWidget {
  const TotalRatingWidget({
    super.key,
    required this.ratings,
  });

  final RatingData ratings;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///......... Total Rating
        TotalReviewsWidet(ratings: ratings),

        //....... Total Review From User
        Text(
            textAlign: TextAlign.center,
            'TOTAL REVIEE ${ratings.total} USERS',
            style: TextFontStyle.headline14StyleCabin500
                .copyWith(color: AppColors.cD7D7D7)),
        UIHelper.verticalSpace(24.h),

        ///............... Rating Bar
        TotalRatingBar(ratings: ratings),

        ///................ Ratting Progress Bar For Each Ration
        RattingProgressBar(
          label: '5',
          value: ratings.data!["5"]! / 100,
          percentage: ratings.data!["5"]!,
        ),
        RattingProgressBar(
          label: '4',
          value: ratings.data!["4"]! / 100,
          percentage: ratings.data!["4"]!,
        ),
        RattingProgressBar(
          label: '3',
          value: ratings.data!["3"]! / 100,
          percentage: ratings.data!["3"]!,
        ),
        RattingProgressBar(
          label: '2',
          value: ratings.data!["2"]! / 100,
          percentage: ratings.data!["2"]!,
        ),
        RattingProgressBar(
          label: '1',
          value: ratings.data!["1"]! / 100,
          percentage: ratings.data!["1"]!,
        ),
      ],
    );
  }
}

class TotalRatingBar extends StatelessWidget {
  const TotalRatingBar({
    super.key,
    required this.ratings,
  });

  final RatingData ratings;

  @override
  Widget build(BuildContext context) {
    return PannableRatingBar(
      rate: ratings.average ?? 0.0,
      items: List.generate(
          5,
          (index) => RatingWidget(
                selectedColor: appColor(),
                unSelectedColor: AppColors.cA7A7A7,
                child: const Icon(
                  Icons.star,
                  size: 40,
                ),
              )),
      onChanged: (value) {},
    );
  }
}

class TotalReviewsWidet extends StatelessWidget {
  const TotalReviewsWidet({
    super.key,
    required this.ratings,
  });

  final RatingData ratings;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: ratings.average?.toStringAsFixed(1) ?? '0.0',
            style: TextFontStyle.headline28StyleCabin700
                .copyWith(color: appColor()),
            children: [
          TextSpan(
            text: '/',
            style: TextFontStyle.headline28StyleCabin700
                .copyWith(color: AppColors.cA7A7A7),
          ),
          TextSpan(
            text: '5',
            style: TextFontStyle.headline16StyleCabin500
                .copyWith(color: AppColors.cA7A7A7),
          ),
        ]));
  }
}

Widget _buildReviewSection(
    ScrollController scrollController, List<ReviewData> filteredReviewData) {
  if (filteredReviewData.isEmpty) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NotFoundWidget(),
        ],
      ),
    );
  } else {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: filteredReviewData.length,
        itemBuilder: (context, index) {
          var review = filteredReviewData[index];

          return Padding(
              padding: EdgeInsets.only(bottom: 16.sp),
              child: ReviewCardWidget(
                image: review.user!.avatar,
                userName: review.user!.name,
                rating: double.parse(review.rating.toString()),
                reviewText: review.message,
                createdtime: review.createdAt,
              ));
        });
  }
}

class RattingProgressBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;
  const RattingProgressBar({
    super.key,
    required this.label,
    required this.value,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          SvgPicture.asset(Assets.images.star),
          UIHelper.horizontalSpace(8.w),
          Text(
            label,
            style: TextFontStyle.headline14StyleCabin500
                .copyWith(color: AppColors.cA7A7A7),
          ),
          UIHelper.horizontalSpace(8.w),
          Expanded(
            child: LinearProgressIndicator(
              borderRadius: BorderRadius.circular(3.w),
              value: value,
              backgroundColor: AppColors.cA7A7A7,
              color: appColor(),
              minHeight: 8.h,
            ),
          ),
          UIHelper.horizontalSpace(8.w),
          Text(
            '${percentage.toStringAsFixed(1)}%',
            style: TextFontStyle.headline14StyleCabin500
                .copyWith(color: AppColors.cA7A7A7),
          ),
        ],
      ),
    );
  }
}

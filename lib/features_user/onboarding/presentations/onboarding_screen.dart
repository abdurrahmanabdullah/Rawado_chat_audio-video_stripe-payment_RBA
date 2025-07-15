import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rawado/helpers/helper_methods.dart';
import 'package:rawado/helpers/ui_helpers.dart';

import '../../../gen/colors.gen.dart';
import '../../../provider/onboarding_provider.dart';
import 'widget/bottom_button.dart';
import 'widget/onboarding_data.dart';

// List of data for onboarding screens
final List<OnboardingData> data = [
  OnboardingData(
    child: const WorkoutWidget(),
    backgroundColor: AppColors.scaffoldColor,
  ),
  OnboardingData(
    child: const LanguageSelect(),
    backgroundColor: AppColors.scaffoldColor,
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OnboardingProvider>(
        builder: (context, provider, child) {
          return buildOnboardingScreen(provider);
        },
      ),
    );
  }

  // Builds the main structure of the onboarding screen
  Widget buildOnboardingScreen(OnboardingProvider provider) {
    return Container(
      color: data[provider.currentIndex].backgroundColor,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 16.h,
          ),
          color: data[provider.currentIndex].backgroundColor,
          // alignment: Alignment.center,
          child: Column(
            children: [
              Expanded(
                flex: 8,
                child: buildPageView(provider),
              ),
              UIHelper.verticalSpaceMedium,
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildCircleRow(provider),
                      UIHelper.verticalSpaceMedium,
                      BottomButtons(
                        currentIndex: provider.currentIndex,
                        dataLength: data.length,
                        controller: _controller,
                      ),
                      UIHelper.verticalSpaceMedium,
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Builds the PageView displaying onboarding screens
  Widget buildPageView(OnboardingProvider provider) {
    return Container(
      alignment: Alignment.center,
      child: PageView(
        scrollDirection: Axis.horizontal,
        controller: _controller,
        onPageChanged: (value) {
          provider.setCurrentIndex(value);
        },
        children: data.map((e) => OnboardingDataWidgets(data: e)).toList(),
      ),
    );
  }

  // Builds the row of circles indicating current page
  Widget buildCircleRow(OnboardingProvider provider) {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          data.length,
          (index) =>
              createCircle(index: index, currentIndex: provider.currentIndex),
        ),
      ),
    );
  }

  // Creates a single circle indicator
  Widget createCircle({required int index, required int currentIndex}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.sp),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: 8.sp,
        width: currentIndex == index ? 23.h : 8.h,
        decoration: BoxDecoration(
          color: currentIndex == index ? appColor() : AppColors.c3C3B3B,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}

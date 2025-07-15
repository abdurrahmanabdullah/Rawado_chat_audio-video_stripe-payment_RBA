// ignore_for_file: unused_field, deprecated_member_use
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/features_user/massage/presentation/massage_screen.dart';
import 'package:rawado/features_trainer/home/presentation/trainer_home_screen.dart';
import 'package:rawado/features_trainer/profile/presentation/trainer_profile_screen.dart';
import 'package:rawado/features_trainer/schedule/presentation/trainer_schedule_screen.dart';
import 'package:svg_flutter/svg.dart';

import '/constants/text_font_style.dart';
import '/gen/assets.gen.dart';
import 'gen/colors.gen.dart';
import 'helpers/helper_methods.dart';

final class TrainerNavigationScreen extends StatefulWidget {
  final Widget? pageNum;
  const TrainerNavigationScreen({
    super.key,
    this.pageNum,
  });

  @override
  State<TrainerNavigationScreen> createState() =>
      _TrainerNavigationScreenState();
}

class _TrainerNavigationScreenState extends State<TrainerNavigationScreen> {
  // final appData = GetStorage();
  //Variable for navigation Index
  int _currentIndex = 0;
  //Variable for navigation Color Index
  int _colorIndex = 0;

  final bool _isFisrtBuild = true;
  bool _navigationOn = true;
  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final List<StatefulWidget> _screens = [
    const TrainerHomeScreen(),
    const ChatScreen(),
    const TrainerScheduleScreen(),
    const TrainerProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Object? args;
    StatefulWidget? screenPage;
    if (_isFisrtBuild) {
      args = ModalRoute.of(context)!.settings.arguments;
    }
    if (args != null) {
      _colorIndex = 5;
      screenPage = args as StatefulWidget;
      var newColorindex = -1;

      for (var element in _screens) {
        newColorindex++;
        if (element.toString() == screenPage.toString()) {
          _colorIndex = newColorindex;
          _currentIndex = newColorindex;
          break;
        }
      }
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        showMaterialDialog(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        extendBody: true,
        onDrawerChanged: (isOpened) => setState(() {
          _navigationOn = !isOpened;
        }),
        body: Center(
            child: (screenPage != null)
                ? screenPage
                : _screens.elementAt(_currentIndex)),
        bottomNavigationBar: SizedBox(
          height: 60.h,
          child: CustomNavigationBar(
            iconSize: 50.r,
            selectedColor: appColor(),
            strokeColor: appColor(),
            unSelectedColor: Colors.black,
            backgroundColor: AppColors.c222222,
            items: [
              CustomNavigationBarItem(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    (_currentIndex == 0)
                        ? Image.asset(Assets.icons.purpleCircleIcon.path,
                            color: appColor())
                        : const SizedBox.shrink(),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.icons.home,
                            color: (_currentIndex == 0)
                                ? AppColors.white
                                : AppColors.cA8A8A8,
                          ),
                          Text("HOME",
                              style:
                                  TextFontStyle.headline10StyleCabin.copyWith(
                                color: (_currentIndex == 0)
                                    ? AppColors.white
                                    : AppColors.cA8A8A8,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // CustomNavigationBarItem(
              //     icon: Stack(
              //   clipBehavior: Clip.none,
              //   children: [
              //     (_currentIndex == 1)
              //         ? Image.asset(Assets.icons.purpleCircleIcon.path,
              //             color: appColor())
              //         : const SizedBox.shrink(),
              //     Center(
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           SvgPicture.asset(
              //             Assets.icons.anim,
              //             color: (_currentIndex == 1)
              //                 ? AppColors.white
              //                 : AppColors.cA8A8A8,
              //           ),
              //           Text("SEARCH",
              //               style: TextFontStyle.headline10StyleCabin.copyWith(
              //                 color: (_currentIndex == 1)
              //                     ? AppColors.white
              //                     : AppColors.cA8A8A8,
              //               )),
              //         ],
              //       ),
              //     ),
              //   ],
              // )),
              CustomNavigationBarItem(
                  icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  (_currentIndex == 1)
                      ? Image.asset(Assets.icons.purpleCircleIcon.path,
                          color: appColor())
                      : const SizedBox.shrink(),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Assets.icons.messageText,
                          color: (_currentIndex == 1)
                              ? AppColors.white
                              : AppColors.cA8A8A8,
                        ),
                        Text(
                          "CHAT",
                          style: TextFontStyle.headline10StyleCabin.copyWith(
                            color: (_currentIndex == 1)
                                ? AppColors.white
                                : AppColors.cA8A8A8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              CustomNavigationBarItem(
                  icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  (_currentIndex == 2)
                      ? Image.asset(Assets.icons.purpleCircleIcon.path,
                          color: appColor())
                      : const SizedBox.shrink(),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          Assets.icons.calendar,
                          color: (_currentIndex == 2)
                              ? AppColors.white
                              : AppColors.cA8A8A8,
                        ),
                        Text(
                          "SCHEDULE",
                          style: TextFontStyle.headline10StyleCabin.copyWith(
                            color: (_currentIndex == 2)
                                ? AppColors.white
                                : AppColors.cA8A8A8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              CustomNavigationBarItem(
                  icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  (_currentIndex == 3)
                      ? Image.asset(Assets.icons.purpleCircleIcon.path,
                          color: appColor())
                      : const SizedBox.shrink(),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Assets.icons.profile,
                          color: (_currentIndex == 3)
                              ? AppColors.white
                              : AppColors.cA8A8A8,
                        ),
                        Text(
                          "PROFILE",
                          style: TextFontStyle.headline10StyleCabin.copyWith(
                            color: (_currentIndex == 3)
                                ? AppColors.white
                                : AppColors.cA8A8A8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ],
            currentIndex: _currentIndex,
            onTap: (index) {
              // if (appData.read(kKeyIsLoggedIn) || index == 1 || index == 0) {
              // if (index == 1) {
              //   context.read<SelectedSubCat>().selectedSubCatIDClear();
              // }

              setState(() {
                _currentIndex = index;
              });
              // } else {
              //   ToastUtil.showLongToast("You need to log in first");
              // }
            },
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/common_wigdets/custom_appbar.dart';
import 'package:rawado/common_wigdets/custom_container.dart';
import 'package:rawado/common_wigdets/loading_indicators.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/gen/assets.gen.dart';
import 'package:rawado/gen/colors.gen.dart';
import 'package:rawado/helpers/ui_helpers.dart';
import 'package:svg_flutter/svg.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../common_wigdets/auth_button.dart';
import '../../../common_wigdets/no_data_found.dart';
import '../../../helpers/helper_methods.dart';
import '../../../networks/api_acess.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    getNotificationRxObj.getNotificationData();
    super.initState();
  }

  Map<String, List<dynamic>> groupNotifications(List<dynamic> notifications) {
    final Map<String, List<dynamic>> groupedNotifications = {};

    for (var notification in notifications) {
      DateTime createdAt =
          DateTime.tryParse(notification["created_at"]) ?? DateTime.now();
      String groupKey;

      final today = DateTime.now();
      final yesterday = today.subtract(const Duration(days: 1));

      if (createdAt.year == today.year &&
          createdAt.month == today.month &&
          createdAt.day == today.day) {
        groupKey = "TODAY";
      } else if (createdAt.year == yesterday.year &&
          createdAt.month == yesterday.month &&
          createdAt.day == yesterday.day) {
        groupKey = "YESTERDAY";
      } else {
        groupKey = "${createdAt.day}/${createdAt.month}/${createdAt.year}";
      }

      if (groupedNotifications[groupKey] == null) {
        groupedNotifications[groupKey] = [];
      }
      groupedNotifications[groupKey]!.add(notification);
    }

    return groupedNotifications;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'NOTIFICATION',
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
          child: StreamBuilder(
            stream: getNotificationRxObj.getNotification,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong'),
                );
              } else if (snapshot.hasData) {
                dynamic data = snapshot.data!["data"] as List;
                final groupedData = groupNotifications(data);

                if (groupedData.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: NotFoundWidget(),
                  );
                }
                return Column(
                  children: groupedData.entries.map((entry) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          entry.key,
                          style: TextFontStyle.headline12StyleRoboto,
                          textAlign: TextAlign.center,
                        ),
                        UIHelper.verticalSpaceMedium,
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: entry.value.length,
                          itemBuilder: (context, index) {
                            var notification = entry.value[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: NotificationCardWidget(
                                date: DateTime.tryParse(
                                    notification["created_at"]),
                                text: notification["data"]["message"],
                                id: notification["data"]["id"],
                              ),
                            );
                          },
                        ),
                        UIHelper.verticalSpaceMedium,
                      ],
                    );
                  }).toList(),
                );
              } else {
                return Center(
                  child: loadingIndicatorCircle(context: context),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class NotificationCardWidget extends StatelessWidget {
  final String? text;
  final DateTime? date;
  final String id;
  const NotificationCardWidget({
    super.key,
    this.text,
    this.date,
    this.id = '0',
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.r,
            backgroundColor: AppColors.c5A5C5F,
            child: SvgPicture.asset(
              Assets.icons.notification,
              color: appColor(),
            ),
          ),
          UIHelper.horizontalSpaceMedium,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 230,
                    child: Text(
                      // overflow: TextOverflow.ellipsis,
                      // maxLines: 2,
                      text ??
                          'YOU GOT A NEW BOOKING REQUEST YOU GOT A NEW BOOKING REQUEST',
                      style: TextFontStyle.headline12StyleRoboto
                          .copyWith(color: AppColors.cCFCFCF),
                    ),
                  ),
                  Text(
                    timeago.format(date ?? DateTime.now()),
                    style: TextFontStyle.headline12StyleRoboto
                        .copyWith(color: appColor()),
                  ),
                ],
              ),
              id != '0'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'COMPLETE SESION',
                          style: TextFontStyle.headline12StyleRoboto
                              .copyWith(color: AppColors.cCFCFCF),
                        ),
                        UIHelper.horizontalSpaceMedium,
                        AppCustomeButton(
                            name: 'ACEPTE',
                            onCallBack: () async {
                              await postUserSessionCompleteActionRXObj
                                  .completeSession(int.parse(id));
                            },
                            height: 30.h,
                            minWidth: 60.w,
                            borderRadius: 8.r,
                            color: appColor(),
                            textStyle: TextFontStyle.headline12StyleRoboto
                                .copyWith(color: AppColors.cCFCFCF),
                            context: context),
                      ],
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}































// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:rawado/common_wigdets/custom_appbar.dart';
// import 'package:rawado/common_wigdets/custom_container.dart';
// import 'package:rawado/common_wigdets/loading_indicators.dart';
// import 'package:rawado/constants/text_font_style.dart';
// import 'package:rawado/gen/assets.gen.dart';
// import 'package:rawado/gen/colors.gen.dart';
// import 'package:rawado/helpers/ui_helpers.dart';
// import 'package:svg_flutter/svg.dart';
// import '../../../helpers/helper_methods.dart';
// import '../../../networks/api_acess.dart';
// import 'package:timeago/timeago.dart' as timeago;

// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});

//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   @override
//   void initState() {
//     getNotificationRxObj.getNotificationData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(
//         title: 'NOTIFICATION',
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
//           child: Column(
//             // padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
//             children: [
//               Text(
//                 'TODAY',
//                 style: TextFontStyle.headline12StyleRoboto,
//               ),
//               UIHelper.verticalSpaceMedium,
//               StreamBuilder(
//                   stream: getNotificationRxObj.getNotification,
//                   builder: (context, snapshot) {
//                     if (snapshot.hasError) {
//                       return const Center(
//                         child: Text('Something want wrong'),
//                       );
//                     } else if (snapshot.hasData) {
//                       dynamic data = snapshot.data!["data"] as List;
//                       return ListView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: data.length,
//                           itemBuilder: (context, index) {
//                             var notification = data[index];
//                             return NotificationCardWidget(
//                               date:
//                                   DateTime.tryParse(notification["created_at"]),
//                               text: notification["data"]["message"],
//                             );
//                           });
//                     } else {
//                       return Center(
//                         child: loadingIndicatorCircle(context: context),
//                       );
//                     }
//                   }),
//               UIHelper.verticalSpaceMedium,
//               // const NotificationCardWidget(),
//               // UIHelper.verticalSpaceMedium,
//               // Text(
//               //   'YESTERDAY',
//               //   style: TextFontStyle.headline12StyleRoboto,
//               // ),
//               // UIHelper.verticalSpaceMedium,
//               // const NotificationCardWidget(),
//               // UIHelper.verticalSpaceMedium,
//               // const NotificationCardWidget()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class NotificationCardWidget extends StatelessWidget {
//   final String? text;
//   final DateTime? date;
//   const NotificationCardWidget({
//     super.key,
//     this.text,
//     this.date,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CustomContainer(
//       child: Row(
//         children: [
//           CircleAvatar(
//               radius: 25.r,
//               backgroundColor: AppColors.c5A5C5F,
//               child: SvgPicture.asset(Assets.icons.notification)),
//           UIHelper.horizontalSpaceMedium,
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 text ?? 'YOU GOT A NEW BOOKING REUEST',
//                 style: TextFontStyle.headline12StyleRoboto
//                     .copyWith(color: AppColors.cCFCFCF),
//               ),
//               Text(
//                 timeago.format(date ?? DateTime.now()),

//                 // '2 SECOND AGO',
//                 style: TextFontStyle.headline12StyleRoboto
//                     .copyWith(color: appColor()),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

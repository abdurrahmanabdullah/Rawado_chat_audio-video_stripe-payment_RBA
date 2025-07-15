import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rawado/common_wigdets/custom_appbar.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/features_user/massage/model/message_list_response.dart';
import 'package:rawado/gen/assets.gen.dart';
import 'package:rawado/gen/colors.gen.dart';
import 'package:rawado/helpers/all_routes.dart';
import 'package:rawado/helpers/navigation_service.dart';
import 'package:rawado/helpers/ui_helpers.dart';
import 'package:rawado/networks/api_acess.dart';
import '../../../common_wigdets/custom_textfiled.dart';
import '../../../common_wigdets/loading_indicators.dart';
import '../../../helpers/helper_methods.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController searchController = TextEditingController();

  List<MessageList> filterMessageList = [];
  List<MessageList> messageList = [];

  @override
  void initState() {
    getMessageListRXObj.getMessageList();
    searchController.addListener(_sinkLatestValue);

    super.initState();
  }

  _sinkLatestValue() {
    setState(() {
      if (searchController.text.isEmpty) {
        filterMessageList = messageList;
      } else {
        filterMessageList = messageList
            .where((message) =>
                message.user!.name
                    ?.toLowerCase()
                    .contains(searchController.text.toLowerCase()) ??
                false)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'CHAT',
        centerTitle: true,
        isLeading: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
        children: [
          // Search Text Filed
          CustomTextFormField(
            controller: searchController,
            hintText: 'SEARCH',
            isPrefixIcon: true,
            iconpath: Assets.icons.search,
          ),
          UIHelper.verticalSpace(20.h),
          // SizedBox(
          //   height: 100.h,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     shrinkWrap: true,
          //     itemCount: 10,
          //     itemBuilder: (context, index) {
          //       return const MassageClipWidget();
          //     },
          //   ),
          // ),
          StreamBuilder<MessageListResponse>(
              stream: getMessageListRXObj.dataFetcher,
              // stream: getMessageListRXObj.dataFetcher,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString(),
                        style: TextFontStyle.headline16StyleCabin700),
                  );
                } else if (snapshot.hasData && snapshot.data != null) {
                  messageList = snapshot.data!.data!;
                  filterMessageList = searchController.text.isEmpty
                      ? messageList
                      : messageList
                          .where((message) =>
                              message.user!.name?.toLowerCase().contains(
                                  searchController.text.toLowerCase()) ??
                              false)
                          .toList();

                  if (filterMessageList.isEmpty) {
                    return Center(
                      child: Text('NO CONNECTION FOUND',
                          style: TextFontStyle.headline16StyleCabin700),
                    );
                  }

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: filterMessageList.length,
                    itemBuilder: (context, index) {
                      return MassageCardWidget(
                        message: filterMessageList[index].lastMessage!.text,
                        time: filterMessageList[index].lastMessage!.createdAt!,
                        imageUrl: filterMessageList[index].user!.avatar,
                        name: filterMessageList[index].user!.name,
                        onTap: () => NavigationService.navigateToWithArgs(
                            Routes.massageInbox, {
                          "id": filterMessageList[index].user!.id,
                          "name": filterMessageList[index].user!.name,
                          "image": filterMessageList[index].user!.avatar
                        }),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: loadingIndicatorCircle(context: context),
                  );
                }
              })
        ],
      ),
    );
  }
}

class MassageCardWidget extends StatelessWidget {
  final String? name;
  final DateTime? time;
  final String? message;
  final String? imageUrl;
  final VoidCallback? onTap;
  const MassageCardWidget({
    super.key,
    this.onTap,
    this.name,
    this.time,
    this.message,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    String formatDateTime(DateTime dateTime) {
      try {
        // // Parse the string into a DateTime object
        // DateTime dateTime =
        //     DateTime.parse(dateTimeStr).toLocal(); // Convert to local timezone

        // Format the day of the week
        String day = DateFormat.EEEE().format(dateTime).toUpperCase();

        // Format the time as "h:m a"
        String time = DateFormat('h:m a').format(dateTime);

        // Combine day and time
        return "$day $time";
      } catch (e) {
        // Handle parsing errors or invalid formats
        return "Invalid Date";
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 27.h),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                      radius: 30.r,
                      child: imageUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(30.r),
                              child: CachedNetworkImage(
                                height: 60.h,
                                width: 60.w,
                                imageUrl: imageUrl!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    shimmer(context: context),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.error,
                                  color: Colors.redAccent,
                                  size: 25.sp,
                                ),
                              ),
                            )
                          : Image.asset(Assets.images.cahtProfile.path)),
                  Positioned(
                      bottom: 3.sp,
                      right: 3.sp,
                      child: CircleAvatar(
                        radius: 5.r,
                        backgroundColor: AppColors.c36B37E,
                      ))
                ],
              ),
              UIHelper.horizontalSpaceSmall,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          name?.split(' ').first ?? 'EVEN DEO',
                          style: TextFontStyle.headline16StyleCabin500,
                        ),
                      ),
                      UIHelper.horizontalSpace(50.w),
                      Text(
                        formatDateTime(time!),
                        style: TextFontStyle.headline12StyleCabin,
                      )
                    ],
                  ),
                  UIHelper.verticalSpaceMedium,
                  SizedBox(
                      width: 260.w,
                      child: Text(message ?? '',
                          style: TextFontStyle.headline12StyleCabin
                              .copyWith(color: AppColors.cA7A7A7)))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MassageClipWidget extends StatelessWidget {
  const MassageClipWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Column(
        children: [
          CircleAvatar(
            radius: 25.r,
            backgroundColor: appColor(),
            child: CircleAvatar(
              radius: 23.r,
              backgroundColor: AppColors.c000000,
              child: CircleAvatar(
                  radius: 21.r,
                  child: Image.asset(Assets.images.cahtProfile.path)),
            ),
          ),
          UIHelper.verticalSpace(4.h),
          SizedBox(
            width: 60,
            child: Text('RAWADO',
                style: TextFontStyle.headline12StyleCabin
                    .copyWith(color: AppColors.cD7D7D7)),
          )
        ],
      ),
    );
  }
}

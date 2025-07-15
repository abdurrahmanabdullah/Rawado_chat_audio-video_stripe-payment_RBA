import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rawado/common_wigdets/loading_indicators.dart';
import 'package:rawado/gen/colors.gen.dart';
import 'package:rawado/helpers/helper_methods.dart';
import 'package:rawado/networks/api_acess.dart';
import 'package:svg_flutter/svg.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/text_font_style.dart';
import '../../../gen/assets.gen.dart';
import '../../../helpers/di.dart';
import '../../../helpers/navigation_service.dart';
import '../../../helpers/ui_helpers.dart';

class MassageInboxScreen extends StatefulWidget {
  final int? id;
  final String? name;
  final String? image;

  const MassageInboxScreen({super.key, this.id, this.name, this.image});

  @override
  State<MassageInboxScreen> createState() => _MassageInboxScreenState();
}

class _MassageInboxScreenState extends State<MassageInboxScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Message> messages = [
    Message(content: "HI ALVIN, GOOD MORNING!!", isSent: true, time: "06:01"),
    Message(
        content: "HALO! GOOD MORNING, WHATS UP MAN?",
        isSent: false,
        time: "06:02"),
    Message(content: "I HAVE SOME MEETING NOW", isSent: true, time: "06:03"),
    Message(
        content: "OH, BUSY DAY HUH? HOPE IT GOES WELL!",
        isSent: false,
        time: "06:04"),
    Message(
        content: "SORRY TO BOTHER, CAN I ASK YOU FOR A HELP TODAY?",
        isSent: true,
        time: "06:05"),
  ];
  int? messageRoomId;

  late PusherChannelsClient client;
  String userToken = appData.read(kKeyAccessToken);
  //late PusherChannel channel;
  // List<String> messages = [];
  StreamSubscription? connectionSubs;
  StreamSubscription<ChannelReadEvent>? somePrivateChannelEventSubs;
  late ScrollController _scrollController;

  void connect() async {
    log('is recivider ${widget.id}');
    log('is sender ${appData.read(kKeyUserID)}');
    const hostOptions = PusherChannelsOptions.fromHost(
      scheme: 'wss',
      host: 'wegowolf.com',
      key: 'vcgilmwwqcmzsmuy9uiw',
      shouldSupplyMetadataQueries: true,
      metadata: PusherChannelsOptionsMetadata.byDefault(),
      port: 8081,
    );
    log(hostOptions.uri.toString());

    client = PusherChannelsClient.websocket(
      options: hostOptions,
      connectionErrorHandler: (exception, trace, refresh) async {
        log("Connection error: $exception", error: trace);
        refresh();
      },
    );

    // Fetch MEssaage Room ID
    Map data = await getMessageRoomRxObj.getMessageRoom(widget.id!);
    messageRoomId = data["data"]["id"];

    log('message room id: $messageRoomId');

    final myPrivateChannel = client.privateChannel(
      "private-chat.$messageRoomId",
      authorizationDelegate:
          EndpointAuthorizableChannelTokenAuthorizationDelegate
              .forPrivateChannel(
        authorizationEndpoint:
            Uri.parse("https://wegowolf.com/api/broadcasting/auth"),
        headers: {"Authorization": "Bearer $userToken"},
      ),
    );

    connectionSubs = client.onConnectionEstablished.listen((_) {
      log('connected to server');
      myPrivateChannel.subscribeIfNotUnsubscribed();
    });

    somePrivateChannelEventSubs =
        myPrivateChannel.bind('App\\Events\\MessageSent').listen((event) {
      try {
        log("Received data: =======");
        log("Event received: ${event.data}");

        // Decode the event data into a Map
        final Map<String, dynamic> messageData = json.decode(event.data);
        log("Parsed data: $messageData");

        // Safely access the nested 'message' key
        if (messageData.containsKey('message') &&
            messageData['message'] is Map) {
          final String messageText = messageData['message']['text'];
          log("Message text: $messageText");
          featchData();
          // Update the messages list and UI
          // setState(() {
          //   messages.add(messageText);
          // });
        } else {
          log("Error: 'message' key not found or is not a Map");
        }
      } catch (e, stackTrace) {
        log("Error processing event: $e");
        log("StackTrace: $stackTrace");
      }
    });

    client.connect();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    featchData();
    connect();
    // After the initial frame, scroll to the bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  void featchData() async {
    await getMessageRxObj.getMessageData(widget.id!);
    // Map data = await getMessageRoomRxObj.getMessageRoom(widget.id!);
    // messageRoomId = data["data"]["id"];
    // log('message room id: $messageRoomId');
  }

  @override
  void dispose() {
    connectionSubs?.cancel();
    somePrivateChannelEventSubs?.cancel();
    client.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: AppColors.c1C1C1C,
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: getMessageRxObj.getMessage,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    dynamic data = snapshot.data!["data"];

                    if (data.isNotEmpty) {
                      // Reverse the list to display the latest messages at the bottom
                      data = data.reversed.toList();

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent);
                      });
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 20.w),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final message = data[index];
                        // log("message sender id ${message["sender_id"]}");
                        // log("user id ${appData.read(kKeyUserID)}");
                        return MessageBuble(
                          message: message,
                          isSender: message["sender_id"].toString() ==
                              appData.read(kKeyUserID),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: loadingIndicatorCircle(context: context),
                    );
                  }
                }),
          ),
          UIHelper.verticalSpace(90.h)
        ],
      ),
      bottomSheet: Container(
        height: 80.h,
        color: AppColors.c222222,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                style: const TextStyle(color: AppColors.white),
                decoration: InputDecoration(
                  hintText: "WRITE YOUR MESSAGE",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                  filled: true,
                  fillColor: AppColors.c5A5C5F,
                  hintStyle: const TextStyle(color: AppColors.cCFCFCF),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      postSendMessageRxObj
                          .postMessage(
                              id: widget.id, content: _messageController.text)
                          .then((v) {
                        if (v) {
                          _messageController.clear();
                          featchData();
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _scrollController.jumpTo(
                                _scrollController.position.maxScrollExtent);
                          });
                        }
                      });
                    },
                    // onTap: () {
                    //   if (_messageController.text.isNotEmpty) {
                    //     setState(() {
                    //       messages.add(Message(
                    //         content: _messageController.text,
                    //         isSent: true,
                    //         time: TimeOfDay.now().format(context),
                    //       ));
                    //       _messageController.clear();
                    //     });
                    //   }
                    // },
                    child: Icon(
                      Icons.send,
                      color:
                          // _messageController.text.isNotEmpty
                          // ?
                          appColor(),
                      // : AppColors.cCFCFCF,
                      size: 24.sp,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: appColor(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 100.h,
      backgroundColor: AppColors.c1C1C1C,
      leading: Padding(
        padding: EdgeInsets.all(20.sp),
        child: GestureDetector(
          onTap: () => NavigationService.goBack,
          child: SvgPicture.asset(
            Assets.icons.backButton,
            height: 24.h,
          ),
        ),
      ),
      title: GestureDetector(
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.cCFCFCF,
              radius: 20.r,
              child: widget.image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(25.r),
                      child: CachedNetworkImage(
                        height: 40.h,
                        width: 40.h,
                        imageUrl: widget.image!,
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
                  : Image.asset(Assets.images.avator.path),
            ),
            UIHelper.horizontalSpaceSmall,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //NAME..
                Text(
                  widget.name!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                //ONLINE OR OFFLINE STATUS...
                // Row(
                //   children: [
                //     CircleAvatar(
                //       radius: 5.r,
                //       backgroundColor: AppColors.c36B37E,
                //     ),
                //     UIHelper.horizontalSpace(5.w),
                //     Text(
                //       'ONLINE',
                //       style: TextStyle(
                //         color: Colors.greenAccent,
                //         fontSize: 12.sp,
                //         fontWeight: FontWeight.w400,
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBuble extends StatelessWidget {
  const MessageBuble({
    super.key,
    required this.message,
    required this.isSender,
  });

  final Map message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    log('is sender $isSender');
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        constraints: BoxConstraints(maxWidth: 270.w),
        decoration: BoxDecoration(
            color: isSender ? appColor() : AppColors.c222222,
            borderRadius: BorderRadius.circular(12.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message["text"],
                style: TextFontStyle.headline14StyleCabin500.copyWith(
                  color: isSender ? appTextColor() : AppColors.cCFCFCF,
                )),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment:
                  isSender ? MainAxisAlignment.end : MainAxisAlignment.end,
              children: [
                Align(
                  child: Text(
                      DateFormat('hh:mm')
                          .format(DateTime.parse(message["created_at"])),
                      style: TextFontStyle.headline12StyleCabin500.copyWith(
                        color: isSender ? AppColors.c222222 : AppColors.cCFCFCF,
                      )),
                ),
                if (isSender)
                  Row(
                    children: [
                      UIHelper.horizontalSpace(5.w),
                      Icon(
                        Icons.done_all,
                        color: AppColors.c222222,
                        size: 16.sp,
                      ),
                    ],
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  final String content;
  final bool isSent;
  final String time;

  Message({
    required this.content,
    required this.isSent,
    required this.time,
  });
}

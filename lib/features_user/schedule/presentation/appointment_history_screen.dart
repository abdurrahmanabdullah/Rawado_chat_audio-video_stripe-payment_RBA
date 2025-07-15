import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rawado/common_wigdets/custom_appbar.dart';

import '../../../common_wigdets/loading_indicators.dart';
import '../../../common_wigdets/no_data_found.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/navigation_service.dart';
import '../../../helpers/ui_helpers.dart';
import '../../../networks/api_acess.dart';
import 're_schedule_screen.dart';

class AppointmentHistoryScreen extends StatefulWidget {
  const AppointmentHistoryScreen({super.key});

  @override
  State<AppointmentHistoryScreen> createState() =>
      _AppointmentHistoryScreenState();
}

class _AppointmentHistoryScreenState extends State<AppointmentHistoryScreen> {
  @override
  void initState() {
    getBookingHistoryRXObj.getBookingHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'APPOINTMENT HISTORY',
        centerTitle: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
              stream: getBookingHistoryRXObj.dataFetcher,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  var response = snapshot.data!;
                  var data = response.data!;
                  if (data.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var historyData = data[index];
                          return Padding(
                            padding:
                                EdgeInsets.all(UIHelper.kDefaulutPadding()),
                            child: ReScheduleWidget(
                              time:
                                  '${historyData.startTime} - ${historyData.endTime}',
                              date: DateFormat('yyyy-MM-dd')
                                  .format(historyData.dateFull!),
                              trainerName:
                                  historyData.service?.name?.toUpperCase(),
                              location: historyData.location?.toUpperCase(),
                              // service: historyData.service.,
                              status: historyData.status?.toUpperCase(),
                              buttonName: 'RATE THIS SERVICE',
                              onTap: () {
                                log('onTap');
                                NavigationService.navigateToReplacementWithObj(
                                    Routes.reviewScreen,
                                    historyData.service?.id);
                              },
                            ),
                          );
                        },
                        itemCount: data.length,
                      ),
                    );
                  } else {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NotFoundWidget(),
                        ],
                      ),
                    );

                    //  Center(
                    //   child: Text(
                    //     'HISTORY NOT AVAILABLE',
                    //     style: TextFontStyle.headline16StyleCabin700,
                    //   ),
                    // );
                  }
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

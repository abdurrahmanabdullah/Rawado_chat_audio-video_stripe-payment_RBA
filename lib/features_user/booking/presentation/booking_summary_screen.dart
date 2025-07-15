// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rawado/common_wigdets/custom_appbar.dart';
import 'package:rawado/common_wigdets/custom_container.dart';
import 'package:rawado/constants/text_font_style.dart';
import 'package:rawado/features_user/booking/presentation/widgets/payment_successful_widget.dart';
import 'package:rawado/gen/colors.gen.dart';
import 'package:rawado/helpers/dateuitl.dart';
import 'package:rawado/helpers/loading_helper.dart';
import 'package:rawado/helpers/ui_helpers.dart';
import 'package:rawado/networks/api_acess.dart';
import 'package:rawado/provider/address_provider.dart';
import '../../../common_wigdets/auth_button.dart';
import '../../../gen/assets.gen.dart';
import '../../../helpers/all_routes.dart';
import '../../../helpers/helper_methods.dart';
import '../../../helpers/navigation_service.dart';
import '../../../provider/booking_porvider.dart';
import 'widgets/web_view_screen.dart';

class BookingSummaryScreen extends StatefulWidget {
  final bool isReSchedule;
  const BookingSummaryScreen({super.key, this.isReSchedule = false});

  @override
  State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    var bookingProvider = Provider.of<BookingPorvider>(context, listen: false);
    var addressProvider = Provider.of<AddressProvider>(context, listen: false);
    // CardFieldInputDetails? _cardDetails;

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.isReSchedule ? 'RESCHEDULE SUMMERY' : 'BOOKING SUMMERY',
        centerTitle: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
        children: [
          CustomContainer(
            child: Column(
              children: [
                BookingSummuryWidget(
                  title: 'TRAINER NAME:',
                  subTitle: bookingProvider.trainerName ?? 'JOHN DEO',
                ),
                UIHelper.verticalSpaceSmall,
                BookingSummuryWidget(
                  title: 'Address:'.toUpperCase(),
                  subTitle:
                      addressProvider.address?.toUpperCase() ?? 'Paris, France',
                ),
                UIHelper.verticalSpaceSmall,
                BookingSummuryWidget(
                  title: 'Booking Date:'.toUpperCase(),
                  subTitle: bookingProvider.date ?? '26 Aug 2024',
                ),
                UIHelper.verticalSpaceSmall,
                BookingSummuryWidget(
                  title: 'Booking Time:'.toUpperCase(),
                  subTitle: DateFormatedUtils.convertToAmPm(
                      "${bookingProvider.serviceTime}"),
                ),
                UIHelper.verticalSpaceSmall,
                BookingSummuryWidget(
                  title: 'Service:'.toUpperCase(),
                  subTitle:
                      bookingProvider.serviceType?.toUpperCase() ?? 'Yoga',
                ),
                UIHelper.verticalSpaceSmall,
                BookingSummuryWidget(
                  title: 'Service Duration:'.toUpperCase(),
                  subTitle: '1 Hour',
                ),
                UIHelper.verticalSpaceSmall,
                BookingSummuryWidget(
                  title: 'Payment:'.toUpperCase(),
                  subTitle: '\$${bookingProvider.charge ?? '120'}',
                ),

                ///................... Stripe Save Card
                // Container(
                //   height: 200,
                //   color: AppColors.white,
                //   child: CardField(
                //     enablePostalCode: true,
                //     onCardChanged: (cardDetails) {
                //       setState(() {
                //         _cardDetails = cardDetails;
                //         log('card details : $cardDetails');
                //       });
                //     },
                //     decoration: const InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'Card Details',
                //     ),
                //   ),
                // ),
                // ElevatedButton(
                //   onPressed: () async {
                //     try {
                //       if (_cardDetails == null || !_cardDetails!.complete) {
                //         log("Please complete the card details");
                //         return;
                //       }

                //       // Proceed with saving the card
                //       await saveCard(
                //           'pi_3QWAefKoqeKH4TXi1OJDNrqG_secret_ySG2hUHloDkboxyPYwKUOXiIi');
                //     } catch (e) {
                //       log(e.toString());
                //     }
                //   },
                //   child: Text("Save Card"),
                // ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: CustomFloatingButton(
        title: 'CONTINUE BOOKING',
        onTap: () async {
          Map body = {
            "date_full": bookingProvider.date,
            "start_time": bookingProvider.serviceTime!.split('-').first,
            "end_time": bookingProvider.serviceTime!.split('-').last,
            "location": addressProvider.address,
            "longitude": double.parse(addressProvider.lon!),
            "latitude": double.parse(addressProvider.lat!)
          };

          log('body : $body');

          try {
            var bookingResponse;

            ///........... Reshcedule Api
            // if (widget.isReSchedule) {
            //   Map reSchedulebody = {
            //     "date_full": bookingProvider.date,
            //     "start_time": bookingProvider.startTime,
            //     "end_time": bookingProvider.endTime,
            //   };

            //   bookingResponse = await postRescheduleRXObj
            //       .reSchedule(bookingProvider.id!, reSchedulebody)
            //       .waitingForFuture();
            // } else {

            ///>>>>> Hit Booking API To Create Booking Request
            bookingResponse = await postBookingRXObj
                .booking(bookingProvider.id!, body)
                .waitingForFuture();
            // }

            // log(">>>>>>>>>=====>>>>>>>>>>>>>");
            // log(">>>>>>>>>=====$bookingResponse");
            // log(">>>>>>>>>=====${bookingResponse["data"]}");
            // log(">>>>>>>>>=====${bookingResponse["status"]}");

            if (bookingResponse["status"] == false) {
              log('if booking is false');
              return;
            } else {
              log('if booking is else');
            }

            // if ((bookingResponse["data"] is List &&
            //     bookingResponse["data"].isNotEmpty)) {
            // log('if print');
            Map paymentBody = {
              "booking_id": bookingResponse["data"]["booking"]["id"],
              "transaction_id": bookingResponse["data"]["transaction"]["id"],
              "charge": bookingResponse["data"]["booking"]["service"]["charge"],
              "reason": widget.isReSchedule ? 'reschedule' : 'booking'
            };

            ///...... Create Tap Payment And Redirect to Tap Payment Url
            final tapPayment =
                await tapPaymentRX.tapPayment(paymentBody).waitingForFuture();

            log('>>>>>>>>>> payment link $tapPayment');

            if (tapPayment != null) {
              Get.to(() => WebViewScreen(
                    link: tapPayment,
                  ));
            }

            ///...... Create Payment Intent with booking id
            // final paymentIntent = await postPaymentIntentRXObj
            //     .paymentIntent(paymentBody)
            //     .waitingForFuture();

            // saveCard(paymentIntent["data"]["client_secret"]);

            ///........... Open Stripe Payment Sheet with client_secret_key
            // stripePaymentSheet(
            //     clientIntentId: '',
            //     orderId: 2,
            //     paymentIntentClientSecret: paymentIntent["data"][
            //         "client_secret"]); // client_secret come from paymentIntent Response
            // }
          } catch (e) {
            log('Error: $e');
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text('Error: $e')),
            // );
            rethrow;
          }
        },
      ),
    );
  }

  Future<void> stripePaymentSheet(
      {required String paymentIntentClientSecret,
      required dynamic orderId,
      required dynamic clientIntentId}) async {
    // Open Payment Sheet
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: paymentIntentClientSecret,
      merchantDisplayName: 'Service Booking',
    ));

    // Make Payment By Stripe
    await Stripe.instance.presentPaymentSheet().then((value) async {
      if (value == null) {
        // Clear The Booking Information
        context.read<BookingPorvider>().clearBookingInfo();
        //Show Payment Sucess Status
        Get.snackbar('Sussess', 'Payment Success',
            backgroundColor: Colors.green[300],
            snackPosition: SnackPosition.BOTTOM);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //       content: Text('Payment Success'.toUpperCase(),
        //           style: TextStyle(fontSize: 18.sp, color: appColor()))),
        // );

        NavigationService.navigateTo(Routes.navigationScreen);

        // Show The Pop UP
        getPopUp(context, (p0) {
          return PaymentSuccessfulWidget(
            onTap: () {
              NavigationService.navigateTo(Routes.navigationScreen);
            },
            imagePath: Assets.images.verifyImage.path,
            title: 'YOU BOOKING CREATE SUCCESSFULLY',
            subTitle: 'TRAINER WILL COMPLETED SERVICE IN SCHEDULE TIME.',
          );
        });
      }
    }).catchError((e) {
      Get.snackbar('Something wants wrong', 'Payment Failed',
          backgroundColor: Colors.red[300],
          snackPosition: SnackPosition.BOTTOM);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //       content: Text('Payment Failed',
      // style: TextStyle(fontSize: 18.sp, color: Colors.red))),
      // );
    });
  }

  Future<void> saveCard(String clientSecret) async {
    try {
      final setupIntent = await Stripe.instance.confirmSetupIntent(
        paymentIntentClientSecret: clientSecret,
        params: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(),
        ),
      );

      // Save this payment method ID for future charges
      log('Saved Payment Method: ${setupIntent.paymentMethodId}');
    } catch (e) {
      log('Error saving card: $e');
    }
  }
}

class CustomFloatingButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  const CustomFloatingButton({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: AppCustomeButton(
          name: title,
          onCallBack: onTap,
          height: 56.h,
          minWidth: double.infinity,
          borderRadius: 40.r,
          color: appColor(),
          textStyle: TextFontStyle.headline14StyleCabin700
              .copyWith(color: appTextColor()),
          context: context),
    );
  }
}

class BookingSummuryWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  const BookingSummuryWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextFontStyle.headline16StyleCabin
              .copyWith(color: AppColors.cCFCFCF),
        ),
        Expanded(
          child: Text(
            textAlign: TextAlign.right,
            subTitle,
            style: TextFontStyle.headline16StyleCabin
                .copyWith(color: AppColors.cCFCFCF),
          ),
        )
      ],
    );
  }
}

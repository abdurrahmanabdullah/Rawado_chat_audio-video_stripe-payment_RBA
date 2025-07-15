import 'package:rawado/features_user/auth/data/rx_get_logout/rx.dart';
import 'package:rawado/features_user/auth/data/rx_social_login/rx.dart';
import 'package:rawado/features_user/auth/model/signup_response.dart';
import 'package:rawado/features_user/booking/data/rx_payment/rx.dart';
import 'package:rawado/features_user/booking/data/rx_post_reschedule/rx.dart';
import 'package:rawado/features_user/booking/data/rx_service_schedule/rx.dart';
import 'package:rawado/features_user/home/data/rx_all_service/rx.dart';
import 'package:rawado/features_user/massage/data/rx_massage_list/rx.dart';
import 'package:rawado/features_user/massage/data/rx_message_room_create/rx.dart';
import 'package:rawado/features_user/massage/data/rx_recive_message/rx.dart';
import 'package:rawado/features_user/massage/data/rx_send_message/rx.dart';
import 'package:rawado/features_user/profile/data/rx_profile_details/rx.dart';
import 'package:rawado/features_user/profile/data/rx_update_profile/rx.dart';
import 'package:rawado/features_user/profile/model/profile_details_model.dart';
import 'package:rawado/features_user/schedule/model/customer_schedule_response.dart';
import 'package:rawado/features_user/search/data/rx_map_direction/rx.dart';
import 'package:rawado/features_user/search/data/rx_search/rx.dart';
import 'package:rawado/features_user/settings/data/rx_change_password/rx.dart';
import 'package:rawado/features_trainer/earning/data/rx.dart';
import 'package:rawado/features_trainer/home/data/rx_all_service/rx.dart';
import 'package:rawado/features_trainer/home/model/all_service_model.dart';
import 'package:rawado/features_trainer/notification/data/rx_add_token/rx.dart';
import 'package:rawado/features_trainer/notification/data/rx_get_notificaton/rx.dart';
import 'package:rawado/features_trainer/review/data/rx_trainer_rating/rx.dart';
import 'package:rawado/features_trainer/review/model/trainer_rating_response.dart';
import 'package:rawado/features_trainer/review/model/user_review_response.dart';
import 'package:rawado/features_trainer/schedule/data/rx_booking_action/rx.dart';
import 'package:rawado/features_trainer/schedule/data/rx_trainer_booking_list/rx.dart';
import 'package:rawado/features_trainer/service/data/rx_add_service/rx.dart';
import 'package:rawado/features_trainer/service/data/rx_add_shedule/rx.dart';
import 'package:rawado/features_trainer/service/data/rx_available_service/rx.dart';
import 'package:rawado/features_trainer/service/data/rx_cetagories.dart/rx.dart';
import 'package:rawado/features_trainer/service/data/rx_service_details/rx.dart';
import 'package:rawado/features_trainer/service/model/available_response.dart';
import 'package:rawado/features_trainer/service/model/categories_response.dart';
import 'package:rawado/features_trainer/service/model/schedule_response.dart';
import 'package:rawado/features_trainer/service/model/service_response.dart';
import 'package:rxdart/rxdart.dart';
import '../features_trainer/notification/data/rx_complete_sevice/rx.dart';
import '../features_user/auth/data/reset_password_otp/rx.dart';
import '../features_user/auth/data/rx_forget_pw/rx.dart';
import '../features_user/auth/data/rx_login/rx.dart';
import '../features_user/auth/data/rx_post_fw_email/rx.dart';
import '../features_user/auth/data/rx_signup/rx.dart';
import '../features_user/auth/model/login_response.dart';
import '../features_user/booking/data/rx_booking/rx.dart';
import '../features_user/booking/data/rx_tap_payment/rx.dart';
import '../features_user/booking/model/service_schedule_time_response.dart';
import '../features_user/massage/model/message_list_response.dart';
import '../features_user/ratting/data/rx_submit_review/rx.dart';
import '../features_user/schedule/data/rx_booking_history/rx.dart';
import '../features_user/schedule/data/rx_booking_schedule/rx.dart';
import '../features_user/trainer_details/data/rx_customer_service/rx.dart';
import '../features_user/trainer_details/model/single_service_response.dart';
import '../features_trainer/review/data/rx_user_review/rx.dart';
import '../features_trainer/schedule/model/trainer_booking_list.dart';

GetLoginRX getLoginRXObj = GetLoginRX(
    empty: LoginResponse(), dataFetcher: BehaviorSubject<LoginResponse>());

PostSignUpRX postSignUpRX = PostSignUpRX(
    empty: SignUpResponse(), dataFetcher: BehaviorSubject<SignUpResponse>());

GetLogOutRX getLogOutRXObj =
    GetLogOutRX(empty: {}, dataFetcher: BehaviorSubject<Map>());

PostForgetEmailRX postForgetEmailRXObj =
    PostForgetEmailRX(empty: {}, dataFetcher: BehaviorSubject<Map>());

PostForgertPwRX postForgertPwRX =
    PostForgertPwRX(empty: {}, dataFetcher: BehaviorSubject<Map>());

VerifyOtpFPRX verifyOtpFPRX =
    VerifyOtpFPRX(empty: {}, dataFetcher: BehaviorSubject<Map>());

PostServiceCreateRX postServiceCreateRXObj = PostServiceCreateRX(
    empty: CreateServiceResponse(),
    dataFetcher: BehaviorSubject<CreateServiceResponse>());

GetCategoriesRX getCategoriesRXObj = GetCategoriesRX(
    empty: CategoriesResponse(),
    dataFetcher: BehaviorSubject<CategoriesResponse>());

GetServiceDetailsRX getServiceDetailsRXObj = GetServiceDetailsRX(
    empty: CreateServiceResponse(),
    dataFetcher: BehaviorSubject<CreateServiceResponse>());

PostAddScheduleRX postAddScheduleRXObj = PostAddScheduleRX(
    empty: ScheduleResponnse(),
    dataFetcher: BehaviorSubject<ScheduleResponnse>());

GetProfileDetailsRX getProfileDetailsRXObj = GetProfileDetailsRX(
    empty: ProfileDetailsModel(),
    dataFetcher: BehaviorSubject<ProfileDetailsModel>());

GetTrainerAllServicesRX getAllServicesRXObj = GetTrainerAllServicesRX(
    empty: AllServiceResponse(),
    dataFetcher: BehaviorSubject<AllServiceResponse>());

GetCustomerAllServicesRX getCustomerAllServicesRXObj = GetCustomerAllServicesRX(
    empty: AllServiceResponse(),
    dataFetcher: BehaviorSubject<AllServiceResponse>());

GetSingleServicesRx getSingleServicesRXObj = GetSingleServicesRx(
    empty: SingleServiceResponse(),
    dataFetcher: BehaviorSubject<SingleServiceResponse>());

GetAvailableServiceRX getAvailableServiceRXObj = GetAvailableServiceRX(
    empty: AvailableServiceResponse(),
    dataFetcher: BehaviorSubject<AvailableServiceResponse>());

GetTrainerAllServicesRX getTrainerAllServicesRXObj = GetTrainerAllServicesRX(
    empty: AllServiceResponse(),
    dataFetcher: BehaviorSubject<AllServiceResponse>());

PostBookingRX postBookingRXObj =
    PostBookingRX(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetBookedScheduleRX getAllBookedScheduleRXObj = GetBookedScheduleRX(
    empty: CustomerScheduleResponse(),
    dataFetcher: BehaviorSubject<CustomerScheduleResponse>());

GetBookingHistoryRX getBookingHistoryRXObj = GetBookingHistoryRX(
    empty: CustomerScheduleResponse(),
    dataFetcher: BehaviorSubject<CustomerScheduleResponse>());

GetTrainerBookingListRX getTrainerBookingListRXObj = GetTrainerBookingListRX(
    empty: TrainerBookingResponse(),
    dataFetcher: BehaviorSubject<TrainerBookingResponse>());

PostTrainerBookinActionRX postTrainerBookinActionRXObj =
    PostTrainerBookinActionRX(empty: {}, dataFetcher: BehaviorSubject<Map>());

PostUpdateProfileRX postUpdateProfileRXObj =
    PostUpdateProfileRX(empty: {}, dataFetcher: BehaviorSubject<Map>());

PostChangePasswordRX postChangePasswordRXobj =
    PostChangePasswordRX(empty: {}, dataFetcher: BehaviorSubject<Map>());

PostPaymentIntentRX postPaymentIntentRXObj =
    PostPaymentIntentRX(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetUserReviewRX getUserReviewRXObj = GetUserReviewRX(
    empty: UserReviewResponse(),
    dataFetcher: BehaviorSubject<UserReviewResponse>());

GetTrainerRatingRX getTrainerRatingRXObj = GetTrainerRatingRX(
    empty: TrainerRatingResponse(),
    dataFetcher: BehaviorSubject<TrainerRatingResponse>());

PostCustomerGiveReviewRX postCustomerGiveReviewRXObjj =
    PostCustomerGiveReviewRX(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetSeaarchRX getSeaarchRXObj = GetSeaarchRX(
    empty: AllServiceResponse(),
    dataFetcher: BehaviorSubject<AllServiceResponse>());

GetDirectionRX getDirectionRXObj = GetDirectionRX(
    empty: {}, dataFetcher: BehaviorSubject<Map<String, dynamic>>());

GetMessageListRX getMessageListRXObj = GetMessageListRX(
    empty: MessageListResponse(),
    dataFetcher: BehaviorSubject<MessageListResponse>());

GetMessageRx getMessageRxObj =
    GetMessageRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

PostSendMessageRx postSendMessageRxObj =
    PostSendMessageRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetNotificationRx getNotificationRxObj =
    GetNotificationRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

PostRescheduleRX postRescheduleRXObj =
    PostRescheduleRX(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetTrainerEarningRx getTrainerEarningRx =
    GetTrainerEarningRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

PostSocialLoginRX postSocialLoginRXObj = PostSocialLoginRX(
    empty: LoginResponse(), dataFetcher: BehaviorSubject<LoginResponse>());

PostAddTokenRx postAddTokenRxObj =
    PostAddTokenRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetMessageRoomRx getMessageRoomRxObj =
    GetMessageRoomRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

PostUserSessionCompleteActionRX postUserSessionCompleteActionRXObj =
    PostUserSessionCompleteActionRX(
        empty: {}, dataFetcher: BehaviorSubject<Map>());

TapPaymentRX tapPaymentRX =
    TapPaymentRX(empty: '', dataFetcher: BehaviorSubject<String>());

GetServiceScheduleRX getServiceScheduleRX = GetServiceScheduleRX(
    empty: ServiceScheduleTimeResponse(),
    dataFetcher: BehaviorSubject<ServiceScheduleTimeResponse>());

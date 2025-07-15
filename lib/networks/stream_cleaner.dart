import 'package:rawado/networks/api_acess.dart';
import '../constants/app_constants.dart';
import '../helpers/di.dart';

Future<void> totalDataClean() async {
  await appData.write(kKeyIsLoggedIn, false);
  await appData.write(kKeyIsExploring, false);
  await appData.remove(kKeyUserName);
  await appData.remove(kKeyUserID);
  await appData.remove(kKeyAccessToken);
  // cleanLoginData();
}

void cleanLoginData() {
  getProfileDetailsRXObj.clean();
  getTrainerAllServicesRXObj.clean();
  getTrainerAllServicesRXObj.clean();
  getCustomerAllServicesRXObj.clean();
  getMessageListRXObj.clean();
  getBookingHistoryRXObj.clean();
  getAllBookedScheduleRXObj.clean();
}

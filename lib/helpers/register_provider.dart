import 'package:provider/provider.dart';
import 'package:rawado/provider/address_provider.dart';
import 'package:rawado/provider/booking_porvider.dart';
import 'package:rawado/provider/onboarding_provider.dart';

import '../provider/provides.dart';
import '../provider/toggle_button_provider.dart';

var providers = [
  ChangeNotifierProvider<GenericDi>(
    create: ((context) => GenericDi()),
  ),
  ChangeNotifierProvider<PropertySelectorProvider>(
    create: ((context) => PropertySelectorProvider()),
  ),
  ChangeNotifierProvider<OnboardingProvider>(
    create: ((context) => OnboardingProvider()),
  ),
  ChangeNotifierProvider<AddressProvider>(
    create: ((context) => AddressProvider()),
  ),
  ChangeNotifierProvider<BookingPorvider>(
    create: ((context) => BookingPorvider()),
  ),
];

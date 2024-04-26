import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patidar_melap_app/app/config/app_config.dart';
import 'package:stream_transform/stream_transform.dart';

class ApiConstants {
  static const int itemsPerPage = 10;

  static String baseUrl = AppConfig.baseApiUrl;
  static const login = '/api/v1/login';
  static const signup = '/api/v1/signup';
  static const verifyOtp = '/api/v1/verify-otp';
  static const sendOtp = 'https://patidar-dev.preview.im/api/v1/send-otp';
  static const stateList = '/api/v1/states';
  static const forgetPassword = '/api/v1/forget-password';
  static const contactUsData = '/api/v1/client/contact-us';
  static const setupPassword = '/api/v1/setup-password';
  static const healthCard = '/api/v1/client/health-card';
  static const logout = '/api/v1/logout';
  static const me = '/api/v1/me';
  static const changePassword = '/api/v1/change-password';

  static const providers = '/api/v1/client/providers';
  static const requestPhysicalId = 'https://abcagencygroup.zendesk.com/hc/en-us/requests/new?ticket_form_id=23990299331476';
  static const trackHours = '/api/v1/client/track-hours';
  static const coupons = '/api/v1/client/coupons';
  static const claimedCoupon = '/api/v1/client/claimed-offers';
  static const claimedCouponTrackTime = '/api/v1/client/tracked-time';
  static const verifyPhoneNumber = '/api/v1/verify-phone-number';
  static const countryCode = '/api/v1/countries';
  static const removeAccount = '/api/v1/client/remove-account';
  static const locationSettings = '/api/v1/client/location/settings';
  static const appVersion = '/api/v1/versions';

  static String locations = '$baseUrl/api/v1/client/locations';
  static String termsOfUse = '$baseUrl/terms-of-use';
  static String privacyPolicy = '$baseUrl/privacy-policy';
  static String removeAccountPolicy = '$baseUrl/remove-account-policy';
}

class AppConstants {
  static const appName = 'Abc-app';
  static const double smallRadius = 8;
  static const double defaultRadius = 16;
  static const double pinBoxHeight = 44;
  static const double pinBoxWidth = 44;

  static EventTransformer<Event> debounce<Event>({
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return (events, mapper) => events.debounce(duration).switchMap(mapper);
  }
}

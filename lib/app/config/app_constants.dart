import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patidar_melap_app/app/config/app_config.dart';
import 'package:stream_transform/stream_transform.dart';

class ApiConstants {
  static const int itemsPerPage = 10;

  static String baseUrl = AppConfig.baseApiUrl;

  static const sendOtp = 'https://patidar-dev.preview.im/api/v1/send-otp';
  static const register = 'https://patidar-dev.preview.im/api/v1/register';
  static const login = 'https://patidar-dev.preview.im/api/v1/login';
  static const salaryCurrency = 'https://patidar-dev.preview.im/api/v1/salary-currency-list';
  static const caste = 'https://patidar-dev.preview.im/api/v1/castes';
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

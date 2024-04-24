import 'package:logger/logger.dart';

import 'injection.dart';

void flog(String message) {
  getIt<Logger>().i(message);
}


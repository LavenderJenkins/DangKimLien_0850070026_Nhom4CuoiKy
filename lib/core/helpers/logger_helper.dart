import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoggerHelper {
  static final LoggerHelper _logger = LoggerHelper._internal();

  log(data) {
    if ("${DotEnv().env['ENV']}" == 'production') return;
    print(data);
  }

  factory LoggerHelper() {
    return _logger;
  }
  LoggerHelper._internal();
}

final logger = LoggerHelper();

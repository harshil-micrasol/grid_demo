import 'package:flutter/foundation.dart';

class AppEnvironment {
  String getApiURL() {
    if (kReleaseMode) {
      return "https://micrasolution.com/v1/";
    } else if (kDebugMode) {
      return "https://micrasolution.com/v1/";
    } else {
      return "";
    }
  }
}

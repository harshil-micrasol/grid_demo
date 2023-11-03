import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const double defaultPadding = 18.0;
const double defaultRadius = 8.0;
const int defaultAmountLength = 12;

bool isValEmpty(dynamic val) {
  String? value = val.toString();
  return (val == null || value.isEmpty || value == "null" || value == "" || value == "NULL");
}

bool isAmountValid(dynamic val) {
  if (double.parse(val.isEmpty ? "0.1" : val) > 100.0) {
    return false;
  } else {
    return true;
  }
}

bool isPeriodValid(dynamic val) {
  if (double.parse(val.isEmpty ? "0.1" : val) < 15.0) {
    return false;
  } else {
    return true;
  }
}

bool isProcessingFeesValid(dynamic val) {
  if (double.parse(val.isEmpty ? "0.1" : val) > 50.0) {
    return false;
  } else {
    return true;
  }
}

BoxBorder defaultBorder = Border.all(color: const Color(0xffE8E8E8));

DateTime defaultDateTime = DateTime.parse("1999-01-01 12:00:00.974368");

extension StrExtension on String {
  static String capitalize(String s) {
    return "${s[0].toUpperCase()}${s.substring(1).toLowerCase()}";
  }
}

Future<void> launchUrlFunction(url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

DateTime findFutureDate({DateTime? futureDate, required double totalMonths}) {
  futureDate ??= DateTime.now();

  for (int i = 1; i <= totalMonths; i++) {
    int year = futureDate!.year;
    int month = futureDate.month;

    if (month == 12) {
      year++;
      month = 1;
    } else {
      month++;
    }

    futureDate = DateTime(year, month, futureDate.day, futureDate.hour, futureDate.minute, futureDate.second, futureDate.millisecond, futureDate.microsecond);
  }

  return futureDate!;
}

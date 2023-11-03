import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../res/app_button.dart';
import '../res/app_strings.dart';
import 'utils.dart';

class UiUtils {
  static Future toast(message) async {
    FToast fToast = FToast();
    fToast.removeQueuedCustomToasts();
    fToast.removeCustomToast();
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 16.0,
    );
  }

  static Widget backIcon() => const Icon(
        Icons.arrow_back,
        size: 25,
      );

  static Widget menuIcon() => const Icon(
        Icons.menu,
        size: 25,
      );

  static Widget actionIcon() => const Icon(
        Icons.more_vert,
        size: 25,
      );
  static Widget percentageWidget() => SizedBox(
        // This width and [AppTextField] hight same
        width: 57,
        child: Center(
          child: Text(
            "%",
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
          ),
        ),
      );
  static Widget rupeeWidget() => SizedBox(
        // This width and [AppTextField] hight same
        width: 57,
        child: Center(
          child: Text(
            AppStrings.rupeeSymbol,
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
          ),
        ),
      );

  static String convertRupees(dynamic value, {int? decimalDigits, String? symbol}) {
    if (value > 100) {
      NumberFormat indiaFormat = NumberFormat.compactCurrency(
        decimalDigits: decimalDigits ?? 0,
        locale: 'en_IN',
        symbol: symbol ?? "",
        name: "",
      );
      return indiaFormat.format(double.parse("$value"));
    }

    NumberFormat indiaFormat = NumberFormat.compactCurrency(
      decimalDigits: decimalDigits ?? 0,
      locale: 'en_IN',
      symbol: symbol ?? "",
      name: "",
    );
    return indiaFormat.format(double.parse("$value"));
  }

  static String monthlyEMI(String value, {int? decimalDigits, String? symbol}) {
    if (!isValEmpty(value)) {
      NumberFormat format = NumberFormat.currency(
        decimalDigits: decimalDigits ?? 0,
        symbol: symbol ?? "",
        locale: "en_IN",
      );
      return format.format(double.parse(value));
    } else {
      return "0.0";
    }
  }

  static String convertCurrencyToString(String value) {
    return value.replaceAll(",", "");
  }

  static AppButton resetButton(BuildContext context, {required VoidCallback onPressed}) {
    return AppButton(
      backgroundColor: Theme.of(context).colorScheme.error.withOpacity(.3),
      padding: const EdgeInsets.all(defaultPadding).copyWith(bottom: MediaQuery.of(context).padding.bottom + defaultPadding, left: defaultPadding / 2),
      onPressed: onPressed,
      child: Text(
        "Reset",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600, fontSize: 14.sp),
      ),
    );
  }
}

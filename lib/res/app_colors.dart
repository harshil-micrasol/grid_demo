import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static Color kPrimaryColor = const Color.fromARGB(255, 37, 100, 139);
  static Color kBackgroundColor = const Color(0xFF7F7F92);
  static Color errorColor = const Color(0xffFF6B6B);

  static List<Color> bannerGradientColorList = [
    const Color(0xff169A8A).withOpacity(0.1),
    const Color(0xffFFD83D).withOpacity(0.1),
    const Color(0xffFFD83D).withOpacity(0.1),
    const Color(0xffFF417E).withOpacity(0.1),
  ];

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String fromColor(Color color) {
    String hex = '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
    return hex;
  }
}

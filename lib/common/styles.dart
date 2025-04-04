import 'package:flutter/material.dart';

class AppTextStyles {
  static double _getResponsiveFontSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 360) {
      return baseSize * 0.85;
    } else if (screenWidth < 480) {
      return baseSize * 0.90;
    } else if (screenWidth < 600) {
      return baseSize;
    } else {
      return baseSize * 1.5;
    }
  }

  static TextStyle titleLarge(BuildContext context) => TextStyle(
        fontSize: _getResponsiveFontSize(context, 33),
        fontWeight: FontWeight.bold,
      );

  static TextStyle titleMedium(BuildContext context) => TextStyle(
        fontSize: _getResponsiveFontSize(context, 21),
        fontWeight: FontWeight.w600,
      );
  static TextStyle titleSmall(BuildContext context) => TextStyle(
        fontSize: _getResponsiveFontSize(context, 18),
        fontWeight: FontWeight.w600,
      );
  static TextStyle titleMediumGery(BuildContext context) => TextStyle(
        fontSize: _getResponsiveFontSize(context, 18),
        fontWeight: FontWeight.w600,
        color: const Color(0xFF787486),
      );

  static TextStyle bodyTextLarge(BuildContext context) => TextStyle(
        fontSize: _getResponsiveFontSize(context, 21),
      );

  static TextStyle bodyTextMedium(BuildContext context) => TextStyle(
        fontSize: _getResponsiveFontSize(context, 16),
      );

  static TextStyle bodyTextSmall(BuildContext context) => TextStyle(
        fontSize: _getResponsiveFontSize(context, 18),
        color: Colors.grey,
      );

  static TextStyle buttonLabel(BuildContext context) => TextStyle(
        fontSize: _getResponsiveFontSize(context, 18),
        fontWeight: FontWeight.w400,
        color: Colors.white,
      );
}

class AppColors {
  static const Color blueColor = Color(0xFF007AFF);
  static const Color lightBlueColor = Color(0xFF86BBF4);
  static const Color redColor = Color(0xFFDC2626);

  static const Color lightPurple = Color(0xFF7569DE);
  static const Color darkPurple = Color(0xFF2E1FAF);

  static const Color lightGreen = Color(0xFFB1DE52);
  static const Color limeGreen = Color(0xFF81AB27);

  static const Color softGreen1 = Color(0xFFD9EADA);
  static const Color softGreen2 = Color(0xFFC1DDC3);

  static const Color brightYellow = Color(0xFFF3C41F);
  static const Color brightOrange = Color(0xFFF88C29);
}

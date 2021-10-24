import 'package:flutter/cupertino.dart';
import 'package:prtmobile/styles/styles.dart';

class FontSizes {
  static const double body = 16;
  static const double h2 = 24;
  static const double h3 = 20;
}

class AppTypography {
  static const kFontHeight = 1.4;

  static TextStyle get bodyText => const TextStyle(
        fontSize: FontSizes.body,
        height: kFontHeight,
      );
  static TextStyle get h2 => const TextStyle(
        fontSize: FontSizes.h2,
        height: kFontHeight,
      );
  static TextStyle get h3 => const TextStyle(
        fontSize: FontSizes.h3,
        height: kFontHeight,
      );
}

extension TextStyleExtensions on TextStyle {
  TextStyle greyed() => copyWith(color: AppColors.grey);
  TextStyle bold() => copyWith(fontWeight: FontWeight.bold);
}

double calcTextSize({
  required double fontSize,
  double fontHeight = AppTypography.kFontHeight,
  required double scaleFactor,
}) {
  return (fontSize * fontHeight * scaleFactor).roundToDouble();
}

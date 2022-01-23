import 'package:flutter/cupertino.dart';
import 'package:prtmobile/styles/styles.dart';

class FontSizes {
  static const double body = 14;
  static const double h1 = 36;
  static const double h2 = 22;
  static const double h3 = 18;
  static const double h4 = 16;
}

class AppTypography {
  static const kFontHeight = 1.4;

  static TextStyle get bodyText => const TextStyle(
        fontSize: FontSizes.body,
        height: kFontHeight,
      );
  static TextStyle get h1 => const TextStyle(
        fontSize: FontSizes.h1,
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

  static TextStyle get h4 => const TextStyle(
        fontSize: FontSizes.h4,
        height: kFontHeight,
      );
}

extension TextStyleExtensions on TextStyle {
  TextStyle greyed() => copyWith(color: AppColors.grey);
  TextStyle bold() => copyWith(fontWeight: FontWeight.bold);
  TextStyle white() => copyWith(color: AppColors.white);
  TextStyle red() => copyWith(color: AppColors.flory);
}

double calcTextSize({
  required double fontSize,
  double fontHeight = AppTypography.kFontHeight,
  required double scaleFactor,
}) {
  return (fontSize * fontHeight * scaleFactor).roundToDouble();
}

class RefreshIndicatorSizes {
  static const double h4 = 8.5;
}

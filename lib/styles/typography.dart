import 'package:flutter/cupertino.dart';
import 'package:prtmobile/styles/styles.dart';

class FontSizes {
  static const double small = 12;
  static const double body = 14;
  static const double h1 = 36;
  static const double h2 = 26;
  static const double h3 = 24;
  static const double h4 = 20;
  static const double h5 = 16;
}

class AppTypography {
  static const kFontHeight = 1.4;

  static TextStyle get small => const TextStyle(
        fontSize: FontSizes.small,
        height: kFontHeight,
      );

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

  static TextStyle get h5 => const TextStyle(
        fontSize: FontSizes.h5,
        height: 1.3,
      );

  static TextStyle get error => AppTypography.small.red();
}

extension TextStyleExtensions on TextStyle {
  TextStyle greyed() => copyWith(color: AppColors.grey);
  TextStyle bold() => copyWith(fontWeight: FontWeight.bold);
  TextStyle white() => copyWith(color: AppColors.white);
  TextStyle red() => copyWith(color: AppColors.flory);
  TextStyle bolder() => copyWith(fontWeight: FontWeight.w500);
  TextStyle height1() => copyWith(height: 1);
  TextStyle italic() => copyWith(fontStyle: FontStyle.italic);
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

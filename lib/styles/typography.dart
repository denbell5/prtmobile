import 'package:flutter/cupertino.dart';
import 'package:prtmobile/styles/styles.dart';

class FontSizes {
  static const double body = 16;
  static const double h2 = 24;
  static const double h3 = 20;
}

class AppTypography {
  static TextStyle get bodyText => const TextStyle(
        fontSize: FontSizes.body,
      );
  static TextStyle get h2 => const TextStyle(
        fontSize: FontSizes.h2,
      );
  static TextStyle get h3 => const TextStyle(
        fontSize: FontSizes.h3,
      );
}

extension TextStyleExtensions on TextStyle {
  TextStyle greyed() => copyWith(color: AppColors.grey);
  TextStyle bold() => copyWith(fontWeight: FontWeight.bold);
}

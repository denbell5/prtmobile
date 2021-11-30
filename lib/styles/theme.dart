import 'package:flutter/cupertino.dart';

class AppThemeData extends CupertinoThemeData {
  const AppThemeData({
    Brightness? brightness,
    Color? primaryColor,
    Color? primaryContrastingColor,
    CupertinoTextThemeData? textTheme,
    Color? barBackgroundColor,
    Color? scaffoldBackgroundColor,
  }) : super(
          barBackgroundColor: barBackgroundColor,
          brightness: brightness,
          primaryColor: primaryColor,
          primaryContrastingColor: primaryContrastingColor,
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          textTheme: textTheme,
        );
}

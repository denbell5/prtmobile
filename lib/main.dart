import 'package:flutter/material.dart';
import 'package:prtmobile/features/home/home.dart';
import 'package:prtmobile/styles/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.mineShaft,
        backgroundColor: AppColors.mineShaft,
        scaffoldBackgroundColor: AppColors.mineShaft,
        colorScheme: ColorScheme(
          primary: AppColors.white,
          primaryVariant: AppColors.white,
          secondary: AppColors.lightGrey,
          secondaryVariant: AppColors.grey,
          surface: AppColors.tundora,
          background: AppColors.mineShaft,
          error: AppColors.flory,
          onPrimary: AppColors.mineShaft,
          onSecondary: AppColors.mineShaft,
          onSurface: AppColors.white,
          onBackground: AppColors.white,
          onError: AppColors.white,
          brightness: Brightness.dark,
        ),
        textTheme: TextTheme(
          bodyText2: AppTypography.bodyText,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

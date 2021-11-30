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
        scaffoldBackgroundColor: AppColors.white,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.mineShaft,
          primaryVariant: AppColors.mineShaftVariant,
          secondary: AppColors.grey,
          secondaryVariant: AppColors.grey,
          surface: AppColors.lightGrey,
          background: AppColors.white,
          error: AppColors.flory,
          onPrimary: AppColors.white,
          onSecondary: AppColors.white,
          onSurface: AppColors.black,
          onBackground: AppColors.black,
          onError: AppColors.grey,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

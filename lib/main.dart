import 'package:flutter/cupertino.dart';
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
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData(
        scaffoldBackgroundColor: AppColors.white,
        primaryColor: AppColors.mineShaft,
        barBackgroundColor: AppColors.mineShaft,
        primaryContrastingColor: AppColors.white,
      ),
      home: const HomeScreen(),
    );
  }
}

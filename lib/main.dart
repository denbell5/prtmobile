import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:prtmobile/bloc/tracking/tracking.bloc.dart';
import 'package:prtmobile/components/snackbar/snackbar.dart';
import 'package:prtmobile/db/db.dart';
import 'package:prtmobile/features/home/home.dart';
import 'package:prtmobile/styles/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = TrackingDb(dbName: DbConfig.dbName);
  await db.open();

  final myApp = MyApp(db: db);
  runApp(myApp);
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.db,
  }) : super(key: key);

  final TrackingDb db;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const defaultTextTheme = CupertinoTextThemeData();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TrackingDb>.value(value: db),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (context) {
              final db = Provider.of<TrackingDb>(context, listen: false);
              return TrackingBloc(db: db);
            },
          ),
        ],
        child: CupertinoApp(
          debugShowCheckedModeBanner: false,
          theme: AppThemeData(
            scaffoldBackgroundColor: AppColors.white,
            primaryColor: AppColors.mineShaft,
            barBackgroundColor: AppColors.mineShaft,
            primaryContrastingColor: AppColors.white,
            textTheme: defaultTextTheme.copyWith(
              textStyle: defaultTextTheme.textStyle.merge(
                AppTypography.bodyText,
              ),
            ),
          ),
          home: const AppSnackbar(
            child: HomeScreen(),
          ),
        ),
      ),
    );
  }
}

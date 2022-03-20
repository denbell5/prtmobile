import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:prtmobile/features/tracking/tracking.dart';
import 'package:prtmobile/core/core.dart';
import 'package:prtmobile/features/home/home.dart';
import 'package:prtmobile/features/store/store.dart';

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
        RepositoryProvider<TrackingStoreDb>.value(
          value: TrackingStoreDb(),
        ),
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
          BlocProvider(
            create: (context) {
              final db = Provider.of<TrackingStoreDb>(context, listen: false);
              return TrackingStoreBloc(db: db);
            },
          )
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
            child: _AppRootNavigator(),
          ),
        ),
      ),
    );
  }
}

class _AppRootNavigator extends StatefulWidget {
  const _AppRootNavigator({
    Key? key,
  }) : super(key: key);

  @override
  __AppRootNavigatorState createState() => __AppRootNavigatorState();
}

class __AppRootNavigatorState extends State<_AppRootNavigator> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      initialRoute: AppRoutes.home,
      onGenerateRoute: (settings) {
        late WidgetBuilder builder;
        if (settings.name == AppRoutes.home) {
          builder = (context) => const HomeScreen();
        }
        if (settings.name == AppRoutes.store) {
          builder = (context) => const TracksetStore();
        }
        return CupertinoPageRoute<PageRoute>(
          builder: (context) => builder(context),
          settings: settings,
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/features/tracking/tracking.dart';
import 'package:prtmobile/core/core.dart';
import 'package:prtmobile/features/menu/menu.dart';

double calcNavbarHeight({required double systemBarHeight}) {
  final textStyle = AppTypography.h3;
  return systemBarHeight +
      kDefaultPadding * 1.5 +
      kDefaultPadding +
      textStyle.fontSize! * textStyle.height!;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _buildTodayText() {
    final now = DateTime.now();
    final formatted = formatDate(now);
    return Text(
      'Today is $formatted',
      style: AppTypography.h3.white(),
    );
  }

  ObstructingPreferredSizeWidget _buildNavbar({
    required double topBarPadding,
  }) {
    return AppNavbar(
      topBarPadding: topBarPadding,
      leading: const Padding(
        padding: EdgeInsets.only(top: 5.0),
        child: MenuIcon(),
      ),
      middle: _buildTodayText(),
    );
  }

  // ignore: todo
  // TODO: in separate widget
  void _listenToTrackingBloc(BuildContext context, TrackingState state) {
    void show(String text) {
      AppSnackbar.of(context)!.show(text: text);
    }

    if (state is TrackingErrorState) {
      if (state.shouldShowNotification) {
        show(state.description);
      }
      return;
    }
    if (state is TrackingUpdatedState) {
      if (state.isAfterTracksetSoAdded) {
        show('Added trackset ${state.updatedTrackset!.name}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final topBarPadding = MediaQuery.of(context).padding.top;
    return CupertinoPageScaffold(
      navigationBar: _buildNavbar(topBarPadding: topBarPadding),
      child: BlocListener<TrackingBloc, TrackingState>(
        listener: _listenToTrackingBloc,
        child: Column(
          children: const [
            Flexible(
              child: TracksetList(),
            ),
          ],
        ),
      ),
    );
  }
}

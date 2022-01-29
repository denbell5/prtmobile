import 'package:flutter/cupertino.dart';
import 'package:prtmobile/features/trackset/trackset_list.dart';
import 'package:prtmobile/styles/styles.dart';
import 'package:prtmobile/utils/utils.dart';

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

  Widget _buildNavbar({
    required double topBarPadding,
  }) {
    return PhysicalModel(
      color: CupertinoTheme.of(context).barBackgroundColor,
      elevation: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: topBarPadding + kDefaultPadding * 1.5,
              bottom: kDefaultPadding,
            ),
            child: _buildTodayText(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topBarPadding = MediaQuery.of(context).padding.top;
    return CupertinoPageScaffold(
      child: Column(
        children: [
          _buildNavbar(topBarPadding: topBarPadding),
          const Flexible(
            child: TracksetList(),
          ),
        ],
      ),
    );
  }
}

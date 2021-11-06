import 'package:flutter/material.dart';
import 'package:prtmobile/features/trackset/trackset_list.dart';
import 'package:prtmobile/styles/styles.dart';
import 'package:prtmobile/utils/utils.dart';

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

  @override
  Widget build(BuildContext context) {
    final topBarPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        children: [
          PhysicalModel(
            color: Theme.of(context).colorScheme.primary,
            elevation: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: topBarPadding + kHorizontalPadding * 1.5,
                    bottom: kHorizontalPadding,
                  ),
                  child: _buildTodayText(),
                ),
              ],
            ),
          ),
          const Flexible(
            child: TracksetList(),
          ),
        ],
      ),
    );
  }
}

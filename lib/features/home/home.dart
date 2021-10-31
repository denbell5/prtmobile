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
      style: AppTypography.h3,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: kHorizontalPadding * 1.5,
                bottom: kHorizontalPadding,
              ),
              child: _buildTodayText(),
            ),
            const Flexible(
              child: TracksetList(),
            ),
          ],
        ),
      ),
    );
  }
}

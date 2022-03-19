import 'package:flutter/cupertino.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/navigation/navigator.dart';
import 'package:prtmobile/styles/styles.dart';

class TracksetStore extends StatefulWidget {
  const TracksetStore({Key? key}) : super(key: key);

  @override
  State<TracksetStore> createState() => _TracksetStoreState();
}

class _TracksetStoreState extends State<TracksetStore> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: AppNavbar(
        topBarPadding: MediaQuery.of(context).padding.top,
        leading: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: TouchableIcon(
            iconData: CupertinoIcons.arrow_left,
            color: AppColors.white,
            onTap: () {
              AppNavigator.of(context).pop();
            },
          ),
        ),
        middle: Text(
          'For students',
          style: AppTypography.h3.white(),
        ),
      ),
      child: const SafeArea(
        child: Text('Trackset store'),
      ),
    );
  }
}

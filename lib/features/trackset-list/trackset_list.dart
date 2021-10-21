import 'package:flutter/material.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/styles/styles.dart';
import 'package:prtmobile/styles/typography.dart';

class TracksetList extends StatefulWidget {
  const TracksetList({Key? key}) : super(key: key);

  @override
  _TracksetListState createState() => _TracksetListState();
}

class _TracksetListState extends State<TracksetList> {
  Iterable<Widget> _buildTracksetListHeader() {
    return [
      Padding(
        padding: const EdgeInsets.only(
          left: kHorizontalPadding,
          right: kHorizontalPadding,
          top: kHorizontalPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tracksets',
              style: AppTypography.bodyText.bold(),
            ),
            TouchableOpacity(
              child: Text(
                'Add',
                style: AppTypography.bodyText.greyed(),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableList(
      listHeader: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._buildTracksetListHeader(),
        ],
      ),
      expandables: const [],
      expandableHeaderExtent: 0,
    );
  }
}

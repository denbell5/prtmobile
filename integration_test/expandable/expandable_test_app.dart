import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/core/models/normalized_list.dart';
import 'package:prtmobile/features/tracking/tracking.dart';

import '../mocks/tracking_db_mock.dart';
import 'expandable_test_data.dart';

class ExpandableTestApp extends StatelessWidget {
  const ExpandableTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: BlocProvider(
        create: (context) {
          return TrackingBloc(db: _MockTrackingDb());
        },
        child: const SafeArea(
          child: CupertinoPageScaffold(
            child: TracksetList(),
          ),
        ),
      ),
    );
  }
}

class _MockTrackingDb extends BaseMockTrackingDb {
  final _tracksets = buildTrackingData();

  @override
  Future<NormalizedList<Trackset, String>> getEnrichedTracksets() {
    return Future.value(_tracksets);
  }
}

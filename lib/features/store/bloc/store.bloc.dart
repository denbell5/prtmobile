export 'store.event.dart';
export 'store.state.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:prtmobile/features/store/store.dart';

class TrackingStoreBloc extends Bloc<TrackingStoreEvent, TrackingStoreState> {
  final TrackingStoreDb _db;

  TrackingStoreBloc({
    required TrackingStoreDb db,
  })  : _db = db,
        super(TrackingStoreState.initial());

  static TrackingStoreBloc of(
    BuildContext context, {
    bool listen = false,
  }) {
    return Provider.of<TrackingStoreBloc>(context, listen: listen);
  }

  @override
  Stream<TrackingStoreState> mapEventToState(TrackingStoreEvent event) async* {
    if (event is TrackingStoreInitialized) {
      yield* _mapTrackingStoreInitializedToState(event);
    }
    if (event is TrackingStoreFetched) {
      yield* _mapTrackingStoreFetchedToState(event);
    }
  }

  Stream<TrackingStoreState> _mapTrackingStoreInitializedToState(
    TrackingStoreInitialized event,
  ) async* {
    try {
      yield TrackingStoreLoadingState(state);
      await _db.init();
      final nextState = state.copyWith(isInitialized: true);
      if (event.isWithFetch) {
        yield TrackingStoreLoadingState(nextState);
        add(TrackingStoreFetched());
      } else {
        yield TrackingStoreUpdatedState(nextState);
      }
    } catch (ex) {
      yield TrackingStoreErrorState(
        state,
        description: 'Failed to fetch data',
        failedEvent: event,
      );
    }
  }

  Stream<TrackingStoreState> _mapTrackingStoreFetchedToState(
    TrackingStoreFetched event,
  ) async* {
    try {
      yield TrackingStoreLoadingState(state);
      final tracksets = await _db.getTracksets();
      yield TrackingStoreUpdatedState(
        state.copyWith(
          tracksets: tracksets,
        ),
      );
    } catch (ex) {
      yield TrackingStoreErrorState(
        state,
        description: 'Failed to fetch data',
        failedEvent: event,
      );
    }
  }
}

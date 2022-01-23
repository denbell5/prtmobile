export 'tracking.event.dart';
export 'tracking.state.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:prtmobile/db/db.dart';

import 'tracking.event.dart';
import 'tracking.state.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  final TrackingDb _db;
  TrackingBloc({
    required TrackingDb db,
  })  : _db = db,
        super(TrackingState.initial());

  static TrackingBloc of(
    BuildContext context, {
    bool listen = false,
  }) {
    return Provider.of<TrackingBloc>(context, listen: listen);
  }

  @override
  Stream<TrackingState> mapEventToState(TrackingEvent event) async* {
    if (event is TracksetsRequested) {
      yield* _mapTracksetsRequestedToState(event);
    }
  }

  Stream<TrackingState> _mapTracksetsRequestedToState(
    TracksetsRequested event,
  ) async* {
    try {
      yield TrackingLoadingState(state);
      final tracksets = await _db.getEnrichedTracksets();
      yield state.copyWith(tracksets: tracksets);
    } catch (ex) {
      yield TrackingErrorState(
        state,
        description: 'Failed to load trackset list',
        failedEvent: event,
      );
    }
  }
}

export 'tracking.event.dart';
export 'tracking.state.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:prtmobile/db/db.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/utils/normalization.dart';

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
    } else if (event is TracksetCreated) {
      yield* _mapTracksetCreatedToState(event);
    }
  }

  Stream<TrackingState> _mapTracksetsRequestedToState(
    TracksetsRequested event,
  ) async* {
    try {
      yield TrackingLoadingState(state);
      final tracksets = await _db.getEnrichedTracksets();
      // ignore: todo
      // TODO: sort tracksets
      yield state.copyWith(tracksets: tracksets);
    } catch (ex) {
      yield TrackingErrorState(
        state,
        description: 'Failed to load trackset list',
        failedEvent: event,
      );
    }
  }

  Stream<TrackingState> _mapTracksetCreatedToState(
    TracksetCreated event,
  ) async* {
    try {
      yield TrackingLoadingState(state);

      final trackset = Trackset(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: event.value.name,
        startAt: event.value.dateRange.start,
        endAt: event.value.dateRange.end,
      );

      var tracksets = state.tracksets.entities;
      tracksets.add(trackset);
      tracksets.sort(
        (a, b) => a.startAt.compareTo(b.startAt) * -1,
      );
      final normalized = normalizeTracksets(tracksets);

      await _db.insertTrackset(trackset);

      yield TrackingUpdatedState(
        state.copyWith(tracksets: normalized),
        isAfterTracksetCreated: true,
      );
    } catch (ex) {
      yield TrackingErrorState(
        state,
        description: 'Failed to add trackset',
        failedEvent: event,
        shouldShowNotification: true,
      );
    }
  }
}

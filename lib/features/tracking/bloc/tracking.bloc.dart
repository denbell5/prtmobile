export 'tracking.event.dart';
export 'tracking.state.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:prtmobile/features/store/store.dart';
import 'package:prtmobile/features/tracking/tracking.dart';

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
    } else if (event is TracksetEdited) {
      yield* _mapTracksetEditedToState(event);
    } else if (event is TracksetsDeleted) {
      yield* _mapTracksetsDeletedToState(event);
    } else if (event is TrackCreated) {
      yield* _mapTrackCreatedToState(event);
    } else if (event is TrackEdited) {
      yield* _mapTrackEditedToState(event);
    } else if (event is TracksDeleted) {
      yield* _mapTracksDeletedToState(event);
    } else if (event is SubtracksDeleted) {
      yield* _mapSubtracksDeletedToState(event);
    } else if (event is SubtrackCreated) {
      yield* _mapSubtrackCreatedToState(event);
    } else if (event is SubtrackEdited) {
      yield* _mapSubtrackEditedToState(event);
    } else if (event is TracksetSoAdded) {
      yield* _mapTracksetSoAddedToState(event);
    }
  }

  Stream<TrackingState> _mapTracksetsRequestedToState(
    TracksetsRequested event,
  ) async* {
    try {
      yield TrackingLoadingState(state);
      var normalized = await _db.getEnrichedTracksets();
      var tracksets = normalized.entities;
      tracksets.sort(
        (a, b) => a.startAt.compareTo(b.startAt) * -1,
      );
      normalized = normalizeTracksets(tracksets);
      yield TrackingUpdatedState(
        state.copyWith(tracksets: normalized),
      );
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

  Stream<TrackingState> _mapTracksetEditedToState(
    TracksetEdited event,
  ) async* {
    try {
      yield TrackingLoadingState(state);

      var trackset = state.tracksets.byId[event.value.id]!;
      trackset = trackset.copyWith(
        name: event.value.name,
        startAt: event.value.dateRange.start,
        endAt: event.value.dateRange.end,
      );

      var normalized = state.tracksets.set(trackset, id: trackset.id);
      var tracksets = normalized.entities;
      tracksets.sort(
        (a, b) => a.startAt.compareTo(b.startAt) * -1,
      );
      normalized = normalizeTracksets(tracksets);

      await _db.updateTrackset(trackset);

      yield TrackingUpdatedState(
        state.copyWith(tracksets: normalized),
        isAfterTracksetEdited: true,
      );
    } catch (ex) {
      yield TrackingErrorState(
        state,
        description: 'Failed to save trackset',
        failedEvent: event,
        shouldShowNotification: true,
      );
    }
  }

  Stream<TrackingState> _mapTracksetsDeletedToState(
    TracksetsDeleted event,
  ) async* {
    try {
      yield TrackingLoadingState(state);

      var normalized = state.tracksets;
      for (var id in event.ids) {
        normalized = normalized.remove(id);
      }

      var tracksets = normalized.entities;
      tracksets.sort(
        (a, b) => a.startAt.compareTo(b.startAt) * -1,
      );
      normalized = normalizeTracksets(tracksets);

      await _db.deleteTracksets(event.ids.toList());

      yield TrackingUpdatedState(
        state.copyWith(tracksets: normalized),
        isAfterTracksetsDeleted: true,
      );
    } catch (ex) {
      yield TrackingErrorState(
        state,
        description: 'Failed to delete tracksets',
        failedEvent: event,
        shouldShowNotification: true,
      );
    }
  }

  Stream<TrackingState> _mapTracksetSoAddedToState(
    TracksetSoAdded event,
  ) async* {
    try {
      yield TrackingLoadingState(state, isAddingTracksetSo: true);

      final trackset = event.tracksetSo.toTrackset(dateRange: event.dateRange);
      final tracksets = state.tracksets.set(trackset, id: trackset.id);

      await _db.insertTracksetEnriched(trackset);

      yield TrackingUpdatedState(
        state.copyWith(tracksets: tracksets),
        isAfterTracksetSoAdded: true,
        updatedTrackset: trackset,
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

  Stream<TrackingState> _mapTrackCreatedToState(
    TrackCreated event,
  ) async* {
    try {
      yield TrackingLoadingState(state);

      final track = Track(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        tracksetId: event.tracksetId,
        name: event.value.name,
      );

      var trackset = state.tracksets.byId[event.tracksetId]!;
      final tracks = trackset.tracks.set(track, id: track.id);
      trackset = trackset.copyWith(tracks: tracks);
      final tracksets = state.tracksets.set(trackset, id: trackset.id);

      await _db.insertTrack(track);

      yield TrackingUpdatedState(
        state.copyWith(tracksets: tracksets),
        isAfterTrackCreated: true,
      );
    } catch (ex) {
      yield TrackingErrorState(
        state,
        description: 'Failed to add track',
        failedEvent: event,
        shouldShowNotification: true,
      );
    }
  }

  Stream<TrackingState> _mapTrackEditedToState(
    TrackEdited event,
  ) async* {
    try {
      yield TrackingLoadingState(state);

      var trackset = state.tracksets.byId[event.tracksetId]!;

      var track = trackset.tracks.byId[event.trackId]!;
      track = track.copyWith(name: event.value.name);
      final tracks = trackset.tracks.set(track, id: track.id);

      trackset = trackset.copyWith(tracks: tracks);
      final tracksets = state.tracksets.set(trackset, id: trackset.id);

      await _db.updateTrack(track);

      yield TrackingUpdatedState(
        state.copyWith(tracksets: tracksets),
        isAfterTrackEdited: true,
      );
    } catch (ex) {
      yield TrackingErrorState(
        state,
        description: 'Failed to save track',
        failedEvent: event,
        shouldShowNotification: true,
      );
    }
  }

  Stream<TrackingState> _mapTracksDeletedToState(
    TracksDeleted event,
  ) async* {
    try {
      yield TrackingLoadingState(state);

      var trackset = state.tracksets.byId[event.tracksetId]!;

      var normalized = trackset.tracks;
      for (var id in event.ids) {
        normalized = normalized.remove(id);
      }

      trackset = trackset.copyWith(tracks: normalized);
      final tracksets = state.tracksets.set(trackset, id: trackset.id);

      await _db.deleteTracks(event.ids.toList());

      yield TrackingUpdatedState(
        state.copyWith(tracksets: tracksets),
        isAfterTracksDeleted: true,
      );
    } catch (ex) {
      yield TrackingErrorState(
        state,
        description: 'Failed to delete tracks',
        failedEvent: event,
        shouldShowNotification: true,
      );
    }
  }

  Stream<TrackingState> _mapSubtracksDeletedToState(
    SubtracksDeleted event,
  ) async* {
    try {
      yield TrackingLoadingState(state);

      var trackset = state.tracksets.byId[event.tracksetId]!;
      var track = trackset.tracks.byId[event.trackId]!;

      var normalized = track.subtracks;
      for (var id in event.ids) {
        normalized = normalized.remove(id);
      }

      track = track.copyWith(subtracks: normalized);
      trackset = trackset.copyWith(
        tracks: trackset.tracks.set(track, id: track.id),
      );
      final tracksets = state.tracksets.set(trackset, id: trackset.id);

      await _db.deleteSubtracks(event.ids.toList());

      yield TrackingUpdatedState(
        state.copyWith(tracksets: tracksets),
        isAfterTracksDeleted: true,
      );
    } catch (ex) {
      yield TrackingErrorState(
        state,
        description: 'Failed to delete tracks',
        failedEvent: event,
        shouldShowNotification: true,
      );
    }
  }

  Stream<TrackingState> _mapSubtrackCreatedToState(
    SubtrackCreated event,
  ) async* {
    try {
      yield TrackingLoadingState(state);

      final subtrack = Subtrack(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        trackId: event.trackId,
        start: event.value.start!,
        end: event.value.end!,
        pointer: event.value.start!,
      );

      var trackset = state.tracksets.byId[event.tracksetId]!;
      var track = trackset.tracks.byId[event.trackId]!;
      final subtracks = track.subtracks.set(subtrack, id: subtrack.id);

      track = track.copyWith(subtracks: subtracks);
      final tracks = trackset.tracks.set(track, id: track.id);
      trackset = trackset.copyWith(tracks: tracks);
      final tracksets = state.tracksets.set(trackset, id: trackset.id);

      await _db.insertSubtrack(subtrack);

      yield TrackingUpdatedState(
        state.copyWith(tracksets: tracksets),
        isAfterSubtrackCreated: true,
      );
    } catch (ex) {
      yield TrackingErrorState(
        state,
        description: 'Failed to add subtrack',
        failedEvent: event,
        shouldShowNotification: true,
      );
    }
  }

  Stream<TrackingState> _mapSubtrackEditedToState(SubtrackEdited event) async* {
    try {
      yield TrackingLoadingState(state, isEditingSubtrack: true);

      var trackset = state.tracksets.byId[event.tracksetId]!;
      var track = trackset.tracks.byId[event.trackId]!;
      final subtrack = track.subtracks.byId[event.subtrackId]!.copyWith(
        start: event.value.start,
        end: event.value.end,
        pointer: event.value.pointer,
      );
      final subtracks = track.subtracks.set(subtrack, id: subtrack.id);
      track = track.copyWith(subtracks: subtracks);
      final tracks = trackset.tracks.set(track, id: track.id);
      trackset = trackset.copyWith(tracks: tracks);
      final tracksets = state.tracksets.set(trackset, id: trackset.id);

      await Future<void>.delayed(const Duration(seconds: 1));
      await _db.updateSubtrack(subtrack);

      yield TrackingUpdatedState(
        state.copyWith(tracksets: tracksets),
        isAfterSubtrackEdited: true,
      );
    } catch (ex) {
      yield TrackingErrorState(
        state,
        description: 'Failed to edit subtrack',
        failedEvent: event,
        shouldShowNotification: true,
        isSubtrackEditFailed: true,
      );
    }
  }
}

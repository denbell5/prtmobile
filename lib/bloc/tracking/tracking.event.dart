import 'package:prtmobile/features/subtrack/subtrack.dart';
import 'package:prtmobile/features/subtrack/subtrack_create/subtrack_create.dart';
import 'package:prtmobile/features/track/create/track_create.dart';
import 'package:prtmobile/features/track/edit/track_edit.dart';
import 'package:prtmobile/features/trackset/create/trackset_create.dart';
import 'package:prtmobile/features/trackset/edit/trackset_edit.dart';

abstract class TrackingEvent {}

class TracksetsRequested extends TrackingEvent {}

class TracksetCreated extends TrackingEvent {
  final TracksetCreateValue value;

  TracksetCreated(this.value);
}

class TracksetEdited extends TrackingEvent {
  final TracksetEditValue value;

  TracksetEdited(this.value);
}

class TracksetsDeleted extends TrackingEvent {
  final Set<String> ids;

  TracksetsDeleted(this.ids);
}

class TrackCreated extends TrackingEvent {
  final TrackCreateValue value;
  final String tracksetId;

  TrackCreated({
    required this.value,
    required this.tracksetId,
  });
}

class TrackEdited extends TrackingEvent {
  final TrackEditValue value;
  final String trackId;
  final String tracksetId;

  TrackEdited({
    required this.value,
    required this.trackId,
    required this.tracksetId,
  });
}

class TracksDeleted extends TrackingEvent {
  final Set<String> ids;
  final String tracksetId;

  TracksDeleted({
    required this.ids,
    required this.tracksetId,
  });
}

class SubtracksDeleted extends TrackingEvent {
  final Set<String> ids;
  final String trackId;
  final String tracksetId;

  SubtracksDeleted({
    required this.ids,
    required this.trackId,
    required this.tracksetId,
  });
}

class SubtrackCreated extends TrackingEvent {
  final SubtrackCreateValue value;
  final String tracksetId;
  final String trackId;

  SubtrackCreated({
    required this.value,
    required this.tracksetId,
    required this.trackId,
  });
}

class SubtrackEdited extends TrackingEvent {
  final SubtrackFormValues value;
  final String subtrackId;
  final String trackId;
  final String tracksetId;

  SubtrackEdited({
    required this.value,
    required this.subtrackId,
    required this.trackId,
    required this.tracksetId,
  });
}

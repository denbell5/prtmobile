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

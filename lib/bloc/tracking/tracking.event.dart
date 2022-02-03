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

import 'package:prtmobile/features/trackset/create/trackset_create.dart';

abstract class TrackingEvent {}

class TracksetsRequested extends TrackingEvent {}

class TracksetCreated extends TrackingEvent {
  final TracksetCreateValue value;

  TracksetCreated(this.value);
}

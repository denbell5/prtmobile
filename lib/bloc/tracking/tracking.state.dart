import 'package:equatable/equatable.dart';
import 'package:prtmobile/bloc/tracking/tracking.bloc.dart';
import 'package:prtmobile/models/models.dart';

class TrackingState extends Equatable {
  final NormalizedList<Trackset, String> tracksets;

  TrackingState.initial() : tracksets = NormalizedList.createEmpty();

  const TrackingState({
    required this.tracksets,
  });

  TrackingState.fromState(TrackingState state) : tracksets = state.tracksets;

  TrackingState copyWith({
    NormalizedList<Trackset, String>? tracksets,
  }) {
    return TrackingState(
      tracksets: tracksets ?? this.tracksets,
    );
  }

  @override
  List<Object?> get props => [tracksets];
}

class TrackingErrorState extends TrackingState {
  final String description;
  final TrackingEvent failedEvent;
  final bool shouldShowNotification;
  final bool isSubtrackEditFailed;

  TrackingErrorState(
    TrackingState state, {
    required this.description,
    required this.failedEvent,
    this.shouldShowNotification = false,
    this.isSubtrackEditFailed = false,
  }) : super.fromState(state);
}

class TrackingLoadingState extends TrackingState {
  final bool isEditingSubtrack;

  TrackingLoadingState(
    TrackingState state, {
    this.isEditingSubtrack = false,
  }) : super.fromState(state);
}

class TrackingUpdatedState extends TrackingState {
  final bool isAfterTracksetCreated;
  final bool isAfterTracksetEdited;
  final bool isAfterTracksetsDeleted;
  final bool isAfterTrackCreated;
  final bool isAfterTrackEdited;
  final bool isAfterTracksDeleted;
  final bool isAfterSubtrackCreated;
  final bool isAfterSubtrackEdited;

  TrackingUpdatedState(
    TrackingState state, {
    this.isAfterTracksetCreated = false,
    this.isAfterTracksetEdited = false,
    this.isAfterTracksetsDeleted = false,
    this.isAfterTrackCreated = false,
    this.isAfterTrackEdited = false,
    this.isAfterTracksDeleted = false,
    this.isAfterSubtrackCreated = false,
    this.isAfterSubtrackEdited = false,
  }) : super.fromState(state);

  @override
  List<Object?> get props => [
        ...super.props,
      ];
}

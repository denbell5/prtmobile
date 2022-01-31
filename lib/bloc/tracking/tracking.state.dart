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

  TrackingErrorState(
    TrackingState state, {
    required this.description,
    required this.failedEvent,
    this.shouldShowNotification = false,
  }) : super.fromState(state);
}

class TrackingLoadingState extends TrackingState {
  TrackingLoadingState(
    TrackingState state,
  ) : super.fromState(state);
}

class TrackingUpdatedState extends TrackingState {
  final bool isAfterTracksetCreated;
  final bool isAfterTracksetEdited;

  TrackingUpdatedState(
    TrackingState state, {
    this.isAfterTracksetCreated = false,
    this.isAfterTracksetEdited = false,
  }) : super.fromState(state);

  @override
  List<Object?> get props => [
        ...super.props,
      ];
}

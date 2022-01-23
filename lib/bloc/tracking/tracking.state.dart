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

  TrackingErrorState(
    TrackingState state, {
    required this.description,
    required this.failedEvent,
  }) : super.fromState(state);
}

import 'package:equatable/equatable.dart';
import 'package:prtmobile/features/store/store.dart';

class TrackingStoreState extends Equatable {
  final List<TracksetSo> tracksets;
  final bool isInitialized;

  const TrackingStoreState({
    required this.tracksets,
    required this.isInitialized,
  });

  TrackingStoreState.initial()
      : tracksets = [],
        isInitialized = false;

  TrackingStoreState.fromState(TrackingStoreState state)
      : tracksets = state.tracksets,
        isInitialized = state.isInitialized;

  @override
  List<Object?> get props => [tracksets, isInitialized];

  TrackingStoreState copyWith({
    List<TracksetSo>? tracksets,
    bool? isInitialized,
  }) {
    return TrackingStoreState(
      tracksets: tracksets ?? this.tracksets,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}

class TrackingStoreLoadingState extends TrackingStoreState {
  TrackingStoreLoadingState(TrackingStoreState state) : super.fromState(state);
}

class TrackingStoreUpdatedState extends TrackingStoreState {
  TrackingStoreUpdatedState(TrackingStoreState state) : super.fromState(state);
}

class TrackingStoreErrorState extends TrackingStoreState {
  final String description;
  final TrackingStoreEvent failedEvent;
  final bool shouldShowNotification;

  TrackingStoreErrorState(
    TrackingStoreState state, {
    required this.description,
    required this.failedEvent,
    this.shouldShowNotification = false,
  }) : super.fromState(state);
}

import 'package:equatable/equatable.dart';

class TrackingPath extends Equatable {
  final String tracksetId;
  final String trackId;
  final String subtrackId;

  const TrackingPath({
    required this.tracksetId,
    required this.trackId,
    required this.subtrackId,
  });

  @override
  List<Object?> get props => [tracksetId, trackId, subtrackId];
}

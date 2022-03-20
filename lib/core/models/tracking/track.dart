import 'package:equatable/equatable.dart';
import 'package:prtmobile/core/core.dart';

class Track extends Equatable {
  final String id;
  final String tracksetId;
  final String name;
  final NormalizedList<Subtrack, String> subtracks;

  Track({
    required this.id,
    required this.tracksetId,
    required this.name,
    NormalizedList<Subtrack, String>? subtracks,
  }) : subtracks = subtracks ?? NormalizedList.createEmpty<Subtrack, String>();

  Track copyWith({
    String? id,
    NormalizedList<Subtrack, String>? subtracks,
    String? name,
  }) {
    return Track(
      id: id ?? this.id,
      name: name ?? this.name,
      tracksetId: tracksetId,
      subtracks: subtracks ?? this.subtracks,
    );
  }

  @override
  List<Object?> get props => [id, tracksetId, name, subtracks];

  int get length =>
      subtracks.entities.fold(0, (sum, subtrack) => sum += subtrack.length);
  int get done =>
      subtracks.entities.fold(0, (sum, subtrack) => sum += subtrack.done);
  int get left =>
      subtracks.entities.fold(0, (sum, subtrack) => sum += subtrack.left);
}

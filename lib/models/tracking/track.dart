import 'package:equatable/equatable.dart';
import 'package:prtmobile/models/models.dart';

class Track extends Equatable {
  final String id;
  final String name;
  final NormalizedList<Subtrack, String> subtracks;

  const Track({
    required this.id,
    required this.name,
    required this.subtracks,
  });

  Track copyWith({
    NormalizedList<Subtrack, String>? subtracks,
  }) {
    return Track(
      id: id,
      name: name,
      subtracks: subtracks ?? this.subtracks,
    );
  }

  @override
  List<Object?> get props => [id, name, subtracks];

  int get length =>
      subtracks.entities.fold(0, (sum, subtrack) => sum += subtrack.length);
  int get done =>
      subtracks.entities.fold(0, (sum, subtrack) => sum += subtrack.done);
  int get left =>
      subtracks.entities.fold(0, (sum, subtrack) => sum += subtrack.left);
}

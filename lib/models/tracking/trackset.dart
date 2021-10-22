import 'package:equatable/equatable.dart';
import 'package:prtmobile/models/models.dart';

class Trackset extends Equatable {
  final String id;
  final String userId;
  final String name;
  final DateTime startAt;
  final DateTime endAt;
  final NormalizedList<Track, String> tracks;

  Trackset({
    required this.id,
    this.userId = 'user',
    required this.name,
    required this.startAt,
    required this.endAt,
    NormalizedList<Track, String>? tracks,
  }) : tracks = tracks ?? NormalizedList.createEmpty<Track, String>();

  Trackset copyWith({
    NormalizedList<Track, String>? tracks,
  }) {
    return Trackset(
      id: id,
      userId: userId,
      name: name,
      startAt: startAt,
      endAt: endAt,
      tracks: tracks ?? this.tracks,
    );
  }

  @override
  List<Object?> get props => [id, userId, name, startAt, endAt, tracks];
}

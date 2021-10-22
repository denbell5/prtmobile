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
}

class SubtrackRange extends Equatable {
  final int start;
  final int end;
  final int pointer;

  const SubtrackRange({
    required this.start,
    required this.end,
    required this.pointer,
  });

  @override
  List<Object?> get props => [start, end, pointer];
}

class Subtrack extends SubtrackRange {
  final String id;

  const Subtrack({
    required this.id,
    required int start,
    required int end,
    required int pointer,
  }) : super(
          start: start,
          end: end,
          pointer: pointer,
        );

  @override
  List<Object?> get props => [...super.props, id];

  SubtrackRange get range => SubtrackRange(
        start: start,
        end: end,
        pointer: pointer,
      );
}

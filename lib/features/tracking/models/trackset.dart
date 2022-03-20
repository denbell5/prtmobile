import 'package:equatable/equatable.dart';
import 'package:prtmobile/core/core.dart';

import 'models.dart';

class Trackset extends Equatable {
  final String id;
  final String userId;
  final String name;
  final DateTime startAt;
  final DateTime endAt;
  final NormalizedList<Track, String> tracks;
  final bool isDeleted;

  Trackset({
    required this.id,
    this.userId = 'user',
    required this.name,
    required DateTime startAt,
    required DateTime endAt,
    NormalizedList<Track, String>? tracks,
    this.isDeleted = false,
  })  : startAt = toDateOnly(startAt),
        endAt = toDateOnly(endAt),
        tracks = tracks ?? NormalizedList.createEmpty<Track, String>();

  Trackset copyWith({
    NormalizedList<Track, String>? tracks,
    String? name,
    DateTime? startAt,
    DateTime? endAt,
    bool? isDeleted,
  }) {
    return Trackset(
      id: id,
      userId: userId,
      name: name ?? this.name,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      tracks: tracks ?? this.tracks,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        startAt,
        endAt,
        tracks,
        isDeleted,
      ];

  int get totalDays => endAt.difference(startAt).inDays + 1;

  bool hasStarted([DateTime? today]) {
    var _today = toDateOnly(today ?? DateTime.now());
    return !_today.isBefore(startAt);
  }

  bool hasEnded([DateTime? today]) {
    var _today = toDateOnly(today ?? DateTime.now());
    return _today.isAfter(endAt);
  }

  bool isActive([DateTime? today]) {
    return hasStarted(today) && !hasEnded(today);
  }

  int daysPassed([DateTime? today]) {
    if (!hasStarted(today)) {
      return 0;
    } else if (hasEnded(today)) {
      return totalDays;
    } else {
      final _today = toDateOnly(today ?? DateTime.now());
      return _today.difference(startAt).inDays;
    }
  }

  int daysLeft([DateTime? today]) {
    if (!hasStarted(today)) {
      return totalDays;
    } else if (hasEnded(today)) {
      return 0;
    } else {
      final _today = toDateOnly(today ?? DateTime.now());
      return endAt.difference(_today).inDays + 1;
    }
  }

  int get length =>
      tracks.entities.fold(0, (sum, track) => sum += track.length);
  int get done => tracks.entities.fold(0, (sum, track) => sum += track.done);
  int get left => tracks.entities.fold(0, (sum, track) => sum += track.left);

  int get dailyGoal {
    final _daysLeft = daysLeft();
    if (_daysLeft == 0) {
      return 0;
    }
    return (left / _daysLeft).ceil();
  }
}
